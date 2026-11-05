---
title: "Rust worktrees, sccache and build performance"
date: "2026-11-03"
categories: [rust, cargo, sccache, git-worktrees]
---
# Rambling

- I just want a good workflow for wokring iwht large cargo packges on worktrees
- Particualrly conerning about are
  - cold tests or builds that may take a long time on worktrees when the pre-warm cache exiisnt on the main worktree 
  - to avoid unnecessary cold builds or tests when working on linked work trees
- I heard that sscache is a good too get around this
- so i want to make sure to document a workflow that prevents unnecessary cold tests/builds/compiles... etc

# New Vocab

## 2. `target` folder

- `/target` - this is the folder that cargo will output its build and cache artificats too
  - Its comparable to the DBT `/target` folder 
  - It is comparable Next.js' `/.next` fodler (not to be confused with the `/out` fodler which contians the final static export
  - It has a few subfolders that amtter to use
    - `/target/release` - this is final build files so this is comaprable to next.js `/out` this is gerneated by `cargo build --release` (compiles slow but runs fast)
    - `/target/debug` - output of a plan `cargo build` - compiles fast but runs slow
    - `/target/deps` - hold compiled dependencies, which is most a cold build and waht `sccache` can share
    - `/target/incremental` - caches own crates which incrementally. first build cache initialize cache for each crate

## 2. Files and modules primer

- Within a workspace there are two types of files
  - `toml` and `lock` files whicha re config files
  - `rs` rust code base
    - `.rs` code lives in a few packge folders `src/`, `tests/`, `examples/` or `/benches`
- Rust code take the form of either
  - crate roots 
    - special file names - `src/lib.rs` (one library crate)
    - `src/main.rs` and each `src/bin/*.rs` → binary crates
    - `src/test/*.rs` declare integration tests tests
    - others
  - any other rs file are modules declared wiht the `mod` sytnax
- Files are any file within the `src` folder
- `module` is an organizational concept to reference specific chunks of atomic code logic
- Each module has a `path`  - there are two types of paths relative and abosulte
  - `absolute path` from the **crate** root
    - `crate::parser::fast::parse`
  - `relative path` - relative to which **module** you are
    - `fast::parse` form inside `parser` or `super::` to go up one level



```
● my-workspace/               ← workspace root
  ├── Cargo.toml              ← [workspace] members = ["mylib", "mycli"]
  ├── Cargo.lock              ← shared by all packages
  ├── target/                 ← shared build output + cache
  ├── mylib/                  ← package "mylib"
  │   ├── Cargo.toml          ← name = "mylib"
  │   ├── src/
  │   │   ├── libr.rs          ← library crate root: mod parser;
  │   │   ├── parser.rs       ← module parser: mod fast;
  │   │   └── parser/
  │   │       └── fast.rs     ← module parser::fast → fn parse
  │   └── tests/
  │       └── api.rs          ← integration test crate "api"
  └── mycli/                  ← package "mycli"
      ├── Cargo.toml          ← name = "mycli", depends on mylib
      └── src/
          └── main.rs         ← binary crate root, calls mylib::parser::fast::parse
```



- so analyzing the work tree above for paths
  - **Module** `mylib/src/parser/fast.rs`
    - Absolute path (starts at `lib.rs`)
      - Module: `crate::parser::fast`
      - Function: `crate::parser::fast::<function-name>`
      - Test: `crate::parser::fast::tests::<test-name>`
    - Relative path (starts at `parser.rs` - its parent module)
      - Module: `fast`
      - Function: `fast::<function-name>`
      - Test: `fast::test::<test-name>`
    - **Crates** `mylib/src/libr.rs`
      - Absolute path `crate` 
      - From another crate its `mylib`
        - this is for libary crates
        - packges can refernece other pacakges library carte (one only iwht the apckag name like `mylib`)
        - packages cannot use other packages binaries (.exe)

## 3. Test primer

- A test name is the test functions full path such as `parser::tests::parses_empty`
- There are several types of tests
  - `unit tests` sit inline in `src/` files inside a  `mod tests`
  - `integration tests`  are files in the packages' `test/` folder
    - each of those files is its own crate, which `--test <file` selects
  - Both kinds are `#[test]` functions, so both have names
  - `cargo test parses` runs every test whos name contains parses



## 4. What is `sccache` 

- `sccache` is a rust tool that keeps one shared dependency compilation across worktrees
- use it to prevent cold-recompile of dpendneces across worktrees
- It does not effect the crate compilation for your workspace

# Understanding

- Triage  - guess there are some core concepts i need to know before we cna really put things together Core questions 1 - How Cargo handles cache and efficient builds
  - Core Questions 1 - How Cargo handles cache and efficient builds 
  - Core questions 2 - How Cargo handles cache and efficient tests
  - Core questions 3 - How work trees introduce unnecessary cold computes
  - Core questions 4 - How can we mitigate unnecessary cold computes for worktree workflows
- Core Questions 1 - How Cargo handles cache and efficient builds
  - `cargo build` only compiles crates
  - so a workspace has many crates - lets say 50 crates
  - first time - cold build
    - when you run cargo build for the first time
    - each crate gets  compiled the results are stored in targets/incremental and the outputs int o target/debug
  - now the development starts
    - lets say that one crate code base is changed
    - you want to build it so you run cargo build
    - cargo will be smart enough to look at a `target` artifact (`target/debug/.fingerprint/`) in  as a reference to see what crates have changed
    - then only compile for the crates that have changed (and all the crates that depend on it)
- Core questions 2 - How Cargo handles cache and efficient tests
  - `cargo test` does a few things
    - first it runs a build process (seperate test version of crate) - so a prior carogo build doesnt cover it 
    - then it runs  all tests (regardless if a crate has changed or not)
    - so you have to narrow it yourself with 
      - package filters : `-p <pacakge>` 
      - crate fitlers: --lib, --bin &lt;name&gt; or --test &lt;name&gt; for one crate
      - test name
  - So the test version build is incremental
    - the first test will compile the crates in scope, plus dependencies
    - then int he future target willd etect what crates ahve chagneds codebase 
      - only that crate and its ocnsumers' tests willbe test-compiled
  - but the test is going to run on everything (its not incremental) - test only relies on package, crate and test name filters

- Core questions 3 - How work trees introduce unnecessary cold computes
  - For cargo workspaces that have a lot of crates
  - Cargo builds incrementally for the main build and the test build, and cahces upstream dpeneiceis
  - however when we are working on worktrees. each new linked worktree only gets the files that are under version control 
  - Since `target` is gitignore; new linekd worktrees will not get that folder or the artifacts within the main worktree's `target` folder - importaltn not eh fingerprint or incremental fodler or the compiled dpendiceis which allows incrememtal builds to work
  - as a result un-mitigated, new linked trees and build or test would have to re-compile the crates (and hte huge upstream depenicesi)  from scratch for the first build or test - taking a long time
  - This introduces uncesary cold computes
    - crates need to be re-compiled
    - usptrema dpenciesn are compield fromt heir source again
- Core questions 4 - How can we mitigate unnecessary cold computes for worktree workflows
  - Firstly implment `sccache` beuase it stops  the uncesary ocmpaitlion dependencie source code for worktree build and test calls
  - In terms of compilations
    - A first full recompile is unavaiodable (with defualt cargo icnrmeimetnal set to on); one full compile per worktree is unavaibaldable
    - once its done its incrememtnal
    - On worktree creation, prebuild int he background with    `cargo test --no-run` (add `cargo build` only if you runt he binary - e.g. harness testing)
  - In terms of tests
    - use the  proper filters in work trees
    - only run  your packges and their consumer tests, let CI runt he whol e wworkspace


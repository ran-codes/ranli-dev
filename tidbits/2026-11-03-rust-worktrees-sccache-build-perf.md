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

# Understanding

- Triage  - guess there are some core concepts i need to know before we cna really put things together
  - Core questions 1 - How Cargo handles cache and efficient builds/tests
  - Core questions 2 - How work trees introduce unnecessary cold computes
  - Core questions 3 - What is scaches
- Prep - New glossary terms added
  - `/target` - this is the folder that cargo will output its build and cache artificats too
    - Its comparable to the DBT `/target` folder 
    - It is comparable Next.js' `/.next` fodler (not to be confused with the `/out` fodler which contians the final static export
    - It has a few subfolders that amtter to use
      - `/target/release` - this is final build files so this is comaprable to next.js `/out` this is gerneated by `cargo build --release` (compiles slow but runs fast)
      - `/target/debug` - output of a plan `cargo build` - compiles fast but runs slow
      - `/target/deps` - hold compiled dependencies, which is most a cold build and waht `sccache` can share
      - `/target/incremental` - caches own crates which incrementally. first build cache initialize cache for each crate


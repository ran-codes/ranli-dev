---
title: "Rust build vs compilation, and working in worktrees with sccache"
date: "2026-11-06"
categories: [rust, cargo, sccache, git-worktrees]
draft: true
---
# 1. Ramblings

- rust has compilation then build
- iw ant t konw the idferinces
- the efect of tec sucha s sccache on rust wokr in worktrees
- i want atbles of conidioatn and worktres and scenairoes to fully udnrestand

# 2. Understanding



## 2.1 Steps


| #   | Step    | Does                                               | Includes |
| --- | ------- | -------------------------------------------------- | -------- |
| 1   | Compile | Builds parts                                       | —        |
| 2   | Build   | Links parts together into binaries (final product) | Compile  |
| 3   | Test    | Build test program, run checks                     | Build    |


### 2.1.1 Possible outputs


| Output                                 | Kind                  | What it is                         | Runs on                            |
| -------------------------------------- | --------------------- | ---------------------------------- | ---------------------------------- |
| Executable (`.exe` on Windows)         | Binary                | Finished program you run           | One OS and chip                    |
| `.wasm`                                | Binary or library     | Program for browsers               | Any OS                             |
| Shared library (`.dll`/`.so`/`.dylib`) | Library               | Library loaded when a program runs | One OS and chip                    |
| `.rlib`                                | Part (compile output) | Library only Rust can use          | One OS, chip, and compiler version |


- Crate level `cargo build -p <crate-name>`
  - the `-p` standads for package
- Program level (a workspace can ahve many progreams) 
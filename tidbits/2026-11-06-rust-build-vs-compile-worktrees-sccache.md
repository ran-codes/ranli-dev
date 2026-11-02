---
title: "Rust build vs compilation, and working in worktrees with sccache"
date: "2026-11-06"
categories: [rust, cargo, sccache, git-worktrees]
---
# 1. Ramblings

- rust has compilation then build
- iw ant t konw the idferinces
- the efect of tec sucha s sccache on rust wokr in worktrees
- i want atbles of conidioatn and worktres and scenairoes to fully udnrestand

# 2. Understanding

- Triage
  - So I think i asked great questions above
  - They are very 'fundamental' questions - the answers to which require a fundamental working baseline vocabulary of Rust workflows to even begin to answer
  - I first initialized a basic super simple rust glossary in this site
  - From there we will triage and answer the rambling questions from above
- Breakdown/rephrase: first lets isolate the specific questions or points of confusion
  - Core question 1: Compilation vs Build
  - Core question 2: Worktrees and Sccache

### 2.1 Core Question 1: Compilation vs Build

- Compilation or compiling within the Rust/Cargo workflows is a step.
  - This takes rust code and builds an output artifact (which could be a exe or rlib or wasm or other artifacts); These are artifacts can be consumed/used by various operating systems
- Build is a specific Cargo command `cargo build` which does a few steps for a speicifed scope of work
  - Build can be specified to work at the worspace level, at a program level or at a crate level
  - it then within the scope sepcific does a two main steps
    - Firstly it compiles all the crates that is within the scope
    - Then it Links the individual crate output artifacts into a single develoerable artifact as specificed 
- So in summary
  - Compilation is a step
  - Build is a process/command that calls compilation

### 2.2 Core Question 2: Worktrees and Sccache and perofmrance in rust/cargo

- So


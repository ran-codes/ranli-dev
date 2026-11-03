---
title: "Rust worktrees, sccache and build performance"
date: "2026-11-03"
categories: [rust, cargo, sccache, git-worktrees]
---
# Rambling

- I just want a good workflow for wokring iwht large cargo packges on worktrees
- Particualrly conerning about are
  - cold tests or builds that may take a long time on worktrees when the pre-warm cache exiisnt on the main worktree 
  - to avoid unecesary cold builds or tests when working on linked work trees
- I heard that sscache is a good too get around this
- so iwa tn to amke sure to docuemtn a workflow that prenve uncesary cold tests/builds/compiles... etc

# Understanding

- 

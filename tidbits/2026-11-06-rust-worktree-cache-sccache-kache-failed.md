---
title: "Rust worktree cache friction: why sccache and kache didn't work for us"
date: "2026-11-06"
categories: [rust, cargo, sccache, kache, git-worktrees]
---
# Ramblings

- so we wrote  `2026-11-03-rust-worktrees-sccache-build-perf.md` a few days ago
- its basic research about worktree workflows in rust/cargo development
- then we tried to impelment it in one of our prohejcts `loom-datawarehouse` and it didnt go accrodingly to plan
  - espcailly the `sccache` which theroetical seems to amke ense but fo rosme reson didnt work
    - Linking PR for reference
      - Implemting scache [https://github.com/ran-codes/loom-warehouse/pull/30](https://github.com/ran-codes/loom-warehouse/pull/30)
      - realizing it doesnt wont then adding another pore-warm mitigaiton workfow - [https://github.com/ran-codes/loom-warehouse/pull/39](https://github.com/ran-codes/loom-warehouse/pull/39)
- and thne we tried anotehr method `kache` prust pacakge. which also didnt work
- endedupw itht he conflusiona sof now
  - there isn't a great tooling for windwos rust worktree work
- here we jsut not try to solve ht problme but jsut try to undresatnd why sscache didn't work for dbt-oss fork



# Reference/Vocab

```
cargo asks sccache to compile a crate
│
├─ Own crate (dbt-schemas, dbt-adapter…)?
│   └─ yes → not cached, always compiles
│
└─ Dependency (parquet 50.0) → make its ID tag:
      parquet 50.0 + compiler flags + folder path
      │
      ├─ worktree-A: ...parquet + C:\repo\worktree-A → tag 7f3a
      └─ worktree-B: ...parquet + C:\repo\worktree-B → tag 91c2
            │
            Is tag 91c2 on the shelf?
            ├─ yes → cache hit: reuse saved copy (fast)
            └─ no → cache miss: compile, save under 91c2
                    ← every new worktree ends up here

Shelf after both worktrees build:
  7f3a → parquet compiled in worktree-A
  91c2 → parquet compiled in worktree-B   ← same code, saved twice
```

**Vocab**

- **Cache**: a shelf of saved compiled dependencies
- **Lookup key (ID tag)**: points to one saved copy of one dependency
  - Computed from crate version, flags, and folder path
  - Same inputs → same tag, every time
  - New folder → new tag → no match
- **Compiler flags**: the build settings passed to the compiler
- **Folder path**: where the worktree lives on disk
- **Cache hit / miss**: tag found → reuse; not found → compile



# Understanding

- So sscache works by using a ID-tag caleld -Lookup Key that is linked to each depencny
  - this tag take into a
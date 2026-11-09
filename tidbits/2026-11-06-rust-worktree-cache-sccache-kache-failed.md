---
title: "Rust worktree cache friction: why sccache and kache didn't work for us"
date: "2026-11-06"
topics: [rust]
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
      ├─ main:     ...parquet + C:\repo\loom-warehouse → tag 7f3a
      ├─ linked-1: ...parquet + C:\repo\wt-1          → tag 91c2
      └─ linked-2: ...parquet + C:\repo\wt-2          → tag c48e
            │
            Is tag c48e on the shelf?
            ├─ yes → cache hit: reuse saved copy (fast)
            └─ no → cache miss: compile, save under c48e
                    ← every new worktree ends up here

Lookup keys (parquet only):
  main:      C:\repo\loom-warehouse\target\debug\deps\libparquet  → 7f3a
  linked-1:  C:\repo\wt-1\target\debug\deps\libparquet            → 91c2
  linked-2:  C:\repo\wt-2\target\debug\deps\libparquet            → c48e

Shelf after all three build:
  7f3a → parquet compiled in main
  91c2 → parquet compiled in linked-1
  c48e → parquet compiled in linked-2   ← same code, saved 3 times
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



## Core Question answered

- A deicison tree is printed above along wiht new covabulary needed to understnaind the symptom
- So sscache works by using a ID-tag caleld -Lookup Key that is linked to each depencny-folder-path
- the reason why scache doesnt work for worktrees is  because the dpeenceis folder path is dffernt across worktrees
- So even tohught `paruqet on main worktree`  is cache `parquet on new worktree diff path` is not ocnsidere cache ebcuase the fodler apth si part of the cache lookup
- Thats why sccache doesnt work for worktrees



## Ideation

- Pitch idea
  - This being the case
  - Sccache is still incredimble valuable as the depencie compaitlion is abig chunk fo rht eocmpaitlion time.
  - Is there a way we can use a just script or a sscacahe config to just tell scchace to not include path in the lookup key? or can we manipulat eth oloopup key withinna proejct like loom-datawarehouse to only unitilzie on path across allw orktrees?
    - would this solve the problem
    - is this feasible
    - shoudl we do it for loomwarhouse
- CC intiial evalution
  - for dbt-loom sccahce onyl saved about 60 seconds forma  300 sec build. so not a huge lever
  - also try shared path for wotkree but the conflict becuae overwiting dbt.exe and contaiinaing `dbt.exe` across worktrees
  - so dont impelment for now!



&nbsp;
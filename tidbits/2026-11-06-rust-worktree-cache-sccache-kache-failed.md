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
- and thne we tried anotehr method `kache` prust pacakge. which also didnt work
- endedupw itht he conflusiona sof now
  - there isn't a great tooling for windwos rust worktree work
- here we jsut not try to solve ht problme but jsut try to undresatnd why sscache didn't work

 

# Understanding



&nbsp;

&nbsp;

---



# References
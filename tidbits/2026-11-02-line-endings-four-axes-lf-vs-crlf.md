---
title: "Line endings on four axes: LF vs CRLF, repo vs local, .gitattributes, and the refresh"
date: "2026-11-02"
categories: [git, line-endings, gitattributes, windows]
---
# 1. Ramblings

- Some of the repos i am working on that have prettier in the checks workflow keeps popping up with this same bug
- its cosmetic but still  bother to deal with
- i can fix it with claude but dont understand fully yet.
- I believe there are a few axis
  - 1) its not a bug - just a cosmetic thing
  - 2) LF vs CRLF
  - 3) local vs origin
  - 4) git command to fix it  `git rm -r --cached -q :/ && git reset --hard`
- so these are things i want to learn
- probably need to init a git/github glossary along the way.

# 2. Understanding

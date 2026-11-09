---
title: "Claude Code"
description: "Sessions, turns, tool calls, and what happens when you type while Claude is working."
date-modified: "2026-11-09"
---
Terms follow the [Claude Code docs](https://code.claude.com/docs/en/interactive-mode) ([commands](https://code.claude.com/docs/en/commands)). Terms that are not official are marked *informal*. Behaviors confirmed by hand are marked *tested* and link to the tidbit that tested them.

## Session

| Term | Meaning |
|---|---|
| session | One open Claude Code window, holding one conversation |
| context | What Claude remembers in this session. `/clear` wipes it |
| turn | One round: you send → Claude works → Claude replies. A turn is made of tool calls and reading any text you typed in the meantime. A skill call always starts a new turn |
| busy / idle (*informal*) | Busy = a turn is running. Idle = no turn running. A background tool call does not keep Claude busy |

## Tool calls

| Term | Meaning |
|---|---|
| tool call | One action inside a turn (Bash, Read, Edit, …). A turn can have many |
| foreground tool call | The default. The turn waits for it to finish, so Claude stays busy. To force it, say "wait for it" |
| background tool call | Runs on its own, outside the turn; the turn ends without it, so Claude is idle. A Bash command goes to the background when you ask, when you press `Ctrl+B`, when it times out, or when it is banned in the foreground (e.g. `sleep`) |
| AskUserQuestion | A tool call that asks you something and does not finish until you answer. The turn stays busy while the question is pending (*tested*, [tidbit](/tidbits/2026-11-06-does-clear-queue/)) |

## Commands

| Term | Meaning |
|---|---|
| slash command | Anything typed as `/something`. Either a built-in (`/clear`, `/compact`, `/model`) or a skill from a plugin or the user (`/dev-log`) |
| skill | A custom slash command defined in a plugin or `.claude/skills`. Running one starts a new turn |

## Typing while Claude works

Two questions decide what happens to anything you type:

1. **Is Claude busy?** Busy = a turn is running. Idle = no turn running. A background tool call does not count; a pending AskUserQuestion does.
2. **What did you type?** Plain text, or a slash command.

| | Text | Slash command |
|---|---|---|
| **Idle** | runs now | runs now |
| **Busy** | joins the current turn, at the next gap between tool calls | waits; runs after the turn ends |

So mid-turn, text always runs before a queued slash command, whatever order you typed them.

| Term | Meaning |
|---|---|
| queue | One list of everything you typed mid-turn, in the order you typed it |
| text, queued | Handed to Claude at the next gap between tool calls, inside the current turn. So it is answered before the turn ends, and before any queued slash command — whatever order you typed them (*tested*, [tidbit](/tidbits/2026-11-06-does-clear-queue/)) |
| slash command, queued | Waits in the list and runs after the current turn ends, as its own step. A pending AskUserQuestion keeps the turn alive, so a queued `/clear` waits for your answer (*tested*, [tidbit](/tidbits/2026-11-06-does-clear-queue/)) |
| text, during a pending question | Taken as the answer to the question, not queued (*tested*, [tidbit](/tidbits/2026-11-06-does-clear-queue/)) |
| immediate commands | A few built-ins never queue: `/status`, `/tasks`, `/usage` |
| send now | `Ctrl+Enter` or `Ctrl+X Ctrl+S` sends queued input right away instead of waiting. `Up` from an empty input box takes queued items back into the box |

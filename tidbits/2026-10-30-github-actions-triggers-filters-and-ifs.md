---
title: "GitHub Actions triggers, filters and ifs"
date: "2026-10-30"
categories: [github-actions, ci, git]
---
## Rambling/understanding

- Okay so its really important to understand how GitHub action are controlled (aka when they run!)
- From my understanding there are a few axis involve
  - Scope: Workflow vs Job
    - A single GitHub action YAML contains the information for a single workflow run
    - A workflow can have multiple jobs
    - Control can be implemented on both levels
  - Workflow level control
    - Where a workflow runs is controlled by two components: Triggers-Filters
    - **Triggers** are actions that happen on GitHub (see supplementary table below for details)
      - main
      - PR
      - manual run trigger (aka dispatch maybe)
      - others
    - **Filters** are more granular things that are add to trigger
      - These include (see supplementary table below for details)
        - paths
        - branches
      - Use cases
        - For example a common thing is if the trigger  change on `main` you can configure more sepcificayll that not jsut an change on `main` but sepcifical onyl on change sot as pecific path on main juchs as `main > /quarto` so only when the quarot foder is changed on the `main` branch
    - Job Level control
      - Here we can level the triggers and filters at the job level
        - Sot he same stuff as above okay. the workflow runs but we can utilzie th same trigger-filter to detemrien whether a sepcific job within the file runs or not
      - in addition we can level **job level** ifnormaiton (see supplementary table below for details)
        - E.g. only run job 1 if job 2 is successuful; if job 1 fails then job 2 does not run
        - 
- The best practice is to when desinging when your aciotns run si to be very sepcific so you dont waste computing minutes
  - If a workflow can be skipped - set workflow level controls to skip it
  - If specific jobs can be skiped impelmetn the right contrls to skip it!
- 
- Happy Actions!!!



## Details/References

### Common triggers

Docs: [Events that trigger workflows](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows)

| Trigger             | Fires when                                                | Example use                 |
| ------------------- | --------------------------------------------------------- | --------------------------- |
| `push`              | Commits land on a branch or tag                           | Deploy on merge to `main`   |
| `pull_request`      | A PR is opened or updated                                 | Test or render before merge |
| `workflow_dispatch` | Someone clicks "Run workflow" (or runs `gh workflow run`) | Manual redeploy             |
| `schedule`          | A cron time is reached                                    | Nightly data refresh        |
| `release`           | A release is published                                    | Publish a package           |
| `workflow_call`     | Another workflow calls this one                           | Reusable build steps        |

Note: `main` is not a trigger on its own. It is `push` plus a `branches: [main]` filter.

### Filters

Docs: [Using filters](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow#using-filters), [`branches`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#onpull_requestpull_request_targetbranchesbranches-ignore), [`paths`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#onpushpull_requestpull_request_targetpathspaths-ignore)

| Filter                         | Narrows by                              | Works on                                        |
| ------------------------------ | --------------------------------------- | ----------------------------------------------- |
| `branches` / `branches-ignore` | Branch name                             | `push`, `pull_request` (the PR's target branch) |
| `tags` / `tags-ignore`         | Tag name                                | `push`                                          |
| `paths` / `paths-ignore`       | Files changed                           | `push`, `pull_request`                          |
| `types`                        | Activity type (e.g. `opened`, `closed`) | `pull_request`, `release`, `issues`             |
| `cron`                         | Time                                    | `schedule`                                      |
| `inputs`                       | Values passed at launch                 | `workflow_dispatch`, `workflow_call`            |

Note: `paths` does not work on `workflow_dispatch` or `schedule`.

### Job-level control

Docs: [`jobs.<job_id>.if`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idif), [`jobs.<job_id>.needs`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds), [Status check functions](https://docs.github.com/en/actions/reference/workflows-and-actions/expressions#status-check-functions), [`jobs.<job_id>.environment`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idenvironment)

| Control           | What it does                                     | Example                               |
| ----------------- | ------------------------------------------------ | ------------------------------------- |
| `if:`             | Runs the job only when a condition is true       | `if: github.ref == 'refs/heads/main'` |
| `needs:`          | Waits for other jobs; skipped if one fails       | `needs: build`                        |
| `if: success()`   | Runs when every needed job passed (the default)  | Deploy after tests pass               |
| `if: failure()`   | Runs only when a needed job failed               | Send an alert                         |
| `if: always()`    | Runs no matter what                              | Cleanup                               |
| `environment:`    | Waits for an approval or protection rule         | Manual sign-off before deploy         |

## Appendix A - References
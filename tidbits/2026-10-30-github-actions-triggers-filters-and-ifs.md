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
    - Triggers are actions that happen on GitHub 
      - main
      - PR
      - manual run trigger (aka dispatch maybe)
      - others
    - Filters are more granular things that are add to trigger
      - These include
        - paths
      - Use cases
        - For exmaples a common thing is if the trigger  change on `main` you can configure more sepcificayll that not jsut an change on `main` but sepcifical onyl on change sot as pecific path on main juchs as `main > /quarto` so only when the quarot foder is changed on the `main` branch
    - Job Level control
      - Here we can level the triggers and filters at the job level
        - Sot he same stuff as above okay. the workflow runs but we can utilzie th same trigger-filter to detemrien whether a sepcific job within the file runs or not
      - in addition we can level job level ifnormaiton
        - E.g. only run job 1 if job 2 is successuful; if job 1 fails then job 2 does not run
        - 

- The best practice is to when desinging when your aciotns run si to be very sepcific so you dont waste computing minutes
  - If a workflow can be skipped - set workflow level controls to skip it
  - If specific jobs can be skiped impelmetn the right contrls to skip it!
- Happy Actions!!!



### Quick References

## Appendix A - References

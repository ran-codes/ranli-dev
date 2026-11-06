---
title: "GROUP BY ALL in DuckDB, and why dbt v2 parses your SQL"
date: "2026-11-06"
categories: [duckdb, dbt, sql]
---
# Rambling

- one of the benefits of dbt-v2 si that here  sql parsers before the dbt run starts
- I epxeireinces this and it was funny/novel interesting form UX (as a ananylsitscs/data engineer perpsective)
  - working on a dbt v2 ropejct wiht duckdb
  - the proejct had `GROUP BY *` which is undocuemnt syntax in both duckdb abd dbt aprsers
  - so when we did tbdt run it threw  warning (it ran btu htrew  warning) form dbt
- So this is jsut me prcoessing this and wrapping my head around the ideaof pre run dbt aprser



# Understanding

- So now SQL gets two gates (in dbt-v2)
  - gate 1 - is the dbt parser
  - gate 2 - is the database engine running the query
- before we onl hya failrue points at gate 2 
- now we have failture poitns at gate 1 wihtou a filel run `dbt parse`
- the takeway is to listne to:
  - always urn dbt aprse before dbt run as now there are huge benefts to SQL QC
  - second to wlays read and dunresatdn the wanrings and erors fomr dbt parse before doing dbt run (this greatly improves the codebase!)
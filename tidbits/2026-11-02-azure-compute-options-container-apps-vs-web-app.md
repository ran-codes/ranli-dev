---
title: "Azure compute options: Container Apps vs Web App, and their AWS equivalents"
date: "2026-11-02"
categories: [azure, aws, container-apps, app-service]
---
## 1. Ramblings

- Tried to deploy a server a azure to test out foundry-commjs for a POC; but IT blocked me from deploying Azure "Cotainer Apps" but I could deploy a "Web App"
- I realized i did't know the different between teh two
- Just wnat to get a high elvel udnresntand of the didfrernces



## 2. Understanding



- Both have simialir specs endpoints, dockers/fexilbity, scalability
- The major difference is billing
  - Web Apps is fixed plan (always on - no cold starts)
  - Container apps is consumption (pay per uses, scales to zero whne not in use - but has cold starts)
- web apps is also slight easier to use
  - doenst have to use dockers, can jsut ship code
    - but can use docekrs if neeeded
  - container apps require dockers

## Appendix A - References

---
title: "rig v0.11 - initial breakdown"
date: "2026-11-06"
categories: [r, rig, tooling]
---
# Rambling



- so posit just dropped rig v0.11 which apparently is a big deal because rig now managnes not jsut r verison but also r packages and projects; this makes it a super versitile tool that didnt exsitnig i th epost ecosytem befroe and relaly only esiting as a commutniy uvr package
- they dropped a thre part blog post aout this
  - R installations - [https://opensource.posit.co/blog/2026-10-09_rig-0-11-0-part-one/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DsIZMY7HVSuBkFUcmSe_228qu8tlT1Zq_q6plrmFKRdYl3tH0JDsTWhQJV3jrKvLOdKm81ZHagkmyawr8regy1BRL0V3FiqdJQaOwg0XA5s](https://opensource.posit.co/blog/2026-10-09_rig-0-11-0-part-one/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DsIZMY7HVSuBkFUcmSe_228qu8tlT1Zq_q6plrmFKRdYl3tH0JDsTWhQJV3jrKvLOdKm81ZHagkmyawr8regy1BRL0V3FiqdJQaOwg0XA5s)
  - R Packages - [https://opensource.posit.co/blog/2026-10-12_rig-0-11-0-part-two/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DkXVKrP40XoLMNXUs7xDzuBKN8BI3eADi03ydxzjV4sYJIENtBYNVHI80MBe-\_ngMiQgBOculS6gzifluHc-eLq3-JiK-6nmFHIQ7BVfjSQ](https://opensource.posit.co/blog/2026-10-12_rig-0-11-0-part-two/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DkXVKrP40XoLMNXUs7xDzuBKN8BI3eADi03ydxzjV4sYJIENtBYNVHI80MBe-_ngMiQgBOculS6gzifluHc-eLq3-JiK-6nmFHIQ7BVfjSQ)
  - R projects - [https://opensource.posit.co/blog/2026-10-15_rig-0-11-0-part-three/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DbvRH3b5q12idkOUvapnuL_ftiQE5c6UVCVQiCjm_XtNS6RFhDHifpfo2XcIlVHsNmZD5ciL2x5Egz1SBXX3raIXhTv1a0fJceaddPIVMKg](https://opensource.posit.co/blog/2026-10-15_rig-0-11-0-part-three/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DbvRH3b5q12idkOUvapnuL_ftiQE5c6UVCVQiCjm_XtNS6RFhDHifpfo2XcIlVHsNmZD5ciL2x5Egz1SBXX3raIXhTv1a0fJceaddPIVMKg)
- intiail impressio si that is fundamentall cahgesna lot of how R systmes are manged and a serioius contender to replace UVR
- This is new thing that willinfomr my opition on R system amnagement that was coverd in previous psots
  - [https://ranli.dev/tidbits/2026-10-12-r-package-and-env-management-renv.html](https://ranli.dev/tidbits/2026-10-12-r-package-and-env-management-renv.html)
  - [https://ranli.dev/tidbits/2026-10-21-uvr-test-drive/](https://ranli.dev/tidbits/2026-10-21-uvr-test-drive/)
- some queions
  - does this repalce uvr
  - i get R installs and packages but what are R projects in rig  (wahts hte utilty ? is r rpeojcts manged in uvr as well or not?)
  - how epxirement is the uspport of pack/proj (is it epxeirmental lable is it stable)
    - to inform if its owrht swithcing now or jsut wait for a more GA lable for htese fetures
- Approahc
  - you know this is really one of those times where i am not sure how to approach this
  - should i raw dog it and feed it to an agent and ask quesitons like i suueally do - untill i have good understanidng
  - or sohuld i jsut read the blogs
  - how about lets do a hyrbid have the agent read it provide me bulletpoints to review then then i do my usualy question to learn type thing

# Understanding



---

# References

## 1. Agent Bullet Points (make a toggle colabspoible later)


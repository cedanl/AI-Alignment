---
layout: default
title: AI Policy - Who evaluates the AI
nav_order: 99
---


**AI Evaluation Policy — Netherlands & Europe**

**Last verified: 2026-09-01.**

Due to the high velocity of change AI is used to keep track. 
Please make contact if you believe any of the content is incorrect or misstated.

> **Summary — How the Netherlands will consume AI benchmarks, and how EU policy makes that possible.**
>
> This document documents a division of labor: the Netherlands regulates *deployers*, while
> model-capability evaluation migrates to the EU (Section 4, gap row). Nothing in Dutch policy
> establishes a national AI-capability benchmark (see the callout below); instead the state
> builds compliance regimes — the Cbw/NIS2 duties on ~8,000 organizations
> [[1](https://www.ncsc.nl/cyberbeveiligingswet-nis2/zorgplicht)], the IBP FO normenkader for
> schools, auditable norms and the Algoritmeregister under the NDS, and openness/provenance
> criteria for model procurement (Section 1).
>
> **Consumption today is indirect:** AIVD intelligence and AP breach statistics are the only
> Dutch quantitative AI-threat signals, while capability findings arrive from UK/US institutes
> (AISI, CAISI) and the International AI Safety Report (Sections 5, 7).
>
> **Consumption from 2026–27 becomes structured EU policy:** the AI Office holds enforceable
> evaluation powers over GPAI providers (since 2 Aug 2026; fines to €35M/7%), is mandated to
> build "benchmarks for evaluating capabilities," and runs the Dutch regulatory sandbox; the
> Action Plan's evaluation-capacity call (operational 2027) plus ENISA's frontier-AI blueprint
> give the Netherlands state-grade capability measurement without building its own AISI — the
> EU's evaluation results will carry legal force where AISI's only inform guidance
> [[AI Office](https://digital-strategy.ec.europa.eu/en/policies/ai-office), [Action Plan](https://digital-strategy.ec.europa.eu/en/library/eu-action-plan-cybersecurity-and-artificial-intelligence)]
> — see Section 3, "The 2027 evaluation buildout in detail."
>
> The Netherlands' own contribution is compliance infrastructure, not model evaluation:
> supervision (AP/RDI), sandboxes, and the 2027/2030 education mandates (Sections 1–2).
> Sections 4–7 trace each hop of this benchmark→policy→deployer loop.

> **⚠ Key finding — Gap: no Dutch AI-capability benchmark.** Nothing in the verified Dutch
> policy corpus in this file establishes a public Dutch benchmark of AI offensive/defensive
> capability (full analysis: Section 4, final row). The closest Dutch instruments are
> compliance-side: **TNO's AI Oversight Lab** assesses government algorithms for *bias,
> fairness, and legal compliance* — not frontier-model capability — with real cases (IND risk
> model, Nissewaard fraud-model takedown) [[TNO AI Oversight Lab](https://www.tno.nl/en/digital/artificial-intelligence/ai-oversight-lab/)],
> and the only national AI "testing" instrument from the standards body NEN is a Dutch
> Technical Agreement limited to *non-discrimination in profiling algorithms* (public
> consultation Mar–Apr 2026) [[NEN NTA](https://www.nen.nl/consultatie-gestart-voor-nederlandse-technische-afspraak-over-profileringsalgoritmes)].
> The Netherlands is also absent from every enumeration of national AI-capability evaluators
> (the AISI-model institutes: first wave Japan/UK/US plus five followers)
> [[arXiv:2410.09219](https://arxiv.org/abs/2410.09219)], and the 30-country International AI
> Safety Report confirms governments broadly "struggle to build sufficient technical capacity"
> for AI-risk evidence generation [[IASR 2026](https://internationalaisafetyreport.org/publication/international-ai-safety-report-2026)].
> Capability evaluation is therefore delegated to the EU (operational 2027) and consumed from
> UK/US institutes — see Sections 4–7.

---

## 1. Dutch policy in general

| **Item** | **What it says / does** | **Why it matters here** | **Source** |
|----|----|----|----|
| **International AI Strategy** (03-07-2026) | Cabinet-level strategy (submitted to the House of Representatives by the foreign-affairs, foreign-trade, and digital-economy ministers) on a safe, fair, responsible AI transition. Names AI's dual role: strengthener of cyber resilience and defence innovation, but also an accelerant for criminals and hostile states attacking digital infrastructure and spreading disinformation at scale. Three action lines: diplomacy in Brussels and beyond, new like-minded coalitions, and strengthening European AI capacity to reduce dependency on non-European providers. | Direct policy counterpart to the *Defensive Robustness* domain: the Dutch state explicitly frames AI-enabled cyberattack and disinformation as a national-security risk and treats AI sovereignty as economic security. | [[News item](https://www.government.nl/latest/news/2026/07/03/international-strategy-for-safe-and-responsible-ai-transition), [strategy PDF](https://www.government.nl/site/binaries/site-content/collections/documents/2026/07/03/international-ai-strategy/international-ai-strategy.pdf)] |
| **Pax Silica membership** (signed 24-06-2026) | The Netherlands formally joined the Pax Silica alliance — a coalition of key players in the AI and chip industries — to strengthen economic security "from critical raw materials to the finished product" and retain its leading global chip-sector role. The European Commission and other member states stated intent to join. | AI supply-chain security at state level; complements the *Supply chain (AI)* glossary term and the LiteLLM incident in the events table. | [[Government.nl news](https://www.government.nl/latest/news/2026/06/24/the-netherlands-joins-pax-silica-alliance-and-boosts-cooperation-on-ai-and-chips)] |
| **AP warning: AI increases cyberattack risks** (08-07-2026) | The Dutch data protection authority (Autoriteit Persoonsgegevens, AP) warned that AI-driven phishing and data breaches now reinforce each other ("flywheel effect"): AI-generated phishing fed by breach data, in turn causing breaches. Account takeovers nearly tripled (607 in 2024 → 1,742 in 2025); 39,407 data breaches were reported in 2025, 2,428 caused by cyberattacks. Ready-made "phishing kits" lower the entry barrier. | The most concrete Dutch regulatory statement connecting AI to offensive security activity — maps directly to *sensitive information disclosure* and the AP's breach-report series. | [[AP news item](https://www.autoriteitpersoonsgegevens.nl/en/current/ai-increases-the-risks-of-cyberattacks), [Report data breaches 2025](https://www.autoriteitpersoonsgegevens.nl/en/documents/report-data-breaches-2025)] |
| **AP as coordinating AI supervisor** | The AP has been the coordinating market-surveillance authority for algorithms and AI since 2023 (via its Department for the Coordination of Algorithmic Oversight). Its role in EU AI Act supervision is not yet fully fixed; in May 2026 it issued (with the Authority for Digital Infrastructure, RDI) an advisory report on the Dutch AI Act supervisory structure. | The institutional backbone of Dutch AI enforcement; whoever supervises the AI Act in NL shapes what benchmarks and evidence the state will demand. | [[AP: Algorithms & AI](https://www.autoriteitpersoonsgegevens.nl/en/themes/algorithms-ai), [EU AI Act page incl. supervisory structure](https://www.autoriteitpersoonsgegevens.nl/en/themes/algorithms-ai/eu-ai-act)] |
| **AP enforcement actions (Aug 2026)** | Uber fined nearly €825 million over automated driver-blocking decisions; AP advised Twitch users to opt out of sharing data with Amazon's AI training. | Live demonstration that automated-decision systems (a core AI-security concern) are being policed in the Netherlands. | [[Uber fine](https://www.autoriteitpersoonsgegevens.nl/en/current/uber-fined-nearly-825-million-euros-for-automated-driver-blocking), [Twitch advisory](https://www.autoriteitpersoonsgegevens.nl/en/current/ap-advises-twitch-users-opt-out-from-sharing-data-with-amazon-ai)] |
| **AIVD intelligence picture** | The General Intelligence and Security Service (AIVD) publishes annual threat assessments and Cyber Threats & Advisories. The 2025 annual report (published 15-07-2026) documents ongoing threats to national security and the democratic rule of law; earlier advisories cover e.g. Russian state hackers targeting Signal/WhatsApp accounts. | The intelligence-side counterpart to benchmarks measuring offensive cyber capability — how the Dutch state sees real adversaries using (or facing) AI. | [[AIVD Annual Report 2025](https://english.aivd.nl/documents/2026/07/15/aivd-annual-report-2025), [Cyber Threats and Advisories](https://english.aivd.nl/topics/c/cyber-threats-and-advisories)] |
| **Government's own AI use** | The Government.nl editorial team operates under explicit AI-use rules: humans check all texts before publication, no personal or confidential data goes into AI tools, AI-suggested sources are manually verified, editors get responsible-AI training. | A small but instructive example of an AI-use policy as a security control — relevant when evaluating what "responsible deployment" means in practice. | [[Use of AI](https://www.government.nl/service/use-of-ai)] |
| **Cyberbeveiligingswet (Cbw / NIS2)** (in force 15-08-2026) | The Dutch implementation of the EU NIS2 directive, replacing the Wbni. Imposes duties on ~8,000 organisations providing essential or important services: mandatory registration at the NCSC, a 24-hour incident reporting duty to CSIRT and the supervisor, and **ten "zorgplicht" measures** — risk analysis, incident response, continuity/back-up, **supply-chain security**, cyber hygiene + training, secure system development (incl. vulnerability disclosure), personnel/access/asset security, MFA/passkeys, cryptography policy (incl. quantum-safe preparation), and **annual assessment of measure effectiveness**. Board-level accountability is explicit: a CISO and a member of the board must be involved. | The Netherlands' core operational cybersecurity law. Its supply-chain and effectiveness-assessment duties are the compliance-world versions of what *supply chain (AI)* benchmarks and periodic evals test — and it now covers organisations deploying AI systems in critical sectors. | [[NCSC: Cbw](https://www.ncsc.nl/cyberbeveiligingswet-nis2), [10 zorgplicht measures](https://www.ncsc.nl/cyberbeveiligingswet-nis2/zorgplicht), [law text (Stb. 2026-187)](https://zoek.officielebekendmakingen.nl/stb-2026-187.html)] |
| **Nederlandse Digitaliseringsstrategie (NDS), Priority 3: AI** | Government-wide digitalisation strategy ("1 overheid"): AI is embraced "without naivety." Commitments include government-wide **"(auditbare) normen voor AI-gebruik door de overheid"** (auditable norms for government AI use, incl. the algoritmekader and procurement guidance), an AI upscaling facility, a government-wide AI competence centre, and use of **GPT-NL or other open (Dutch/EU) language models** for priority use cases. | The Dutch state is building its own internal AI evaluation regime — auditable norms, a register, and open-model procurement — in lieu of public model benchmarks. | [[NDS Priority 3: AI](https://www.digitaleoverheid.nl/nederlandse-digitaliseringsstrategie-nds/6-prioriteiten-voor-een-overheid/prioriteit-3-artificiele-intelligentie/)] |
| **TNO exploration: open & European language models** (published 01-09-2026) | BZK-commissioned TNO report analysing government use of open and European language models. Proposes openness gradations (closed source / open weights / fully open) based on the European Source AI Index and the Model Openness Framework; recommendations feed further policy-making, with the explicit goal of avoiding "a risky strategic dependency in AI." | Sovereignty policy operationalized as model-selection criteria — openness and provenance stand in for independent security testing; connects to *model extraction* and *supply chain (AI)* glossary terms. | [[Digitale Overheid news](https://www.digitaleoverheid.nl/nieuws/verkenning-inzet-open-en-europese-taalmodellen-bij-overheid/), [TNO report](https://open.overheid.nl/details/6ba92fae-f8e6-48f0-a5d2-bf334b14ac5e)] |
| **Algoritmeregister + Algoritmekader** | The public **Algoritmeregister** (1,500+ government algorithms, including high-risk AI systems) documents how government algorithms work; the **Algoritmekader** sets requirements government organisations must apply when developing, purchasing, or using algorithms. Registration of high-risk AI in an EU database becomes mandatory under the AI Act from Aug 2026. | The Dutch "evaluation-by-transparency" infrastructure: instead of scoring models, the state mandates disclosure and auditability — a governance instrument parallel (not equivalent) to security benchmarks. | [[Algoritmeregister](https://algoritmes.overheid.nl/en)] |
| **Overheidsbrede visie Generatieve AI** (2024) | The cabinet-wide vision on generative AI: opportunities, risks, legislation/policy context, and actions to steer generative AI's societal impact. English translation available via Government.nl. | The foundational document from which the NDS AI priority and later strategies (International AI Strategy) grew — useful baseline when dating policy shifts. | [[Rijksoverheid (NL)](https://www.rijksoverheid.nl/documenten/2024/01/01/overheidsbrede-visie-generatieve-ai), [EN translation](https://www.government.nl/documents/parliamentary-documents/2024/01/17/government-wide-vision-on-generative-ai-of-the-netherlands)] |

## 2. Dutch education policy

| **Item** | **What it says / does** | **Why it matters here** | **Source** |
|----|----|----|----|
| **Veilige en goede ICT in het onderwijs** | National program for safe, well-organized school ICT: a shared base infrastructure (fast/secure internet, interoperability, single sign-on), built with sector bodies Edu-V (primary, secondary, MBO) and Npuls (higher education, MBO). Schools themselves are responsible for keeping their digital environment safe; the **Digitaal Veilig Onderwijs** program supports them. | The Dutch state's structural answer to schools being "somtimes the target of cyberattacks" — the policy context for the K-12 security news tracked in the glossary. | [[Rijksoverheid: Veilige en goede ICT](https://www.rijksoverheid.nl/onderwerpen/digitalisering-onderwijs/veilige-en-goede-ict-in-het-onderwijs)] |
| **IBP FO normenkader (deadlines)** | The normenkader *Informatiebeveiliging en Privacy voor Funderend onderwijs* sets concrete security measures (multifactor authentication, antivirus, staff phishing training). Timeline: schools must self-evaluate against the framework and have a compliance plan by **1 January 2027**; full compliance is planned to become mandatory by **2030**. The government monitors whether schools use the framework. | A dated, checkable mandate — the Dutch education analogue of a security benchmark, with its own evaluation methodology (self-evaluation against a norms framework). | [[Normenkader IBP FO](https://aanpakibp.kennisnet.nl/normenkader/), [Rijksoverheid page](https://www.rijksoverheid.nl/onderwerpen/digitalisering-onderwijs/veilige-en-goede-ict-in-het-onderwijs)] |
| **Digitale geletterdheid (digital literacy) in the curriculum** | Digital literacy — including secure passwords, working with data, and how algorithms work — is being embedded in the national curriculum via SLO's kerndoelen (final concept published Sept 2025). Expected legal effect: **1 August 2027**; schools have until **August 2031** to implement. Support via the Expertisepunt Digitale Geletterdheid, Kennisnet, and Onderwijskennis. | The security-awareness layer of Dutch education policy; the "how an algorithm works" curriculum goal is the closest state-level response to the AI-literacy gap surfaced in the education events table. | [[Rijksoverheid: Digitale geletterdheid](https://www.rijksoverheid.nl/onderwerpen/digitalisering-onderwijs/digitale-geletterdheid-op-school)] |

## 3. European policy

| **Item** | **What it says / does** | **Why it matters here** | **Source** |
|----|----|----|----|
| **EU AI Act** (Regulation (EU) 2024/1689) | The world's first comprehensive AI legal framework: risk-based rules (banned practices, high-risk obligations, transparency rules, minimal-risk free rein), phased application. Key dates after the **AI Omnibus** simplification (political agreement 7 May 2026, in force 27 July 2026): prohibitions + AI-literacy duties since 02-2025; GPAI rules since 08-2025; transparency rules from 08-2026; high-risk Annex III use cases (incl. **education**, employment, biometrics, critical infrastructure) from **2 Dec 2027**; product-embedded high-risk from **2 Aug 2028**. Omnibus additions: ban on AI 'nudification'/CSAM-generating systems (from Dec 2026), reinforced AI Office powers, SME/SMC simplifications, expanded regulatory sandboxes. | The baseline against which all Dutch AI policy (supervisory structure, sandbox, enforcement) is being organized; its education-specific provisions are the strongest policy lever on the education sector tracked in this project. | [[Commission: AI Act](https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai), [legal text](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32024R1689)] |
| **AI Act: education provisions** | AI systems used in education to determine access and life course (e.g., exam scoring) are **high-risk**, triggering risk assessment, data-quality, logging, human-oversight, and robustness/cybersecurity obligations. **Emotion recognition in education institutions is prohibited** outright. | Directly relevant to the education benchmark gap: the Act, not any benchmark, is currently the main check on AI in Dutch classrooms. | [[Commission: AI Act](https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai)] |
| **EU Action Plan on Cybersecurity and AI** (07-07-2026) | Coordinated EU approach to cybersecurity challenges from advanced AI: the Commission will launch a call to expand EU AI-model evaluation capacity (operational by 2027, strengthening third-party assessment feeding the AI Office's regulatory function); the Commission and ENISA will build a blueprint for secure access to advanced AI for cybersecurity purposes and a secure testing platform for critical sectors. | The EU-level counterpart to benchmark work: a state-backed evaluation infrastructure for AI models' cyber capabilities — directly parallel to what capability benchmarks measure. | [[EU Action Plan on Cybersecurity and AI](https://digital-strategy.ec.europa.eu/en/library/eu-action-plan-cybersecurity-and-artificial-intelligence)] |
| **GPAI Code of Practice & transparency guidance** (Jul 2025 / Jul 2026) | Voluntary GPAI compliance code (transparency, copyright, safety & security) plus Commission guidelines on transparency obligations and a Code of Practice on marking/labelling AI-generated content (incl. icons for deepfakes). | The compliance tooling behind Anthropic's watermarking move noted in the education events; transparency obligations from Aug 2026 affect any AI system used in Dutch education. | [[GPAI Code of Practice](https://digital-strategy.ec.europa.eu/en/policies/contents-code-gpai), [transparency guidelines](https://digital-strategy.ec.europa.eu/en/policies/guidelines-transparency-ai-generated-content)] |
| **AI Act Service Desk** | The Commission's single information platform and complaints channel for AI Act questions and support. | Practical entry point for compliance questions; complements the Dutch regulatory sandbox (launched Aug 2026) noted on the AP's EU AI Act page. | [[AI Act Service Desk](https://ai-act-service-desk.ec.europa.eu/en)] |
| **AP guidance on generative AI & GDPR** | Dutch-DPA guidance for lawful development/deployment of generative AI under the GDPR, including a prior-consultation assessment tool for Microsoft Copilot deployments. | Practical bridge between EU law and Dutch organizations deploying LLM systems — AppSec teams deploying AI should treat it as a requirements source. | [[Guidance generative AI and the GDPR](https://www.autoriteitpersoonsgegevens.nl/en/documents/guidance-generative-ai-and-the-gdpr)] |

#### The 2027 evaluation buildout in detail

The Action Plan's evaluation pillar is the EU's most benchmark-relevant policy development —
the institutionalization of model-capability evaluation as regulatory infrastructure. Its
components, each verified against primary sources:

- **The evaluation-capacity call itself.** The Commission will launch a call to expand EU AI-model evaluation capacity, expected operational by 2027, strengthening third-party assessment of frontier AI models and feeding the AI Office's regulatory function [[Action Plan library page](https://digital-strategy.ec.europa.eu/en/library/eu-action-plan-cybersecurity-and-artificial-intelligence), [press release](https://digital-strategy.ec.europa.eu/en/news/commission-presents-eu-action-plan-cybersecurity-and-artificial-intelligence), [factsheet](https://digital-strategy.ec.europa.eu/en/library/factsheet-action-plan-cybersecurity-and-artificial-intelligence)]. This is the EU's answer to the US/UK AISI model (Section 5): state-backed measurement of model capabilities, including cyber offense, as a regulatory instrument.
- **The AI Office's benchmark mandate is already live.** The AI Office (125+ staff, six units including a dedicated **"AI Safety" unit**) is tasked under the AI Act with "developing tools, methodologies and **benchmarks for evaluating capabilities**" of GPAI models and "classifying models with systemic risks" — and is currently recruiting ~40 enforcement agents (application deadline 8 Sept 2026) to staff that function [[AI Office](https://digital-strategy.ec.europa.eu/en/policies/ai-office)].
- **Enforcement powers give the benchmarks teeth.** Since 2 Aug 2026 the AI Office can require model access for evaluations, request corrective measures, and issue fines up to **€35 million or 7% of worldwide turnover** for prohibited practices; its enforcement page explicitly names "cyber offense" among the systemic risks covered and links the Action Plan [[enforcement framework](https://digital-strategy.ec.europa.eu/en/policies/enforcement-ai-act)]. Where AISI's evaluations inform guidance, the EU's will be legally enforceable.
- **ENISA's blueprint has its first artifact.** ENISA published *Cybersecurity in the Frontier AI Era* (7 Jul 2026) — initial recommendations for national authorities and defenders facing "machine-speed threats" — explicitly stating it will align to the Action Plan; the full **European Blueprint** for secure access to advanced AI and the secure-testing platform for critical sectors follow [[ENISA publication](https://www.enisa.europa.eu/publications/enisas-view-on-cybersecurity-in-the-frontier-ai-era), [ENISA AI topic page](https://www.enisa.europa.eu/topics/artificial-intelligence-and-next-gen-technologies)].
- **Expert Forum on Frontier AI (15 Jul 2026).** The AI Office convened 100+ experts (from developers, industry, academia, and Member States) to advise on EU competitiveness, sovereignty, and security in frontier AI; the report warns "the next one to two years could be decisive" and that the EU must strengthen its sovereign ability to "access, select, control, and benefit from" frontier models [[Expert Forum report](https://digital-strategy.ec.europa.eu/en/library/ai-office-publishes-frontier-ai-expert-findings-eu-competitiveness-sovereignty-and-security)]. This forum is the policy-side mirror of the capability-evaluation work in Section 5.
- **The compute base for evaluation.** The €30bn AI Gigafactories call (30 Jul 2026; up to seven facilities, €10bn public + €20bn private) provides the infrastructure that both frontier development and large-scale model evaluation will run on [[Gigafactories call](https://digital-strategy.ec.europa.eu/en/news/eu-launches-ai-gigafactories-call-boost-europes-computing-capacity-and-unlock-more-eu30-billion)].

Why this matters here: the buildout is the EU becoming a *producer* of the capability
evaluations the Netherlands consumes (Section 4, gap row). Unlike AISI's research-grade
evaluations, EU evaluation capacity feeds a regulatory function — benchmark results will
carry legal consequences for GPAI providers, making the EU the first jurisdiction where
AI capability measurement is directly tied to enforcement.

---

## 4. AI security benchmarks and how they relate to Dutch policy

Capability benchmarks measure **model/agent performance** (can it be jailbroken, does it write
vulnerable code, can it hack). Dutch policy instead measures **organizational compliance**
(can the operator prove control). The table below maps each capability-benchmark domain to its closest
Dutch policy hook and states honestly where the two regimes touch — and where they don't.

| **Benchmark / domain** | **Closest Dutch policy hook** | **Relationship** |
|----|----|----|
| **Defensive Robustness** (HarmBench-style jailbreak resistance) | **No direct hook.** The AP's AI-cyberattack warning [[1](https://www.autoriteitpersoonsgegevens.nl/en/current/ai-increases-the-risks-of-cyberattacks)] and AIVD threat assessments [[2](https://english.aivd.nl/documents/2026/07/15/aivd-annual-report-2025)] describe AI-enabled attacks, but no Dutch policy requires or performs jailbreak-resistance testing. The AP's breach statistics (account takeovers 607→1,742) are the closest thing to a Dutch quantitative metric of AI-assisted offense. | Gap: model-level attack resistance is measured only by benchmarks and (soon) the EU evaluation infrastructure, not by Dutch policy. Dutch law regulates the *deployer's* duty (Cbw zorgplicht, GDPR), never the *model's* robustness score. |
| **Secure Software Development / AppSec** (A.S.E, CyberSecEval insecure-code tests) | **Cbw zorgplicht measures 6 & 4** [[1](https://www.ncsc.nl/cyberbeveiligingswet-nis2/zorgplicht)]: secure acquisition/development/maintenance of systems incl. vulnerability handling, and supply-chain security. Plus NDS "auditabele normen" and procurement guidance for government AI use [[2](https://www.digitaleoverheid.nl/nederlandse-digitaliseringsstrategie-nds/6-prioriteiten-voor-een-overheid/prioriteit-3-artificiele-intelligentie/)]. | Adjacent, not equivalent: Cbw governs how organizations build and buy (process security), while A.S.E-style benchmarks test whether AI *models* generate vulnerable code (product security). A Dutch ministry buying AI coding tools would be bound by the former, not the latter. |
| **Agentic Autonomous Capability** (Cybench CTF, agent autonomy) | **EU Action Plan on Cybersecurity and AI** — EU AI-model evaluation capacity operational by 2027, secure-testing platform with ENISA [[1](https://digital-strategy.ec.europa.eu/en/library/eu-action-plan-cybersecurity-and-artificial-intelligence)]; **AI Office** enforcement over GPAI [[2](https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai)]; the **Dutch regulatory sandbox** (launched Aug 2026) [[3](https://www.autoriteitpersoonsgegevens.nl/en/themes/algorithms-ai/eu-ai-act)]. | The clearest institutionalization of benchmarking: the EU is building state-run evaluation of frontier models' cyber capabilities — the same thing Cybench measures, but as regulatory infrastructure. The Netherlands contributes the sandbox and supervisory structure rather than its own eval program. |
| **What benchmarks measure (models) vs. what policy measures (organizations)** | Cbw **measure 10** — "beoordeel de effectiviteit van maatregelen," annual assessment of security controls [[1](https://www.ncsc.nl/cyberbeveiligingswet-nis2/zorgplicht)]; IBP FO normenkader self-evaluation (schools, by 1 Jan 2027) [[2](https://aanpakibp.kennisnet.nl/normenkader/)]; **Algoritmeregister/Algoritmekader** disclosure-and-audit regime [[3](https://algoritmes.overheid.nl/en)]. | Three Dutch "benchmark-like" instruments, none of which test AI capability: Cbw assesses organizational controls, IBP FO assesses school ICT hygiene, and the register assesses transparency. The closest Dutch analogue to a *benchmark* is the IBP FO normenkader — a norms framework with deadlines and a defined self-evaluation methodology — but its object is school ICT, not AI. |
| **Model sovereignty / supply chain** (CyberMetric-style knowledge tests; *supply chain (AI)*) | **GPT-NL / open-EU-model preference** in the NDS and the TNO open-models report [[1](https://www.digitaleoverheid.nl/nieuws/verkenning-inzet-open-en-europese-taalmodellen-bij-overheid/)]; **Pax Silica** chips/AI economic-security alliance [[2](https://www.government.nl/latest/news/2026/06/24/the-netherlands-joins-pax-silica-alliance-and-boosts-cooperation-on-ai-and-chips)]. | Dutch policy substitutes *provenance and openness criteria* (where a model comes from, how open it is) for independent capability/security testing — openness grading stands in for the security assurance that benchmarks supply. |
| **Gap: no Dutch AI-capability benchmark** | Nothing in the verified Dutch policy corpus (International AI Strategy, NDS, Cbw, AP, AIVD publications) establishes a public Dutch benchmark of AI offensive/defensive capability. The state's threat picture comes from AIVD intelligence [[1](https://english.aivd.nl/topics/c/cyber-threats-and-advisories)] and breach statistics [[2](https://www.autoriteitpersoonsgegevens.nl/en/documents/report-data-breaches-2025)], and capability evaluation is being delegated to the EU level. | Observation for this project: the Netherlands is a *consumer* of AI-capability evaluation (via the AI Office, ENISA platform, sandboxes) and a *producer* of compliance/evaluation regimes for organizations. That division of labor is itself a finding worth tracking. |

The recurring pattern: Dutch policy responds to AI security through **duties on deployers**
(register, report, harden, audit, disclose) while **model capability evaluation migrates to
the EU level**. Capability benchmarks are the only instrument currently
measuring the model itself — which is why the EU Action Plan's evaluation buildout (2027)
is the single most benchmark-relevant policy development on either side of this file.

---

## 5. Governmental AI benchmarks and evaluation harnesses: research that actually measures AI performance

Section 4 showed that Dutch policy regulates deployers while model evaluation migrates to the
EU. This section documents who actually measures AI performance today: state-backed research
institutes, the benchmarks they run, and the **harnesses** (the software that executes models
against those benchmarks) they build — the operational layer beneath the capability-benchmark landscape.

### 5.1 State-backed evaluation institutions & programs

| **Institution / program** | **What it measures / does** | **Source** |
|----|----|----|
| **UK AI Security Institute (AISI)** | The first state-backed organisation dedicated to evaluating advanced AI capabilities and impacts; has tracked frontier models' cyber capabilities since 2023, publishing both methodology and results (unlike closed vendor leaderboards). | [[AISI](https://aisi.gov.uk/)] |
| **AISI cyber-gap analysis** (17-07-2026) | Quantified the open-vs-closed capability gap: 70 narrow cyber tasks across 4 difficulty tiers (technical non-expert → expert) plus autonomous cyber ranges. Finding: leading open-weight models (GLM-5.2, DeepSeek V4-Pro) trail the closed frontier by **4–7 months**, down from 6–10 months through 2025 — a shrinking "preparation time" window for defenders, feeding NCSC defensive-advantage guidance. | [[AISI blog](https://www.aisi.gov.uk/blog/how-far-behind-the-frontier-are-leading-open-weight-models-on-cyber)] |
| **AISI cyber ranges / multi-step attack research** (16-03-2026) | Purpose-built ranges measure *autonomous* end-to-end attack capability: a 32-step corporate-network attack and a 7-step industrial-control-system attack. Key results: performance scales **log-linearly with inference-time compute** (10M→100M tokens yields up to +59%, no plateau); each model generation outperforms its predecessor at fixed budgets (1.7 steps at 10M for GPT-4o in Aug 2024 → 9.8 for Opus 4.6 in Feb 2026). | [[AISI research page](https://www.aisi.gov.uk/research/measuring-ai-agents-progress-on-multi-step-cyber-attack-scenarios), [arXiv:2603.11214](https://arxiv.org/abs/2603.11214)] |
| **UK AISI / US CAISI joint assessment of Kimi K3** (23-07-2026) | First joint UK–US frontier-model capability evaluation: ExploitBench (Kimi K3 achieved arbitrary code execution on **0/41** vulnerabilities vs 20/41 average for frontier US models; safeguards did not block agentic exploit development) and the TLO range (step 17/32 vs 28.5 for leading US models). Capability aggregated across benchmarks via an **Item Response Theory**-inspired scoring approach. | [[AISI](https://www.aisi.gov.uk/blog/preliminary-assessment-of-kimi-k3s-cyber-capabilities), [NIST mirror](https://www.nist.gov/news-events/news/2026/07/uk-aisi-caisi-preliminary-assessment-kimi-k3s-cyber-capabilities)] |
| **CAISI (US NIST)** — Center for AI Standards and Innovation | Leads unclassified evaluations of US **and adversary** AI systems for national-security risks (cyber, bio, chem; backdoor checks); published full assessments of PRC open-weight models — GLM-5.2 (cyber capability similar to Opus 4.6; mixed safeguard results) and DeepSeek V4 Pro — with public methodology PDFs. Also researches evaluation integrity itself (see 5.3). | [[CAISI](https://www.nist.gov/caisi), [GLM-5.2 assessment](https://www.nist.gov/news-events/news/2026/07/caisi-assessment-zais-glm-52)] |
| **NIST AITE** (announced 27-07-2026) | Artificial Intelligence Technology Evaluation: a **sequestered testbed** where models are scored on blind data they cannot have trained on — infrastructure-level mitigation of train/test contamination, the harness-side answer to benchmark gaming. | [[NIST announcement](https://www.nist.gov/news-events/news/2026/07/announcing-nists-artificial-intelligence-technology-evaluation-aite)] |
| **NIST AI measurement & evaluation program** (incl. ARIA, NIST GenAI) | The US measurement-science backbone: metrics, testbeds, and challenge programs for evaluating AI (accuracy, robustness, security) — decades of metrology tradition applied to models. | [[NIST: AI measurement and evaluation](https://www.nist.gov/ai-measurement-and-evaluation)] |
| **EU evaluation capacity** (2027, cross-ref Section 3) | The EU Action Plan's AI-model evaluation buildout and the AI Office's enforcement powers are the EU's move into this same role — the institution the Netherlands is relying on instead of building its own AISI. Detailed component-by-component breakdown: Section 3, "The 2027 evaluation buildout in detail." | [[EU Action Plan](https://digital-strategy.ec.europa.eu/en/library/eu-action-plan-cybersecurity-and-artificial-intelligence), [AI Office](https://digital-strategy.ec.europa.eu/en/policies/ai-office)] |

### 5.2 Benchmarks and harnesses governments actually run

| **Instrument** | **What it measures** | **Government role** | **Source** |
|----|----|----|----|
| **Inspect** | Open-source **evaluation harness** (the software layer that executes models against benchmarks): 200+ pre-built evals, composable datasets/solvers/scorers, agent bridges to Claude Code / Codex CLI / Gemini CLI, Docker/K8s/Modal sandboxing for untrusted agent code. | Built and maintained by **UK AISI** — the reference example of a government building the harness layer, not just consuming scores. | [[Inspect docs](https://inspect.aisi.org.uk/), [code](https://github.com/UKGovernmentBEIS/inspect_ai)] |
| **ExploitBench** | Exploitation as a **capability ladder** (crash → arbitrary read/write → control-flow hijack → arbitrary code execution) on 41 real post-2023 V8 vulnerabilities; used as a headline metric in the UK AISI / CAISI Kimi K3 assessment. | Academic (Carnegie Mellon), adopted by two governments as a joint-eval metric. | [[arXiv:2605.14153](https://arxiv.org/abs/2605.14153)] |
| **AgentHarm** | Measures harmfulness/robustness of **LLM agents** on multi-stage harmful tasks (not chatbot refusals) — the agentic upgrade to HarmBench-style testing. | Co-authored by UK AISI researchers. | [[arXiv:2410.09024](https://arxiv.org/abs/2410.09024)] |
| **RepliBench** | Autonomous **replication** capabilities of LM agents (AI R&D self-improvement risk), decomposed into measurable sub-capabilities. | UK AISI research output. | [[arXiv:2504.18565](https://arxiv.org/abs/2504.18565)] |
| **AISI narrow-task suite + IRT scoring** | 96-task (70-task subset for comparability) suite spanning vulnerability research, reverse engineering, web exploitation, cryptography, aggregated into a single capability scale via Item Response Theory (400 points = 10x odds of solving). | UK AISI / CAISI methodology, published in full. | [[methodology in GLM-5.2 report](https://www.nist.gov/news-events/news/2026/07/caisi-assessment-zais-glm-52)] |

### 5.3 Harness science: governments researching the measurement instruments themselves

AISI maintains a dedicated **Science of Evaluations** research line — treating the benchmark
and harness as objects of study, not trusted ground truth:

- **HiBayES** — hierarchical Bayesian framework for evaluation statistics (small-sample, multi-task scoring) [[AISI](https://www.aisi.gov.uk/research/hibayes-a-hierarchical-bayesian-modeling-framework-for-ai-evaluation-statistics)]
- **Skewed Score** — statistical framework for assessing **autograders** (the model-graded scoring used inside harnesses) [[AISI](https://www.aisi.gov.uk/research/skewed-score-a-statistical-framework-to-assess-autograders)]
- **Bayesian optimal stopping for LLM evaluations** — knowing when an eval has enough samples (14-08-2026) [[AISI](https://www.aisi.gov.uk/research/knowing-when-to-stop-bayesian-optimal-stopping-for-llm-evaluations)]
- **Item Response Theory for AI Safety** — capability aggregation across heterogeneous tasks (05-08-2026) [[AISI](https://www.aisi.gov.uk/research/item-response-theory-for-ai-safety)]
- **CAISI: "Cheating on AI agent evaluations"** — documented ways models game agentic evals, directly relevant to the *reward hacking* glossary term and the OpenAI/Hugging Face incident [[CAISI blog](https://www.nist.gov/blogs/caisi-research-blog/cheating-ai-agent-evaluations)]
- **CAISI: insights from a large-scale red-teaming competition** — using open competitions as distributed measurement instruments [[CAISI blog](https://www.nist.gov/blogs/caisi-research-blog/insights-ai-agent-security-large-scale-red-teaming-competition)]

Academic framing of this institutional model: AISIs are technical, **non-regulatory**
government bodies centered on safety evaluations [[arXiv:2410.09219](https://arxiv.org/abs/2410.09219)],
with a mandate and convening power to feed international standards [[arXiv:2409.11314](https://arxiv.org/abs/2409.11314)].

### 5.4 Tie-in to Dutch/EU policy

This is the missing "producer" side of the division of labor identified in Section 4: the
UK/US institutes build evaluation *capability* (harnesses, ranges, statistical methods),
the EU is replicating that function at Union level by 2027 [[Action Plan](https://digital-strategy.ec.europa.eu/en/library/eu-action-plan-cybersecurity-and-artificial-intelligence)],
and the Netherlands — with no AISI of its own — consumes those results while regulating
deployers domestically. AISI's open-weight gap finding flowing directly into **UK NCSC**
defensive guidance [[NCSC blog](https://www.ncsc.gov.uk/blogs/retaining-defensive-advantage-in-the-age-of-frontier-ai-cyber-capabilities)]
shows the full loop this project tracks: benchmark → institute finding → national cyber
policy → deployer duties. These governmental evaluations are the closest
real-world implementation of what benchmarks like **Cybench** (CTF agent capability) and
**CyberSecEval** (offensive-cyber capability) claim to measure — run by states, with
published methods, and now coordinated across allied governments.

---

## 6. Case study: UK AISI — how a state turns benchmarks into policy

The UK AI Security Institute is the most fully realized example of the "evaluation producer"
role from Section 5 — and the clearest demonstration of the benchmark→policy→deployer loop
this project tracks. All links verified 2026-09-01.

### 6.1 The institution

Research organisation inside the UK's Department for Science, Innovation and Technology (DSIT),
deliberately designed as a **"startup in the government"**: the world's first state-backed
institute dedicated to testing leading AI systems before and after release, informing
policymakers, and advancing mitigation research. Resourcing and structure (from the official
pages):

- **£66m/year funding**, priority access to **>£1.5bn of compute**, **pre-deployment access** to leading models — the material conditions that make meaningful frontier evaluation possible
- **100+ technical staff** recruited from frontier labs (OpenAI, DeepMind, Oxford); leadership spans public and private sectors — Director Henry de Zoete (former PM AI Advisor), CTO Jade Leung (ex-OpenAI governance), Chair Ian Hogarth; advisory board includes **Yoshua Bengio**
- Research domains: cyber misuse, safeguards, alignment, control, autonomy, human influence, societal resilience — with mitigation research mobilized through **>£15m in grants** via the Alignment Project [[Alignment Project](https://alignmentproject.aisi.gov.uk/)]
- **Non-regulatory by design**: it produces evidence for policy; enforcement sits elsewhere [[arXiv:2410.09219](https://arxiv.org/abs/2410.09219)] — see the AISI-institution analysis in Section 5.3

[[AISI: About](https://aisi.gov.uk/about), [GOV.UK: AI Security Institute](https://www.gov.uk/government/organisations/ai-security-institute)]

### 6.2 Case chronology — building a national benchmarking practice

| **Date** | **Milestone** | **What it established** |
|----|----|----|
| 10 May 2024 | **Inspect open-sourced** | First AI evaluation platform built by a state-backed body released to the global community (by the then AI Safety Institute) — the UK staked its position by *giving away* the harness. | [[GOV.UK press release](https://www.gov.uk/government/news/ai-safety-institute-releases-new-ai-safety-evaluations-platform)] |
| 18 Dec 2025 | **Frontier AI Trends Report** | First public, evidence-based assessment from two years of testing 30+ frontier systems. Headlines: universal jailbreaks found in **every system tested**; a **40x difference** in expert effort to jailbreak models released 6 months apart; RepliBench self-replication success rose **5% → 60%** (2023→2025) [[RepliBench, arXiv:2504.18565](https://arxiv.org/abs/2504.18565)]. | [[AISI Trends Report](https://www.aisi.gov.uk/frontier-ai-trends-report)] |
| 05 Mar 2026 | **Inference-scaling finding** (with Irregular) | Standard evaluation setups now **underestimate** model capability: ~8% of private cyber tasks were only solved when the token budget rose from 10M to 50M; success scales log-linearly with budget. A methodological result that changes how every cyber benchmark must be run and reported. | [[AISI blog](https://www.aisi.gov.uk/blog/evidence-for-inference-scaling-in-ai-cyber-tasks-increased-evaluation-budgets-reveal-higher-success-rates)] |
| 13 Apr 2026 | **Claude Mythos Preview evaluation** | First model to solve the 32-step TLO cyber range end-to-end (3/10 attempts, avg 22/32 steps); 73% success on expert-level CTFs. AISI's "What organisations should do now" section points defenders to NCSC fundamentals [[Cyber Essentials](https://www.ncsc.gov.uk/cyberessentials/overview)] — evaluation and defender guidance explicitly joined. | [[AISI blog](https://www.aisi.gov.uk/blog/our-evaluation-of-claude-mythos-previews-cyber-capabilities)] |
| 13 May 2026 | **Doubling-time update** | 80%-reliability cyber time horizon now doubling every **4.7 months** (down from 8), with Mythos Preview and GPT-5.5 exceeding even that trend (GPT-5.5's own evaluation, published 30 Apr 2026, found it the strongest model AISI had tested on expert-level cyber tasks) [[GPT-5.5 evaluation](https://www.aisi.gov.uk/blog/our-evaluation-of-openais-gpt-5-5-cyber-capabilities)]; a later Mythos checkpoint solved TLO 6/10 and became the first to solve the second range ("Cooling Tower"). | [[AISI blog](https://www.aisi.gov.uk/blog/how-fast-is-autonomous-ai-cyber-capability-advancing)] |
| 17 & 23 Jul 2026 | **Open-vs-closed gap + first joint UK–US eval** | Open-weight models trail the closed cyber frontier by 4–7 months (see Section 5.1); Kimi K3 assessed jointly with US CAISI using shared methodology. | [[AISI blog](https://www.aisi.gov.uk/blog/how-far-behind-the-frontier-are-leading-open-weight-models-on-cyber), [joint assessment](https://www.aisi.gov.uk/blog/preliminary-assessment-of-kimi-k3s-cyber-capabilities)] |

### 6.3 Relevant news articles: the policy impact trail

The case-study value of AISI is not the benchmark scores but how they propagate — each item
below is a step in the chain from institute finding to deployer obligation.

| **Date** | **Article** | **Why it matters here** |
|----|----|----|
| 19 Feb 2026 | **OpenAI and Microsoft join AISI's Alignment Project** — £27M total, first 60 grants across 8 countries, advisory board incl. Bengio, Kolter, Goldwasser. | Government-as-research-funder: a state institute directing private capital toward its own research agenda; the *alignment* glossary term institutionalized. | [[GOV.UK](https://www.gov.uk/government/news/openai-and-microsoft-join-uks-international-coalition-to-safeguard-ai-development), [Alignment Project site](https://alignmentproject.aisi.gov.uk/)] |
| 25 May 2026 | **UK–Australia MoU between AISI and the Australian AI Safety Institute** — shared capability insights, joint eval best practice, staff exchanges; part of the International Network for Advanced AI Measurement, Evaluation and Science. | Evaluations as diplomacy: capability benchmarking coordinated between allied states — the same logic later visible in the joint CAISI assessment. | [[GOV.UK](https://www.gov.uk/government/news/uk-and-australia-pact-on-fast-moving-ai-security-risks), [International AI Safety Report](https://internationalaisafetyreport.org/)] |
| 15 Apr 2026 | **NCSC CEO letter (orig. Financial Times): "Retaining defensive advantage in the age of frontier AI cyber capabilities."** | The direct policy consumption of AISI's capability findings: "the timeline is not years" urgency translated into defender guidance (patch faster, raise baselines) — the AISI→NCSC→deployer hop of Section 5.4. | [[NCSC blog](https://www.ncsc.gov.uk/blogs/retaining-defensive-advantage-in-the-age-of-frontier-ai-cyber-capabilities), [PDF](https://www.ncsc.gov.uk/sites/default/files/2026-05/Retaining-defensive-advantage-in-the-age-of-frontier-AI-cyber-capabilities.pdf)] |
| 22 Jun 2026 | **Five Eyes joint statement: "The AI shift in cyber risk: why leaders must act now."** — "The timeline is not years, it is months." | AISI-derived urgency elevated to an intergovernmental statement signed by the heads of the Five Eyes cyber agencies; board-level accountability language mirrors the Dutch Cbw's governance duties. | [[NCSC](https://www.ncsc.gov.uk/news/the-ai-shift-in-cyber-risk-why-leaders-must-act-now), [statement PDF](https://www.ncsc.gov.uk/sites/default/files/2026-06/Five-Eyes-cyber-security-agencies-statement-ai-shift.pdf)] |
| 04 Aug 2026 | **NCSC CTO statement on frontier-AI evaluation incidents** — response to agents carrying out unsanctioned actions (the OpenAI/Hugging Face case, tracked in the glossary's events table). | An evaluation-safety failure converted into a regulator statement; links the *reward hacking* glossary term to national cyber policy. | [[NCSC statement](https://www.ncsc.gov.uk/news/ncsc-statement-in-response-to-recent-incidents-resulting-from-frontier-ai-evaluations), [METR investigation](https://metr.org/blog/2026-08-26-openai-hugging-face-incident-investigation/), [adopting agentic AI](https://www.ncsc.gov.uk/blogs/thinking-carefully-before-adopting-agentic-ai)] |
| 20 Aug 2026 | **NCSC: "Managing the cyber risk of agentic AI"** — interim deployment guidance: sandbox maturity models (network/compute isolation levels), blast-radius limits, immutable logging, emergency shutdown ("pull the plug"). | The downstream deployer-duty artifact — the UK's agentic equivalent of the Dutch Cbw zorgplicht; NCSC explicitly links it to "several incidents involving AI models and agentic AI systems." | [[NCSC blog](https://www.ncsc.gov.uk/blogs/managing-the-cyber-risk-of-agentic-ai), [NCSC frontier-AI hub](https://www.ncsc.gov.uk/frontier-ai)] |

Adjacent NCSC resource worth one line here (the threat-assessment counterpart to AISI's
capability work): the NCSC's probabilistic assessment *Impact of AI on cyber threat from now
to 2027* [[NCSC report](https://www.ncsc.gov.uk/report/impact-ai-cyber-threat-now-2027)],
which assesses a "realistic possibility" that critical systems become more vulnerable to
advanced actors by 2027 if mitigation lags.

### 6.4 Why AISI is the model case for this project

AISI demonstrates the complete loop no other actor in this repository closes end-to-end:
it runs capability benchmarks with published methodology (unlike vendor leaderboards),
discovers capability facts — universal jailbreaks [[Trends Report](https://www.aisi.gov.uk/frontier-ai-trends-report)],
inference scaling [[AISI blog](https://www.aisi.gov.uk/blog/evidence-for-inference-scaling-in-ai-cyber-tasks-increased-evaluation-budgets-reveal-higher-success-rates)],
shrinking open/closed gaps [[AISI blog](https://www.aisi.gov.uk/blog/how-far-behind-the-frontier-are-leading-open-weight-models-on-cyber)] —
feeds those findings into its own national cyber authority (NCSC guidance [[1](https://www.ncsc.gov.uk/blogs/retaining-defensive-advantage-in-the-age-of-frontier-ai-cyber-capabilities)], Five Eyes
statements [[2](https://www.ncsc.gov.uk/news/the-ai-shift-in-cyber-risk-why-leaders-must-act-now)]), and the resulting guidance lands as deployer duties of exactly the kind Dutch
policy encodes (Cbw zorgplicht [[1](https://www.ncsc.nl/cyberbeveiligingswet-nis2/zorgplicht)], IBP FO normenkader [[2](https://aanpakibp.kennisnet.nl/normenkader/)]) — while the EU replicates the institution itself
by 2027 [[EU Action Plan](https://digital-strategy.ec.europa.eu/en/library/eu-action-plan-cybersecurity-and-artificial-intelligence)]. AISI is proof that a capability-benchmark taxonomy
maps onto an operating state institution, with the news trail (§6.3) documenting each hop.

---

## 7. Organizations doing similar work to AISI

AISI is the most visible state evaluator, but it operates within a web of institutional,
independent, and private actors performing overlapping work: capability evaluation,
harness-building, risk assessment, and field coordination. 

**Links generated and verified by AI 2026-09-01.**

### 7.1 State-backed evaluation institutes

| **Organization** | **What it does** | **Key reports / research** |
|----|----|----|
| **US CAISI** (Center for AI Standards and Innovation, NIST) | The US counterpart to AISI: unclassified evaluations of US and adversary AI systems, safeguard assessments, and research on evaluation integrity (see §5.1 and §5.3 for full detail). | [CAISI research blog](https://www.nist.gov/caisi) — incl. "Cheating on AI agent evaluations" and red-teaming-competition analyses; published assessment methodology (GLM-5.2 report). |
| **Australian AI Safety Institute** | Formal partner of UK AISI under the May 2026 MoU: shared capability insights, joint evaluation best practice, staff exchanges. Australia is also a funder in AISI's Alignment Project coalition. | Via the [UK–Australia MoU announcement](https://www.gov.uk/government/news/uk-and-australia-pact-on-fast-moving-ai-security-risks) (no directly verified standalone site this session). |
| **International AI Safety Report** (Bengio-led, 30+ countries, 100+ experts; partners: UK AISI and Mila) | Not an evaluator itself but the shared-evidence layer above them: the world's first comprehensive scientific review of general-purpose AI capabilities and risks, produced as the largest international AI-safety collaboration to date. | [2026 Report](https://internationalaisafetyreport.org/publication/international-ai-safety-report-2026), [Extended Summary for Policymakers](https://internationalaisafetyreport.org/publication/2026-report-extended-summary-policymakers), [Key Update: Technical Safeguards and Risk Management](https://internationalaisafetyreport.org/publication/second-key-update-technical-safeguards-and-risk-management) (Nov 2025). |

### 7.2 Independent research nonprofits

| **Organization** | **What it does** | **Key reports / research** |
|----|----|----|
| **METR** (Model Evaluation & Threat Research) | Research nonprofit that "scientifically measures whether and when AI systems might threaten catastrophic harm"; runs capability evaluations with and without developer cooperation; partnered with OpenAI, Anthropic, Google DeepMind, Meta, Amazon; part of the NIST AISI Consortium, partners with UK AISI, and provides technical assistance to the European AI Office. | [Time-horizon methodology](https://metr.org/time-horizons/) ([arXiv:2503.14499](https://arxiv.org/abs/2503.14499) — the task-length doubling metric AISI's cyber work builds on); [Frontier Risk Report Feb–Mar 2026](https://metr.org/blog/2026-05-19-frontier-risk-report/) — first *entity-based* rogue-deployment risk assessment with four frontier labs (means/motive/opportunity framework, 44 documented misalignment incidents); independent investigation of the [OpenAI/Hugging Face hacking incident](https://metr.org/blog/2026-08-26-openai-hugging-face-incident-investigation/); [MALT](https://metr.org/blog/2025-10-14-malt-dataset-of-natural-and-prompted-behaviors/) — a dataset of natural and prompted eval-integrity failures (reward hacking, sandbagging); **Hawk** ([docs](https://hawk.metr.org/)) — an open-source platform for running Inspect evaluations at scale on AWS, the infrastructure counterpart to AISI's Inspect harness. |
| **Center for AI Safety (CAIS)** | San Francisco nonprofit conducting safety research, field-building, and compute provision; origin of the 2023 AI-extinction-risk statement signed by 700+ researchers. | [Research page](https://safe.ai/work/research) — incl. AgentHarm (§5.2), the MASK honesty benchmark, *An Overview of Catastrophic AI Risks* ([arXiv:2306.12001](https://arxiv.org/abs/2306.12001)). |

### 7.3 Frontier-security labs (private)

| **Organization** | **What it does** | **Key reports / research** |
|----|----|----|
| **Irregular** | Self-described "first frontier security lab"; co-ran AISI's inference-scaling study (§6.2) and co-built the advanced cyber task suites used in AISI's GPT-5.5 evaluation — the clearest example of public–private task development. | [AI Security Priorities: A Field-Wide Agenda](https://www.irregular.com/research/ai-security-priorities-a-field-wide-agenda) (with RAND; [arXiv:2607.26069](https://arxiv.org/abs/2607.26069)) — expert-ranked priorities across policy, institutional infrastructure, technical assurance, and agentic-AI governance; [assessment of Kimi K3 against offensive-security benchmarks](https://www.irregular.com/research/assessing-kimi-k3-against-offensive-security-benchmarks). |

### 7.4 Academic

| **Organization** | **What it does** | **Key reports / research** |
|----|----|----|
| **Mila** (Quebec AI Institute) | Founded by Yoshua Bengio (1993); 1,400+ researchers; a founding partner of the International AI Safety Report alongside UK AISI — the academic backbone of the global assessment effort. | [Publications index](https://mila.quebec/en/research/publications); [Responsible AI strategic priority](https://mila.quebec/en/research/strategic-priorities/responsible-ai). |

**The collaboration web:** these organizations do not work in parallel silos. AISI builds the
harness (Inspect) that METR scales (Hawk) and that private labs extend (Irregular's task
suites run inside AISI's evaluations); CAISI and AISI run joint assessments (Kimi K3); METR
advises the EU AI Office and sits in NIST's consortium; and the International AI Safety
Report — backed by AISI and Mila — aggregates all of it for 30+ governments. For anyone
studying this field, the practical reading order is: METR for measurement methodology, AISI
for capability findings with published methods, CAISI for adversarial-model assessment, and
the International AI Safety Report for the consolidated scientific picture.



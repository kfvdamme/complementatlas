README for "A Complement Atlas identifies interleukin 6 dependent alternative pathway dysregulation as a key druggable feature of COVID-19" 

Contact information:
- Karel F.A. Van Damme, karel.vandamme@ugent.be
- Bart N. Lambrecht, bart.lambrecht@ugent.be

Reference:
- Article: KFA Van Damme, L Hoste, J Declercq, E De Leeuw, B Maes, L Martens, R Colman, R Browaeys, C Bosteels, S Verwaerde, N Vermeulen, S Lameire, N Debeuf, J Deckers, P Stordeur, P Depuydt, E Van Braeckel, L Vandekerckhove, M Guilliams, STT Schetters, F Haerynck, SJ Tavernier, BN Lambrecht. A Complement Atlas identifies interleukin 6 dependent alternative pathway dysregulation as a key druggable feature of COVID-19. Science Translational Medicine (in press).
- Webportal: https://complementatlas.com/
- GitHub: https://github.com/kfvdamme/complementatlas/
- Zenodo: https://doi.org/10.5281/zenodo.8192091

Clinical data and sample collection:
The patient samples and clinical data utilized in this project were collected during three randomized clinical trials conducted in the 2020 COVID-19 pandemic:
- Effect of anti-interleukin drugs in patients with COVID-19 and signs of cytokine release syndrome (COV-AID): A factorial, randomized, controlled trial (Declercq et al., 2021).
- Loss of GM-CSF-dependent instruction of alveolar macrophages in COVID-19 provides a rationale for inhaled GM-CSF treatment (SARPAC) (Bosteels et al., 2022).
- Efficacy and safety of the investigational complement C5 inhibitor zilucoplan in patients hospitalized with COVID-19: an open-label randomized controlled trial (ZILUCOV) (De Leeuw et al., 2022).

Files:
- complement.csv contains the complement level dataset.
- complement_anti_C5.csv holds the levels of sC5b-9 upon anti-C5 therapy.
- complement_function.csv contains the ex vivo complement functional tests.
- olink.csv includes the 3000-plex proteomics dataset.

Complement level dataset (complement.csv):
- Complement components Bb, C3a, C4a, C5a, and sC5b-9 were measured in cell-free plasma with a customizable enzyme immunoassay multiplex kit (MicroVue Complement Multiplex; Quidel; A905s); The plasma concentrations of C3, C4, and C1-INH were quantified by an automated turbidimetric assay on the Optilite analyzer (The Binding Site Group Limited); C1-INH functional activity was measured using the Berichrom C1-Inhibitor assay (Siemens).
- OS_at_baseline is the ordinal scale at baseline (see olink.csv or COV-AID trial for definition of ordinal scale).
- Critical disease was defined as the need for mechanical ventilation or death at any time. 
- Units: CRP in mg/mL; ferritin in µg/L; D-dimers in ng/mL; Bb in µg/mL; C3a, C4a, C5a, sC5b-9 (MAC) in ng/mL; C3, C4, and C1INHconc in g/L; C1INHact in %.

Levels of sC5b-9 upon anti-C5 therapy (complement_anti_C5.csv):
- sC5b-9 levels were assessed in cell-free plasma using the MicroVue sC5b-9 plus enzyme immunoassay kit (A029).
- Units: sC5b-9 (MAC) in ng/mL.

Complement functional tests (complement_function.csv):
- Functional complement activity was measured on serum samples using the Wieslab Complement system Screen kit (Weislab Diagnostic Services; COMPL300 RUO). IFN-γ, IL-1β, IL-6, IL-8, IL-10, IL-12p70, TNF, CXCL10, IL-1RA, ICAM1, GM-CSF, G-CSF  were quantified using single- or multiplex immunoassays by Meso Scale Discovery (K15049D, K151NVD, K151WTD, K151SUD, K151F35, B21VG, B21VJ, K15227N). Commercially available ELISA kits were used for the detection of serum Ang-2 (Thermo Fisher Scientific; KHC1641), sRAGE (R&D Systems; DRG00), MUC-1 (Thermo Fisher Scientific; EHMUC1), vWF (Thermo Fisher Scientific; EHVWF), suPAR (suPARnostic Virogates; E001). Other proteins were detected with the Olink Explore 3072 platform. C5 and sC5b-9 levels were assessed in cell-free plasma using the Abnova C5 (human) ELISA kit (KA2114) and MicroVue sC5b-9 plus enzyme immunoassay kit (A029), respectively.
- Time_clin_improv_censored_d28 contains te time to clinical improvement (defined as time from randomisation to an increase of at least two points on a 6-category ordinal scale or to discharge from hospital alive), with patients without improvement after 28 days censored to 28 days.
- Time_discharge_censored contains te time to discharge from hospital alive, with patients without discharge censored to the worst value of the dataset.
- Ordinal_scale_rando is ordinal scale at baseline.
- Column names preceded with "Multi_" contain results from immunoassay data.
- Units: functional complement pathways in optical densities (O.D.) normalized for the assay positive control; Ang2, CXCL10, G-CSF, ICAM, IFNG, IL10, IL12, IL18, IL1B, IL1RA, IL6, IL8, TNF in pg/mL; GM-CSF in fg/mL; MUC1 in mU/mL; sRAGE, SUPAR, VWF, and sC5b-9 in ng/mL; C5 in µg/mL; all remaining proteins (measured with Olink Explore 3000) in NPX.

Proteomics (olink.csv):
- For quantification methods of cytokines, complement or proteins, see above.
- Time_to_2_points_improvement_OS_censored and Time_to_discharge_censored: for definitions see complement functional tests. 
- FU_meters_walked contains meters walked during a six-minute walk test, with non-survivors censored to the worst value in FU_meters_walked_censored
- Units: ALT, AST, LDH in IU/L; bilirubin, creatinine in mg/dL; eosinophils, lymphocytes, and neutrophils in 10^6/L; hemoglobin in g/dL; for additional units see above.
options(warn=-1)
setwd("D:/COVID-19/BIO-COV/Data_Sharing_Clean")
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggthemes))
suppressPackageStartupMessages(library(rstatix))
suppressPackageStartupMessages(library(stringr))

source("plot_functions.R")
source("data_loading.R")

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "united"),
  tags$head(
    tags$script(
      HTML(
        "
      var sc_project=12861218;
      var sc_invisible=1;
      var sc_security='1671c6c8';
      "
      )
    ),
    tags$script(src = "https://www.statcounter.com/counter/counter.js"),
    tags$noscript(
      HTML(
        "
        <div class='statcounter'><a title='Web Analytics'
        href='https://statcounter.com/' target='_blank'><img
        class='statcounter'
        src='https://c.statcounter.com/12861218/0/1671c6c8/1/'
        alt='Web Analytics'
        referrerPolicy='no-referrer-when-downgrade'></a></div>
      "
      )
    )),
  tabsetPanel(id= "tabs",
              tabPanel("Introduction",
                       fluidRow(
                         column(width = 3,
                                br(), br(),
                                h3(""),
                                p(em("reference:")),
                                p(style = "text-align: justify;",
                                  "KFA Van Damme, L Hoste, J Declercq, E De Leeuw, B Maes, L Martens, R Colman, R Browaeys, C Bosteels, S Verwaerde, N Vermeulen, S Lameire, N Debeuf, J Deckers, P Stordeur, P Depuydt, E Van Braeckel, L Vandekerckhove, M Guilliams, STT Schetters, F Haerynck, SJ Tavernier, BN Lambrecht."),
                                p(style = "text-align: justify;",
                                  "A Complement Atlas identifies interleukin 6 dependent alternative pathway dysregulation as an key druggable feature of COVID-19."),
                                p(em("Science Translational Medicine (in press)."))),
                         column(width = 7,
                                h3("COVID-19 Complement Atlas - introduction"),
                                br(),
                                p(style = "text-align: justify;",
                                  strong("About")),
                                p(style = "text-align: justify;",
                                  "Welcome to the online portal of the Complement Atlas, a resource which allows exploration of diverse datasets on complement dysregulation in COVID-19. 
                                  This Atlas is the outcome of a collaborative effort by researchers at Vlaams Instituut voor Biotechnologie (VIB), Ghent University, Ghent University Hospital, as well as numerous health care workers across Belgium who contributed to randomized clinical trials conducted during the 2020 COVID-19 pandemic. 
                                  Collectively, these data provide new insights on how the complement system – a key component of the immune system meant to defend against pathogens – contributes to lung injury in COVID-19. 
                                  These findings not only open up novel therapeutic avenues in COVID-19, but also might hold promise for addressing complement dysregulation in other human diseases."),
                                p(style = "text-align: justify;",
                                  strong("The complement system")),
                                p(style = "text-align: justify;",
                                  "The complement cascade is an indispensable and multifunctional arm of the innate immune system. 
                                  It contributes to pathogen recognition and phagocytotic clearance, recruits and activates immune cells, and induces direct pathogen or cell lysis via the membrane attack complex (C5b-9, MAC). 
                                  Complement responses can be initiated via three pathways (see Figure below). 
                                  The classical and lectin pathways are triggered by immune complexes and pathogen recognition molecules respectively, leading to cleavage of C4 and C2. 
                                  The spontaneous hydrolysis of C3 triggers further activation of native C3 to set off the alternative pathway. 
                                  All modes of complement activation converge on the proteolysis of C3 and C5, generating the potent pro-inflammatory peptides C3a and C5a, while C5b initiates MAC formation."),
                                tags$img(src = "Complement_overview.png", height = "500px",
                                         title = "Complement pathways", style="display: block; margin-left: auto; margin-right: auto;"),
                                p(style = "text-align: justify;",
                                  "To prevent inappropriate immune activation and collateral damage to tissues, complement responses are tightly controlled under homeostatic conditions and protective immune response. 
                                  The key importance of complement and its regulation is best illustrated by genetic complement deficiencies, which lead to immunodeficiency, auto-immunity, endothelial damage and/or kidney injury. 
                                  In addition to these inborn disorders, dysregulation of the complement system has been reported across a spectrum of infectious diseases, including those caused by emerging coronaviruses."),
                                p(style = "text-align: justify;",
                                  strong("Scientific abstract")),
                                p(style = "text-align: justify;",
                                  "To improve COVID-19 treatment, it is essential to understand the mechanisms driving critical illness. 
                                  The complement system is an crucial component of innate host defense, but it can also contribute to tissue injury. 
                                  While all complement pathways have been implicated in COVID-19 pathogenesis, the upstream drivers and downstream consequences on tissue injury remain ill-defined. 
                                  Here, we demonstrate that complement activation is primarily mediated by the alternative pathway and we provide a comprehensive atlas of the complement alterations around the time of respiratory deterioration. 
                                  Proteomic and single-cell sequencing data across cell types and tissues reveal a division of labor between lung epithelial, stromal, and myeloid cells in complement production, in addition to liver-derived factors. 
                                  We identify IL-6 and STAT1/3 signaling as an upstream driver of complement responses, linking complement dysregulation to approved COVID-19 therapies. 
                                  Furthermore, an exploratory proteomic study indicates that inhibition of complement C5 improves epithelial damage and markers of disease severity. 
                                  Collectively, these results support complement dysregulation as a key druggable feature of COVID-19."),
                                br()
                         ))),
              tabPanel("Complement",
                       fluidRow(
                         column(width = 3,
                                br(),
                                h3(""),
                                div(style = "display:inline-block;", title = "Measured in cell-free plasma with enzyme immunoassay (Quidel; C3a (ng/mL), C5a (ng/mL), sC5b-9 (ng/mL), Bb (µg/mL), C4a (ng/mL)), chromogenic assay (Berichrom; C1INHact (%)), or turbidimetric assay (Optilite; C3, C4, C1INHconc (all in g/L))", icon("info-circle")),
                                radioButtons("select_complement", "complement factor", 
                                             choices = c("C3a", "C5a", "sC5b-9 (MAC)", "Bb", "C4a", "C1INHact", "C3", "C4", "C1INHconc"),
                                             selected = "C3a"),
                                radioButtons("select1", "comparison", choices = c("non-critical vs critical",
                                                                                  "survivor vs non-survivor",
                                                                                  "healthy vs COVID-19",
                                                                                  "control vs anti-C5*"),
                                             selected = "non-critical vs critical"),
                                radioButtons("select2", "timepoint", choices = c("day 1 (predose)",
                                                                                 "day 6", 
                                                                                 "evolution"),
                                             selected = "day 1 (predose)"),
                                p("*: only sC5b-9 (MAC) available")),
                         column(width = 7,
                                h3("COVID-19 Complement Atlas"),
                                plotOutput("plot_complement", height = "500px", width = "350px")))),
              tabPanel("Pathway activity",
                       fluidRow(
                         column(width = 3,
                                br(),
                                h3(""),
                                div(style = "display:inline-block;", title = "Functional activity of complement pathways in serum (WIESLAB Complement System Screen), expressed as optical densities normalized for the positive control", icon("info-circle")), 
                                radioButtons("select_pathway", label = "complement pathway",
                                             choices = c("classical", "lectin", "alternative")),
                                radioButtons("select3", "comparison", choices = c("non-critical vs critical",
                                                                                  "survivor vs non-survivor",
                                                                                  "healthy vs COVID-19")),
                                radioButtons("select4", "timepoint", choices = c("day 1 (predose) ",
                                                                                 "day 6*")),
                                p("*: day 6 samples of anti-IL-6(R) treated patients are excluded")),
                         column(width = 7,
                                h3("COVID-19 Complement Atlas"),
                                plotOutput("plot_pathway", height = "500px", width = "350px")))),
              tabPanel("Proteomics",
                       fluidRow(
                         column(width = 3,
                                br(),
                                h3(""),
                                div(style = "display:inline-block;", title = "Measured in serum using a proximity extension assay (Olink Explore 3072), expressed as Normalized Protein eXpression (which is on a log2 scale)", icon("info-circle")),
                                selectInput("text", "protein", choices = proteins, selected = ""),
                                radioButtons("select5", "comparison", choices = c("non-critical vs critical",
                                                                                  "survivor vs non-survivor",
                                                                                  "healthy vs COVID-19",
                                                                                  "control vs anti-C5")),
                                radioButtons("select6", "timepoint", choices = c("day 1 (predose)",
                                                                                 "day 6", 
                                                                                 "evolution"))),
                         column(width = 7,
                                h3("COVID-19 Complement Atlas"),
                                plotOutput("plot_proteomics", height = "500px", width = "350px")))),
              tabPanel("IL-1/6 blockade",
                       fluidRow(
                         column(width = 3,
                                br(),
                                h3(""),
                                div(style = "display:inline-block;", title = "IL-6 inhibition using a single IV dose of siltuximab (11 mg/kg, anti-IL-6) or tocilizumab (8 mg/kg, anti-IL-6R); IL-1 inhibition using daily SC anakinra 100 mg; please note the 2x2 factorial design of COV-AID trial", icon("info-circle")),
                                radioButtons("select_complement2", "complement factor", 
                                             choices = c("C3a", "C5a", "sC5b-9 (MAC)", "Bb", "C4a", "C1INHact", "C3", "C4", "C1INHconc",
                                                         "functional classical pathway*", "functional lectin pathway*", "functional alternative pathway*"),
                                             selected = "C3a"),
                                radioButtons("select_intervention", "intervention", 
                                             choices = c("anti-IL-6(R) with tocilizumab or siltuximab", "anti-IL-1 with anakinra")),
                                p("*: only effect of anti-IL-6(R) available")),
                         column(width = 7,
                                h3("COVID-19 Complement Atlas"),
                                plotOutput("plot_IL_blockade", height = "500px", width = "350px")))),
              tabPanel("Gene expression",
                       fluidRow(
                         column(width = 3,
                                br(),
                                h3(""),
                                div(style = "display:inline-block;", title = "Links to articles and web portals of previously published single-cell datasets", icon("info-circle")),
                                p(em("reference:")),
                                p(style = "text-align: justify;",
                                  "KFA Van Damme, L Hoste, J Declercq, E De Leeuw, B Maes, L Martens, R Colman, R Browaeys, C Bosteels, S Verwaerde, N Vermeulen, S Lameire, N Debeuf, J Deckers, P Stordeur, P Depuydt, E Van Braeckel, L Vandekerckhove, M Guilliams, STT Schetters, F Haerynck, SJ Tavernier, BN Lambrecht."),
                                p(style = "text-align: justify;",
                                  "A Complement Atlas identifies interleukin 6 dependent alternative pathway dysregulation as an key druggable feature of COVID-19."),
                                p(em("Science Translational Medicine (in press)."))),
                         column(width = 7,
                                h3("COVID-19 Complement Atlas"),
                                br(),
                                p(strong("Publicly available datasets:")),
                                tags$style(HTML(".justified {text-align: justify;}")),
                                HTML("<div class='justified'>Lung single-nucleus RNA sequencing, containing COVID-19 and control samples (Melms et al., 2021): 
                                       <a href='https://www.nature.com/articles/s41586-021-03569-1'>original publication</a> and 
                                       <a href='https://singlecell.broadinstitute.org/single_cell/study/SCP1219/columbia-university-nyp-covid-19-lung-atlas#study-visualize'>web portal</a>.</div>"),
                                HTML("<div class='justified'>Broncho-alveolar lavage CITE-sequencing, containing COVID-19 and control samples (Bosteels et al., 2022): 
                                       <a href='https://www.sciencedirect.com/science/article/pii/S2666379122003974'>original publication</a> and 
                                       <a href='https://single-cell.be/covid19/browser'>web portal</a>.</div>"),
                                HTML("<div class='justified'>Blood single-cell RNA sequencing, containing COVID-19 and control samples (Schulte-Schrepping et al., 2020): 
                                       <a href='https://www.sciencedirect.com/science/article/pii/S0092867420309922'>original publication</a>.</div>"),
                                HTML("<div class='justified'>Liver single-nucleus RNA sequencing, containing COVID-19 samples only (Delorey et al., 2021): 
                                       <a href='https://www.nature.com/articles/s41586-021-03570-8'>original publication</a> and 
                                       <a href='https://singlecell.broadinstitute.org/single_cell/study/SCP1213/covid-19-liver-autopsy-samples#study-visualize'>web portal</a>.</div>"),
                                HTML("<div class='justified'>Liver single-nucleus and CITE-sequencing, containing control samples only (Guilliams et al., 2022): 
                                       <a href='https://www.sciencedirect.com/science/article/pii/S0092867421014811'>original publication</a> and 
                                       <a href='https://www.livercellatlas.org/datasets_human.php'>web portal</a>.</div>")))),
              tabPanel("Data and additional reading",
                       fluidRow(
                         column(width = 3,
                                br(), br(),
                                h3(""),
                                p(em("reference:")),
                                p(style = "text-align: justify;",
                                  "KFA Van Damme, L Hoste, J Declercq, E De Leeuw, B Maes, L Martens, R Colman, R Browaeys, C Bosteels, S Verwaerde, N Vermeulen, S Lameire, N Debeuf, J Deckers, P Stordeur, P Depuydt, E Van Braeckel, L Vandekerckhove, M Guilliams, STT Schetters, F Haerynck, SJ Tavernier, BN Lambrecht."),
                                p(style = "text-align: justify;",
                                  "A Complement Atlas identifies interleukin 6 dependent alternative pathway dysregulation as an key druggable feature of COVID-19."),
                                p(em("Science Translational Medicine (in press)."))),
                         column(width = 7,
                                h3("COVID-19 Complement Atlas - data and additional reading"),
                                br(),
                                p(style = "text-align: justify;",
                                  strong("Randomized clinical trials")),
                                HTML("<div class='justified'>Effect of anti-interleukin drugs in patients with COVID-19 and signs of cytokine release syndrome (COV-AID): a factorial, randomised, controlled trial (<a href='https://www.sciencedirect.com/science/article/pii/S2213260021003775'>Declercq et al., 2021</a>)."),
                                HTML("<div class='justified'>Loss of GM-CSF-dependent instruction of alveolar macrophages in COVID-19 provides a rationale for inhaled GM-CSF treatment (SARPAC) (<a href='https://www.cell.com/cell-reports-medicine/fulltext/S2666-3791(22)00397-4'>Bosteels et al., 2022</a>)."),
                                HTML("<div class='justified'>Efficacy and safety of the investigational complement C5 inhibitor zilucoplan in patients hospitalized with COVID-19: an open-label randomized controlled trial (ZILUCOV)  (<a href='https://respiratory-research.biomedcentral.com/articles/10.1186/s12931-022-02126-2'>De Leeuw et al., 2022</a>)."),
                                br(),
                                br(),
                                p(style = "text-align: justify;",
                                  strong("Datasets")),
                                tags$a(href = "complement.csv", "Download complement level dataset"),
                                br(),
                                tags$a(href = "complement_anti_C5.csv", "Download sC5b-9 levels upon anti-C5 treatment"),
                                br(),
                                tags$a(href = "complement_function.csv", "Download complement activity dataset"),
                                br(),
                                tags$a(href = "olink.csv", "Download proteomics dataset (Olink Explore 3072)"),
                                br(),
                                br(),
                                HTML("<div class='justified'>Link to datasets at <a href='example.com'>Zenodo</a> with DOI: <a href='example.com'>example</a>."),
                                br(),
                                HTML("<div class='justified'>Link to code at <a href='https://github.com/kfvdamme/complementatlas'>GitHub</a>."),
                                br(),
                                br(),
                                p(style = "text-align: justify;",
                                  strong("Funding")),
                                HTML("<div class='justified'> Vlaams Instituut voor Biotechnologie (VIB) Grand Challenges programs (M901BALA-GCP-COVID-19-SARPAC TRIAL and M902BALA-GCP-COVID-19-IL6-IL1 TRIAL)."),
                                HTML("<div class='justified'> VIB Tech Watch Fund."),
                                HTML("<div class='justified'> Chan Zuckerberg Initiative COVID atlas project (2020-216717)."),
                                HTML("<div class='justified'> Ghent University COVID-Track project (BOFCOV;01C04620)."),
                                HTML("<div class='justified'> Fonds voor wetenschappelijk onderzoek (FWO) COVID grant (G0G4520N)."),
                                HTML("<div class='justified'> Ghent University Methusalem grant (01M01521)."),
                                br(),
                                br(),
                                p(style = "text-align: justify;",
                                  strong("Acknowledgements")),
                                HTML("<div class='justified'> 
                                      We owe gratitude to all patients and their families for participating in our trials, and to all involved clinical teams. 
                                      We thank the VIB Tech Watch Fund and the VIB Grand Challenges Program, which enabled the proteomic and biomarker analysis. 
                                      Trial oversight and data collection was carried out at Ghent University Hospital by 
                                      the clinical research coordinaters at the Department of Respiratory Medicine (Stefanie Vermeersch, Benedicte Demeyere, Anja Delporte, Ans Vandecauter, Vanessa Parrein), 
                                      the study nurses at the Intensive Care Unit (Daisy Vermeiren) and Center for Primary Immunodeficiency (Karlien Claes),
                                      the Health, innovation and research institute (HIRUZ) (Catherine Van Der Straeten, Charlotte Clauwaert, Joke Tommelein, Hélène De Naeyer, Dries Loncke, Kokur Hanife, Lieselot Vanlanduyt, Evy Doolaege, Simon Vanderschaeghe, Leen Borgers, Stefanie De Buyser), 
                                      and biobank requirements were fulfilled by the colleagues of the Respiratory Infection and Defense lab and Lung Research Lab (Ann Neesen, Indra De Borle and Tania Maes) at Ghent University, 
                                      for which we thank them. 
                                      Clinical samples were processed by many fantastic colleagues (Leen Sys, Helena Aegerter, Ursula Smole, Kim Deswarte, Leslie Naesens, Helena Flipts, Hamida Hammad, Veronique Debacker, Justine Van Moorleghem, Lisa Roels, Nancy Cabooter, Zara Declercq, Roanne Schuppers).
                                      We thank the UCB team (Claire Brittain, Laurent Detalle, Jemma Greenin, Margarita Lens and Marianna Lalla) for the collaboration on the ZILUCOV trial. 
                                      The Inflammation Research Center web team (Arne Soete) and VIB Single Cell Core (Kevin Verstaen) helped launching the Complement Atlas web portal.
                                      Administrative and ethical advice was kindly provided by VIB (Griet Verhaegen, René Custers).
                                      We thank Hamideh Baggali for providing linguistic advice."),
                                br(),
                                br(),
                                p(style = "text-align: justify;",
                                  strong("Contact information")),
                                p(HTML("<a href='mailto:karel.vandamme@ugent.be'>karel.vandamme@ugent.be</a> or <a href='mailto:bart.lambrecht@ugent.be'>bart.lambrecht@ugent.be</a>")),                            
                                br(),
                                fluidRow(
                                  column(
                                    width = 4,
                                    img(src = "logo_irc.jpg", height = "75px", align = "bottom")),
                                  column(
                                    width = 4,
                                    img(src = "logo_UGent.png", height = "100px", align = "center")),
                                  column(
                                    width = 4,
                                    img(src = "Logo_UZ.png", height = "75px", align = "bottom"))),
                                br()
                                )))
              # ,
              # tabPanel("Lay summary (NL)",
              #          fluidRow(
              #            column(width = 3,
              #                   br(), br(),
              #                   h3(""),
              #                   p(em("reference:")),
              #                   p(style = "text-align: justify;",
              #                     "KFA Van Damme, L Hoste, J Declercq, E De Leeuw, B Maes, L Martens, R Colman, R Browaeys, C Bosteels, S Verwaerde, N Vermeulen, S Lameire, N Debeuf, J Deckers, P Stordeur, P Depuydt, E Van Braeckel, L Vandekerckhove, M Guilliams, STT Schetters, F Haerynck, SJ Tavernier, BN Lambrecht."),
              #                   p(style = "text-align: justify;",
              #                     "A Complement Atlas identifies interleukin 6 dependent alternative pathway dysregulation as an key druggable feature of COVID-19."),
              #                   p(em("Science Translational Medicine (in press)."))),
              #            column(width = 7,
              #                   h3("COVID-19 Complement Atlas - lay abstract"),
              #                   br()))),

  )
)
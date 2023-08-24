# COVID-19 Complement Atlas
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8192092.svg)](https://doi.org/10.5281/zenodo.8192092)
[![DOI:10.1126/scitranslmed.adi0252](http://img.shields.io/badge/DOI-10.1126/scitranslmed.adi0252-B31B1B.svg)](http://www.science.org/doi/10.1126/scitranslmed.adi0252)

Welcome to the GitHub repository of the **COVID-19 Complement Atlas**. This repository contains the R code and raw data behind **<a href='https://complementatlas.com'>complementatlas.com</a>**, an interactive portal for exploring complement dysregulation during COVID-19. The data underlying this project have also been deposited on Zenodo and Dryad. 

For the methods and results, please read the full paper: **<a href='http://www.science.org/doi/10.1126/scitranslmed.adi0252'>A Complement Atlas identifies interleukin 6 dependent alternative pathway dysregulation as a key druggable feature of COVID-19</a>**.

The patient samples and clinical data utilized in this project were collected during three randomized clinical trials conducted in the 2020 COVID-19 pandemic:

* **Effect of anti-interleukin drugs in patients with COVID-19 and signs of cytokine release syndrome (COV-AID): A factorial, randomized, controlled trial** (<a href='https://www.sciencedirect.com/science/article/pii/S2213260021003775'>Declercq et al., 2021</a>).

* **Loss of GM-CSF-dependent instruction of alveolar macrophages in COVID-19 provides a rationale for inhaled GM-CSF treatment (SARPAC)** (<a href='https://www.cell.com/cell-reports-medicine/fulltext/S2666-3791(22)00397-4'>Bosteels et al., 2022</a>).

* **Efficacy and safety of the investigational complement C5 inhibitor zilucoplan in patients hospitalized with COVID-19: an open-label randomized controlled trial (ZILUCOV)** (<a href='https://respiratory-research.biomedcentral.com/articles/10.1186/s12931-022-02126-2'>De Leeuw et al., 2022</a>).

## Contents

This repository includes the following files:

* **ui.R**, **server.R**, and **runShinyApp.R** are scripts to launch the Complement Atlas website.

* **data_loading.R** is responsible for loading all the raw data.

* **plot_functions.R** defines various functions for data visualization.

Additionally, the **www** subfolder contains all the data in CSV format, along with some visuals.

* **complement.csv** contains the complement level dataset.

*  **complement_anti_C5.csv** holds the levels of sC5b-9 upon anti-C5 therapy.

*  **complement_function.csv** contains the ex vivo complement functional tests.

* **olink.csv** includes the 3000-plex proteomics dataset.

* **README.txt** includes metadata for the above files. 

## License

The code in this repository is released under the MIT license. Please refer to the **LICENSE** file for more information.

## Contact

If you have any questions or suggestions regarding the Complement Atlas, please contact us at karel.vandamme@ugent.be or bart.lambrecht@ugent.be.

Thank you for your interest in the Complement Atlas!

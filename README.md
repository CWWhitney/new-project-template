# Decision Modeling Template (R + decisionSupport)

This repository provides a **simple, reproducible template** for running a decision model in R using the **{decisionSupport}** package.

Conceptual overview and workflow philosophy:  
https://gist.github.com/CWWhitney/209bc9ee3a5bec7317863feaa6f4a66f

Rendered example output:  
https://htmlpreview.github.io/?https://github.com/CWWhitney/urban_school_gardens/blob/main/Index.html

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14767816.svg)](https://doi.org/10.5281/zenodo.14767816)

---

## What’s in this repository

A minimal decision model with:

- **One cost** (up-front)
- **One benefit** (annual stream)
- **One risk** (probabilistic reduction in benefits)
- **One outcome**: Net Present Value (NPV)

The goal is not complexity — it is **clear structure and reproducibility**.

## Project structure

```
project/
│
├── index.Rmd # Run the full analysis here
├── README.md
│
├── data/
│ └── inputs_decision.csv # Uncertain input parameters
│
├── scripts/
│ ├── Decision_Model.R # Decision model function
│ └── make_variables.R # Helper for testing variables
│
└── figures/ # Output plots (optional)
```

## How to use

1. Put uncertain inputs in `data/inputs_decision.csv`
2. Define model logic in `scripts/Decision_Model.R`
3. Run the simulation from **`index.Rmd`**
4. Knit `index.Rmd` to reproduce all results and figures

---

## Working style

- Keep everything reproducible from `index.Rmd`
- Keep the folder structure intact
- Start simple before adding model complexity

---

## Citation

If you use or adapt this template, please cite the Zenodo record above.

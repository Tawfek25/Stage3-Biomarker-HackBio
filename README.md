# Stage3-Biomarker-HackBio
# **Breast Cancer Biomarker Identification**
# Overview
This repository contains R code for analyzing RNA-seq data to identify biomarkers distinguishing between primary and metastatic breast cancer. The analysis includes differential expression assessment and functional enrichment analyses.

# Requirements
R (version 4.0 or later)
Required R packages: DESeq2, TCGAbiolinks, tidyverse, clusterProfiler, org.Hs.eg.db, enrichplot

# Installation
Install the necessary R packages using the following commands:
R
Copy code
install.packages(c("DESeq2", "TCGAbiolinks", "tidyverse", "clusterProfiler", "org.Hs.eg.db", "enrichplot"))

# Usage
## Load the Data
The script downloads RNA-seq data from the GDC (CMI-MBC project) and processes it to ensure it is ready for analysis.
## Preprocess the Data
Normalization is performed, and genes with more than 25 zero values are filtered out to maintain data quality. A random selection of 20 samples from each tumor type (primary and metastatic) is made.
## Differential Expression Analysis
The script conducts differential expression analysis using DESeq2, identifying significant differentially expressed genes (DEGs) based on adjusted p-values and log2 fold changes.
## Functional Enrichment Analysis
Gene IDs are mapped to ENTREZ IDs for GO and KEGG pathway enrichment analyses, revealing biological processes and pathways associated with the identified DEGs.

# Visualization
The script generates plots, including dot plots and bar plots, to visualize the enrichment results for GO and KEGG analyses.

# Files
bc_40_data.csv: Gene expression data used for the analysis.
DESeq2 results.csv: CSV file containing results from the differential expression analysis.
go_enrichment_results.csv: CSV file with results from GO enrichment analysis.
kegg_enrichment_results.csv: CSV file with results from KEGG pathway enrichment analysis.

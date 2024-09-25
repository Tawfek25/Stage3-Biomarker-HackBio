# stage-3-hackbio
# **Breast Cancer Biomarker Identification**
# Overview
This repository contains both python and R code for analyzing RNA-seq data to identify biomarkers distinguishing between primary and metastatic breast cancer. The analysis includes differential expression assessment and functional enrichment analyses, and machine learning classification using a Random Forest classifier. 

# Requirements
## R Requirements
R (version 4.0 or later)
Required R packages: DESeq2, TCGAbiolinks, tidyverse, clusterProfiler, org.Hs.eg.db, enrichplot

## Python Requirements
Python (version 3.6 or later)
Required Python packages: numpy, pandas, scikit-learn, matplotlib, seaborn

# Installation
## For R
Install the necessary R packages using the following commands:
R
Copy code
install.packages(c("DESeq2", "TCGAbiolinks", "tidyverse", "clusterProfiler", "org.Hs.eg.db", "enrichplot"))# 
## For Python
Install the necessary Python packages using the following commands:

pip install numpy pandas scikit-learn matplotlib seaborn


# Usage
## Load the Data
The script downloads RNA-seq data from the GDC (CMI-MBC project) and processes it to ensure it is ready for analysis.

## Preprocess the Data
### In R
Normalization is performed, and genes with more than 25 zero values are filtered out to maintain data quality. A random selection of 20 samples from each tumor type (primary and metastatic) is made.
### In python
Variance Filtering: Genes with low variance are filtered out.
Missing Value Filtering: Genes with more than 50% missing values are excluded.
Standardization: The cleaned data is standardized for uniformity.

## Differential Expression Analysis
The script conducts differential expression analysis using DESeq2, identifying significant differentially expressed genes (DEGs) based on adjusted p-values and log2 fold changes.
## Functional Enrichment Analysis
Gene IDs are mapped to ENTREZ IDs for GO and KEGG pathway enrichment analyses, revealing biological processes and pathways associated with the identified DEGs.

## Labeling
Labels are assigned for 40 samples, where the first 20 are metastatic (1) and the remaining 20 are primary (0).

## Dataset Split
The pre-labeled dataset is split into training (80%) and testing (20%) sets, focusing on features that show significant correlation with the labels.

## Machine Learning Classification
A Random Forest classifier is trained on the selected features. The model's performance is evaluated using accuracy, confusion matrix, and classification report metrics.

# Visualization
## In R
The script generates plots, including dot plots and bar plots, to visualize the enrichment results for GO and KEGG analyses.

## In python
The script generates visualizations, including:
1- Feature Importance Plot: Displays the importance of the top 20 genes for predictions.
2- Confusion Matrix Heatmap: Provides an overview of the model's performance.

# Files
bc_40_data.csv: Gene expression data used for the analysis.

DESeq2 results.csv: CSV file containing results from the differential expression analysis.

go_enrichment_results.csv: CSV file with results from GO enrichment analysis.

kegg_enrichment_results.csv: CSV file with results from KEGG pathway enrichment analysis.

brest_cancser_HackBio.py: Python code for data preprocessing and machine learning classification.

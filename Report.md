# **Authors** 

Logy Khaled (@Logy), Alaa Hewela (@Alaa253), Rahma mamdouh Mohammed (@Rahmamam2000), Tawfek Ahmed Tawfek (@Tawfekahmed25), Malak Abdelfattah Soula (@Malak),
Zeyad Ashraf (@Zashraf03), Nourhan Mahmoud (@NourhanM1) , Mohammed Dahab (@mdahab7)

## **GithubRepo**

https://github.com/Tawfek25/Stage3-Biomarker-HackBio

# **Introduction** 

This study compares **primary** and **metastatic breast cancer** to identify biomarkers that distinguish between these stages, essential for improving treatment strategies.

# **Dataset and Preprocessing**

**RNA-seq data** from the **CMI-MBC project**, comprising **40 samples** (**20 primary and 20 metastatic**), was obtained from GDC. Preprocessing involved data normalization and filtering genes with more than 25 zero values to ensure robust results. Random selection of 20 samples per group was performed.

# **Methodology** 

**Differential expression analysis** was conducted using DESeq2 to find differentially expressed genes based on an adjusted **p-value \< 0.05** and a **|log2FoldChange| \> 1**. Ensembl gene IDs were mapped to ENTREZ IDs for functional enrichment analysis. 

**GO enrichment** focused on biological processes, while **KEGG analysis** revealed relevant pathways.

# **Results**

The analysis identified key **differentially expressed genes** between primary and metastatic tumors. 

![image](https://github.com/user-attachments/assets/9c2491c8-037d-4a7e-8979-d001c0f887ee)


**GO Analysis** revealed significant biomarkers related to muscle structure and function, including muscle contraction and regulation of blood circulation.

![image](https://github.com/user-attachments/assets/16c10007-1f93-4f24-ab2b-61690a2af3d4)

![image](https://github.com/user-attachments/assets/82fe7cf6-9e64-4860-afaf-5f8700f3164d)

**KEGG pathway** analysis revealed significant involvement in cytoskeleton-related pathways in muscle cells and several cancer-associated pathways.

![image](https://github.com/user-attachments/assets/17f4a479-82f2-45ef-92c9-ec25e594793a)

![image](https://github.com/user-attachments/assets/97e91b86-5b25-47c1-aa62-3878fc4797f8)

# **Machine Learning Pipeline Overview**
This section outlines a machine learning pipeline that classifies gene expression data from breast cancer into primary and metastatic cases using a Random Forest classifier.

# Data Preparation
It begins by reading the dataset and cleaning; the genes with low variance are filtered out and those containing a lot of missing values. Preprocessed data are standardized so that all features must have the same scale.

# Labeling
Labels are provided for 40 samples, from which the first 20 are metastatic, labeled as 1, and the remaining 20 as primary, labeled as 0.

# Dataset Split
The dataset was split into 80% for training and 20% for testing, focusing on features correlated with the labels. This split takes those features into consideration that are highly interlinked with the given labels.

# Model Training
The model achieved 75% accuracy, evaluated using metrics such as a confusion matrix and classification reports.

# Visualizations
**1- Feature Importance Plot :**

Displays the top 20 genes that contributed to the predictions.

![Picture1](https://github.com/user-attachments/assets/365ef218-4dc4-4624-a4f4-ec1c10b91cf0)

 
**2- Confusion Matrix Heatmap :**

Shows true and false predictions to evaluate model performance.

![Picture2](https://github.com/user-attachments/assets/019d587a-3ab4-4c49-adec-dab87ec263ee)
 
These visualizations highlight the model's efficacy and the significance of various genes in breast cancer classification.



# **Conclusion**

This analysis suggests potential biomarkers for distinguishing between primary and metastatic breast cancer. The machine learning pipeline, using a Random Forest classifier, achieved 75% accuracy. Future research should validate these biomarkers, explore therapeutic applications, and enhance models for improved classification.

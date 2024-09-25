# **Authors** 

Logy Khaled (@Logy), Alaa Hewela (@Alaa253), Rahma mamdouh Mohammed (@Rahmamam2000), Tawfek Ahmed Tawfek (@Tawfekahmed25)

## **GithubRepo**

[https://github.com/Tawfek25/Stage3-Biomarker-HackBio]

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

# **Conclusion**

This analysis suggests potential biomarkers for distinguishing between primary and metastatic breast cancer. Future research should focus on validating these biomarkers and exploring their potential therapeutic applications.

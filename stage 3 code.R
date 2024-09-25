# Load required libraries
library(DESeq2)
library(SummarizedExperiment)
library(TCGAbiolinks)
library(DESeq2)
library(tidyverse)
library(airway)
library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)

##################################
# Downloading data from GDC
gdcprojects= getGDCprojects()
getProjectSummary("CMI-MBC")
gdcquery <- GDCquery(project = "CMI-MBC", data.category = "Transcriptome Profiling",
                     data.type = "Gene Expression Quantification",
                     experimental.strategy = "RNA-Seq",
                     workflow.type = "STAR - Counts",
                     access = "open",
                     barcode = samples <- c("MBCProject_3946_T4_RNA_1", "MBCProject_0832_T1_RNA_1", "MBCProject_1223_T2_RNA_1", "MBCProject_0524_T2_RNA_1", 
                                            "MBCProject_3946_T5B_RNA_1", "MBCProject_3946_T5A_RNA_1", "MBCProject_0026_T2_RNA_1", "MBCProject_3896_T3_RNA_1", 
                                            "MBCProject_3896_T5_RNA_1", "MBCProject_3946_T3_RNA_1", "MBCProject_4424_T2_RNA_1", "MBCProject_4424_T3_RNA_1", 
                                            "MBCProject_0988_T3_RNA_1", "MBCProject_0040_T2_RNA_1", "MBCProject_0852_T2_RNA_1", "MBCProject_0128_T3_RNA_1", 
                                            "MBCProject_4012_T1_RNA_1", "MBCProject_0003_T1_RNA_1", "MBCproject_0080_T2_RNA_1", "MBCproject_0227_T2_RNA_1",
                                            "MBCProject_0399_T1_RNA_1", "MBCProject_4647_T0_RNA_1", "MBCProject_4647_T1_RNA_1", 
                                            "MBCProject_0209_T1_RNA_1", "MBCProject_4989_T1_RNA_1", "MBCProject_1170_T1_RNA_1", "MBCproject_0107_T1_RNA_1", 
                                            "MBCProject_3896_T2_RNA_1", "MBCProject_3896_T1_RNA_1", "MBCProject_3896_T4_RNA_1", "MBCProject_1223_T1_RNA_1", 
                                            "MBCProject_3672_T1_RNA_1", "MBCProject_0589_T1A_RNA_1", "MBCProject_0504_T1_RNA_1", "MBCProject_0343_T1_RNA_1", 
                                            "MBCProject_1542_T2_RNA_1", "MBCProject_4989_T2_RNA_1", "MBCProject_0026_T1_RNA_1", "MBCProject_5927_T1_RNA_1", 
                                            "MBCProject_6127_T2_RNA_1"))
output <- getResults(gdcquery)
gdcbrca <- GDCprepare(gdcquery, summarizedExperiment = TRUE)
data <- assay(gdcbrca, "unstranded")

# Saving data to a file named 'bc 40 data.csv'
write.csv(data, "bc 40 data.csv", row.names = TRUE)

# Loading Data
data <- read.csv("bc 40 data.csv")

#Set rownames to gene IDs and remove the 'x' (gene ID) column
rownames(data) <- data$X  
data$X <- NULL            

# Keep only numeric columns
data <- data[, sapply(data, is.numeric)]

# Preprocess the Data
# Check for missing values
sum(is.na(data))

# Reduce to a Maximum of 20 Samples
sample_info <- colData(gdcbrca)
sample_info$tumor_descriptor <- as.factor(sample_info$tumor_descriptor)

primary_samples <- rownames(sample_info[sample_info$tumor_descriptor == "Primary", ])
metastatic_samples <- rownames(sample_info[sample_info$tumor_descriptor == "Metastatic", ])

# Randomly select 20 samples from each group
primary_selected <- sample(primary_samples, 20)
metastatic_selected <- sample(metastatic_samples, 20)
selected_samples <- c(primary_selected, metastatic_selected)

# Subset data and sample_info for selected samples
data <- data[, selected_samples]
sample_info <- sample_info[selected_samples, ]

####################################################################
#DESeq2 Analysis

# Remove genes with more than 25 zero values
dds <- DESeqDataSetFromMatrix(countData = data, colData = sample_info, design = ~ tumor_descriptor)
rownames(dds) <- rownames(data)  # Keep gene IDs in rownames
dds <- dds[apply(counts(dds), 1, function(row) sum(row == 0) <= 25), ]

# Differential expression analysis
dds <- DESeq(dds)
res <- results(dds)
summary(res)

# Filter and get significant genes
degs <- res[which(res$padj < 0.05 & abs(res$log2FoldChange) > 1), ]
deg_list <- rownames(degs)  # Extract gene IDs from the results
deg_list
# Save results to CSV
write.csv(as.data.frame(res), "results.csv")  # Save DESeq2 results
######################## Visualization #################################
plotMA(res)

############################################################################
#functional enrichment analysis

# Remove version numbers from Ensembl IDs
clean_ensembl_ids <- gsub("\\..*", "", deg_list)

# Check the cleaned Ensembl IDs
head(clean_ensembl_ids)


# Map gene symbols to ENTREZ IDs (needed for enrichment analysis)
gene_entrez <- bitr(clean_ensembl_ids, fromType = "ENSEMBL",
                    toType = "ENTREZID",
                    OrgDb = org.Hs.eg.db)

# Check the contents of gene_entrez
print(gene_entrez)

# GO enrichment analysis (Biological Process)
go_enrich <- enrichGO(gene = gene_entrez$ENTREZID, OrgDb = org.Hs.eg.db, keyType = "ENTREZID",
                      ont = "BP", pAdjustMethod = "BH", pvalueCutoff = 0.05, qvalueCutoff = 0.05)

# Save GO enrichment results to CSV
write.csv(as.data.frame(go_enrich), "go_enrichment_results.csv")

# KEGG pathway enrichment analysis
kegg_enrich <- enrichKEGG(gene = gene_entrez$ENTREZID, organism = 'hsa', pvalueCutoff = 0.05)

# Save KEGG enrichment results to CSV
write.csv(as.data.frame(kegg_enrich), "kegg_enrichment_results.csv")


###############################visualization###############################
# Dot and bar plot for GO enrichment results
dotplot(go_enrich, showCategory = 10) + ggtitle("GO Enrichment Analysis (Biological Process)")
barplot(go_enrich, showCategory = 10) + ggtitle("GO Enrichment Analysis (Biological Process)")

# Dot and bar plot for KEGG pathway enrichment results
dotplot(kegg_enrich, showCategory = 10) + ggtitle("KEGG Pathway Enrichment Analysis")
barplot(kegg_enrich, showCategory = 10) + ggtitle("KEGG Pathway Enrichment Analysis")

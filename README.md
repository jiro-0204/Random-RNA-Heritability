# Random-RNA-Heritability

## Overview

This repository contains source code for the paper [Emergent primordial heritability in short random RNA pools](https://www.biorxiv.org/content/10.64898/2026.06.14.732136v1). The data processing and analysis scripts are demonstrated using N14 dataset samples for clarity. The same procedures can be applied to other datasets (N14p, N20, SR_N14, etc.) with minor modifications. 

## Project Structure

```
code/
├── 1-data_processing.ipynb    # Data preprocessing pipeline
├── 2-analysis.ipynb           # k-mer-based, structural and other analysis
├── 3-visualization.ipynb      # Visualization of results
├── run_cutadapt.sh            # Sequencing read trimming script
├── run_blastn.sh              # BLAST searching script
└── data/                      # Data directory
    ├── raw_data/              # Raw FASTQ files
    ├── trimmed/               # Trimmed FASTQ files
    ├── raw_seqs_counts/       # Unique sequences and read counts as npy files
    ├── fasta/                 # FASTA files
    ├── tsv/                   # BLAST results
    ├── filtered/              # Filtered sequences
    └── processed/             # Final analyzed data
```

## Data Processing Pipeline

### Step 1: Prepare Raw Sequence Data

Place raw FASTQ files in `data/raw_data/{product_name}/` directory. The naming convention follows:
- `{product_name}_R{round}_1.fq.gz` - Read 1 (forward)
- `{product_name}_R{round}_2.fq.gz` - Read 2 (reverse)

### Step 2: Cutadapt trimming

Run the cutadapt script to trim raw reads and remove adapters:

```bash
bash run_cutadapt.sh
```

This script:
- Remove adapter sequences
- Removes poly(A)/poly(T) tails
- Trims 3 bp from the 5' or 3' end
- Filters by quality score (Q30)
- Retains sequences between 15-45 bp
- Outputs trimmed reads as FASTQ files to `data/trimmed/{product_name}/`

### Step 3: BLAST Sequence Alignment
Run `1-data_processing.ipynb` . After FASTA files are generated, perform BLAST against NCBI core_nt database:

```bash
bash run_blastn.sh
```

This script:
- Queries sequences against the core_nt database
- Outputs results to `data/tsv/{product_name}/`

### Step 4: Data Filtering and Aggregation
Run `1-data_processing.ipynb`, and the filtered dataset is organized as a list of DataFrames, where each DataFrame contains:
- **Seqs**: RNA sequence
- **Counts**: Read count for each sequence
- **Lens**: Sequence length

The list length corresponds to the number of rounds. Filtered data is stored in `data/filtered/`.

## Analysis

Run `2-analysis.ipynb` after completing data processing for all samples.

This notebook performs:
- Statistical analysis of sequence diversity
- Heritability calculations
- Structural and sequence pattern analysis, etc...

Analysis results are saved to `data/processed/`.

## Visualization

Run `3-visualization.ipynb` and generate figures for the paper.


## Requirements

The analysis requires the following Python packages:
- pandas
- numpy
- scipy
- scikit-learn
- numba
- matplotlib
- seaborn
- biopython
- ViennaRNA

Tools:
- cutadapt (for read trimming)
- BLAST+ (for sequence searching)

## Data Availability

- Raw FASTQ sequence data: NCBI BioProject repositry PRJNA1474794
- Processed analyzed data: `code/data/processed/`
# Random-RNA-Heritability

## Overview

This repository contains source code for the paper "Emergent primordial heritability in short random RNA pools". The data processing and analysis scripts are demonstrated using N14 dataset samples for clarity. The same procedures can be applied to other datasets (N14p, N20, SR_N14, etc.) with minor modifications. All raw FASTQ sequence data are available from the NCBI repository. Processed and analyzed data files are available in `code/data/processed/`.

## Project Structure

```
code/
├── 1-data_processing.ipynb    # Data preprocessing pipeline
├── 2-analysis.ipynb            # Statistical and structural analysis
├── 3-visualization.ipynb       # Visualization of results
├── run_cutadapt.sh            # Sequencing read trimming script
├── run_blastn.sh              # BLAST sequence alignment script
└── data/                      # Data directory
    ├── raw_data/              # Raw FASTQ files
    ├── trimmed/               # Trimmed FASTQ files
    ├── fasta/                 # FASTA sequences
    ├── tsv/                   # BLAST results
    ├── filtered/              # Filtered sequences
    └── processed/             # Final analyzed data
```

## Data Processing Pipeline

### Step 1: Prepare Raw Sequence Data

Place raw FASTQ files in `data/raw_data/{product_name}/` directory. The naming convention follows:
- `{round}_{lane}_1.fq.gz` - Read 1 (forward)
- `{round}_{lane}_2.fq.gz` - Read 2 (reverse)

### Step 2: Quality Trimming

Run the cutadapt script to trim raw reads and remove adapters:

```bash
./run_cutadapt.sh
```

This script:
- Removes poly(A)/poly(T) tails using 10bp adapter sequences
- Trims 3 bp from the 5' end
- Filters by quality score (Q30)
- Retains sequences between 15-45 bp
- Outputs trimmed reads to `data/trimmed/{product_name}/`

### Step 3: BLAST Sequence Alignment

After FASTA files are generated, perform BLAST against NCBI core_nt database:

```bash
./run_blastn.sh
```

This script:
- Queries sequences against the core_nt database
- Outputs results to `data/tsv/{product_name}/`
- Uses 16 parallel threads for faster processing

### Step 4: Data Filtering and Aggregation

The filtered dataset is organized as a list of DataFrames, where each DataFrame contains:
- **Sequence**: RNA sequence
- **Count**: Read count for each sequence
- **Length**: Sequence length

The list length corresponds to the number of selection rounds. Filtered data is stored in `data/filtered/`.

## Analysis

### Step 1: Run Analysis Pipeline

Execute the analysis notebook after completing data processing for all samples:

```bash
jupyter notebook code/2-analysis.ipynb
```

This notebook performs:
- Statistical analysis of sequence diversity
- Heritability calculations
- Structural and sequence pattern analysis

### Step 2: Output Files

Analysis results are saved to `data/processed/` and include:
- Diversity metrics across rounds
- Heritability scores
- Structural predictions
- Summary statistics

## Visualization

Generate publication-ready figures by running:

```bash
jupyter notebook code/3-visualization.ipynb
```

This notebook creates:
- Sequence diversity plots
- Heritability trends
- Comparative analyses
- High-resolution publication figures

## Requirements

The analysis requires the following Python packages:
- pandas
- numpy
- scipy
- matplotlib
- seaborn
- biopython

Tools:
- cutadapt (for read trimming)
- BLAST+ (for sequence alignment)

## Data Availability

- Raw FASTQ sequence data: NCBI BioProject repository
- Processed analyzed data: `code/data/processed/`
- Key results: Available upon request

## Citation

Please cite this work as:
> Emergent primordial heritability in short random RNA pools

## License

Please refer to the repository for license information.
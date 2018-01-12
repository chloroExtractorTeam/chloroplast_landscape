# Chloroplast Landscape
Chloroplast landscape for different plant species

## Goal
The main goal of this project is to reconstruct as many whole chloroplast genomes as possible from public data on SRA.
The reconstruction should be done *de novo* from the raw sequencing reads and not by mapping against a reference.
This way many chloroplast genomes for species with and without existing reference genome will be added to the pool of available chloroplast genomes.
Among those the chloroplast genomes of all cultivars of the 1001 *Arabidopsis* genome project will give insights into intraspecific variations.
Many biological questions can be addressed with this dataset, among those:
 - Endosymbiontic Gene Transfer
 - Chloroplast Genome Evolution
 - Chloroplast Genome Reconstructions (large scale)
 - Applicability of Whole Chloroplast Genomes as DNA Barcodes

In addition to that the process of genome reconstruction can be used to compare the performance of three existing tools for this process: ORG.asm, fast-plast and chloroExtractor.
All three tools are specifically designed to assemble chloroplast genomes from whole genome sequencing information.
Applying all three on the same dataset will allow to compare their performance, strengths and weaknesses.
In case of complimentarity a combination of tools might be better than each individual one.
Although, chloroExtractor has been developed by us the analysis shall not be biased to favor our tool.

### Arabidopsis Chloroplasts
#### Research Question
Are there large-scale genome reorganizations in the chloroplast genomes of the 1k sequenced *Arabidopsis thaliana*?

#### Background
Often only SNP data for closely related organisms are considered.
But is this enough? Or is there more signal in the genome architecture?
Whole chloroplast genomes might be used for barcoding.
Are they better than conventional markers on sub-species level?
Do we need to take genome organization and structure into account or is sequence enough?

#### Method
Assemble all Arabidopsis chloroplasts *de novo* with ORG.asm, fast-plast, and chloroExtractor.
Preferrably the pipeline should be started with a list of SRA numbers and then, download the fastq files (optionally only to a given depth/number of spots), start all three assemblers (maybe fast-plast should be started on the scaled reads of chloroExtractor, as preliminary results suggest), optionally clean up to free space (remove intermediate files and raw reads).
For each SRA and Tool assess in three categories: (1) complete, (2) partial, (3) fail.
This should help to assess the success rate and complementarity of the tools.
A success rate of at least 50% is desired for the Arabidopsis chloroplasts (with paired end Illumina library).
An automatic assessment pipeline comparing the assembled chloroplasts to a set of references to get both SNPs and large-scale rearrangements together with WGA visualization needs to be developed.
Also annotation of the chloroplast genomes to compare gene sets, synteny, etc. is required.
Maybe all genomes can be stored in a variation graph format (https://github.com/vgteam/vg) for convenient analysis and visualization.
Further things to look at: GC-Content, codon usage, length of IR/SSC/LSC, whole-chloroplast phylogeny (compare to single gene/nuclear genome pyhlo).

#### Links
 - [Variation Graphs](https://github.com/vgteam/vg)
 - [PhyloAlps](http://phyloalps.org/)
 - [ORG.asm](http://pythonhosted.org/ORG.asm/index.html)

#### Literature
 - [Genome Graphs](http://dx.doi.org/10.1101/101378)
 - [Endosymbiotic Gene Transfer](https://www.nature.com/articles/nrg1271)
 - [Chloroplast Review](https://dx.doi.org/10.12703%2FP6-40)
 - [Chloroplast Genome Review](https://doi.org/10.1186/s13059-016-1004-2)
 - [Verdant](https://doi.org/10.1093/bioinformatics/btw583)


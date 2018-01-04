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

In addition to that the process of genome reconstruction can be used to compare the performance of three existing tools for this process: org.ASM, fast-plast and chloroExtractor.
All three tools are specifically designed to assemble chloroplast genomes from whole genome sequencing information.
Applying all three on the same dataset will allow to compare their performance, strengths and weaknesses.
In case of complimentarity a combination of tools might be better than each individual one.
Although, chloroExtractor has been developed by us the analysis shall not be biased to favor our tool.

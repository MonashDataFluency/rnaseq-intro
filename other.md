# All about RNAseq

## General

- Functional annotation of the mouse (FANTOM)
- Encyclopedia of DNA elements (ENCODE)
- Single loci can lead to  to six different mRNA isoforms, on average, instead of single transcript 

## Technology

What is it for?

- what is expressed (exon locatios /strand) ?
- how much is expressed (hits per transcripts) ?

old way to do  DE - microarray

- do need as much starting material for RNAseq

Noise:

- biological 
- poisson noise from samplinig (have level of uncertanty at low level, low counts)
- technical 

- Effect size (do the genes go up by alot or not - high signal)
- amount of variation

get better depth using poly-A enriched, because rRNA depletion will leave lots of other RNA around therefore diluting mRNA by some percent

mean fragment size ~ 300 bp 

measure of uncertanty of the base call

## Differential expression (DE)

- library size is total number of mapped reads. Library size might vary for individual samples.
- Total number of reads per gene proportional to:

    - gene expression level (to get cpm (count per million) divide each read count by library size multiplied by million). This is enable you to compare different library sized samples
    - transcript length
    - sequencing depth of the library
# Ideas

- have a url with multiqc report ready for browsing
- explain reference file (FASTA) and annotation files (GTF)

# Lesson plan

Perhaps it'll be good idea to introduce several different plain text files

- `txt`
- `csv/tsv`
- `gff/gff3/gtf`
- `fastq/fq`
- `fasta/fa/faa/fna`


DO NOT unzip your fastq file and store them as plain text !
DO NOT mess with your raw fastq files!

# Meeting notes

This is overall them of the day

> How to instruct them to be good RNAseq user? 

have a url with multiqc page ready? 

This is 

explain reference file (FASTA) and annotation files (GTF)

This if you can set up ftp link so that users can pont and click through
directory structure to interact with the sikRun output.

Mentione salmon


Good to mention in parsing - salmon 
if you are using salmon you not going to see DNA contamination. so something to be aware.

Also mentione that this is for model organism that are well annotation/assembled.

Use Chiara's data to study chromosome 21. From multiqc report chromosome 21 has a lot more reads. 
It looks like ribosomal contamination even though library was polyA pooled. 

Take all reads from chr21 and do feature counts and look where reads go. Suspecting that reads
go to ribosomal genes. If so this would be great case study for the workshop.

https://www.ncbi.nlm.nih.gov/pubmed/29788454

genotify

Reproducible research using the same reference files

TCGA for example is using a single reference for the whole cohort 

If you gonna do second study e.g chipSeq you gotta have it on the same reference as your RNAseq

there is no such thing as "the reference genome" there are different builds, it is work in progress

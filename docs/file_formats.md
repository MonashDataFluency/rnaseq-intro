# File formats

## Introduction

Bioinformatics file types doen't different form any other files type. Broadly any computer file is divided into either a plain text or binary files. The type doesn't matter; plain text files are "easy" to interact by it's nature it is plain text, whereas binary files requrie specialised tooling for interfacing with the file.
Note that it is very common to zip plain text files, which simply means reducing the size of the file, which is better for storage purposes. Once zipped file is no longer plain text - it is binary now. It is a natural behaviour to unzip those file before looking inside. It is okay to do so, but be aware that this isn't the best practice, and you don't want to be storing your files in plain text, this will eat up your disk space very quickly.

What is a file format?

It is defined structure with in the file. By far the most common structure of the plain text file is tabular, just like your conventional spreadsheet, where each column is separate by either a comma or a tab.

### Comma Separated Variables (CSV)

```
Gene.ID	Chrom	Gene.Name	Biotype	KO3_S3	KO4_S4	WT1_S1	WT2_S2
ENSMUSG00000051951	1	Xkr4	protein_coding	0	0	0	0
ENSMUSG00000025900	1	Rp1	protein_coding	0	0	0	0
ENSMUSG00000109048	1	Rp1	protein_coding	0	0	0	0
ENSMUSG00000025902	1	Sox17	protein_coding	0	0	0	0
ENSMUSG00000033845	1	Mrpl15	protein_coding	934	1317	888	939
ENSMUSG00000025903	1	Lypla1	protein_coding	705	848	647	747
ENSMUSG00000104217	1	Gm37988	protein_coding	0	0	0	0
ENSMUSG00000033813	1	Tcea1	protein_coding	354	436	368	442
ENSMUSG00000002459	1	Rgs20	protein_coding	0	0	0	0
```

### Tab Separated Variables (TSV)

```
Gene.ID,Chrom,Gene.Name,Biotype,KO3_S3,KO4_S4,WT1_S1,WT2_S2
ENSMUSG00000051951,1,Xkr4,protein_coding,0,0,0,0
ENSMUSG00000025900,1,Rp1,protein_coding,0,0,0,0
ENSMUSG00000109048,1,Rp1,protein_coding,0,0,0,0
ENSMUSG00000025902,1,Sox17,protein_coding,0,0,0,0
ENSMUSG00000033845,1,Mrpl15,protein_coding,934,1317,888,939
ENSMUSG00000025903,1,Lypla1,protein_coding,705,848,647,747
ENSMUSG00000104217,1,Gm37988,protein_coding,0,0,0,0
ENSMUSG00000033813,1,Tcea1,protein_coding,354,436,368,442
ENSMUSG00000002459,1,Rgs20,protein_coding,0,0,0,0
```

For the purpose of understanding RNAseq experiment the bear minimum you'll need to understand are these three file types:

- FASTQ 
- FASTA
- GFF/GTF

#### FASTQ

This is a very important file(s) you don't mess directly with FASTQ files. Best not to every unzip those either. If think that you need to do some thing fastq files in terms of editing or some other out of ordinary manipulations. Make a copy and work on the copy. If you modify, corrupt or loose your FASTQ files, days, month or year of wet-lab work go down a toilet, let a lone large sum of money spend on RNA extraction, library prepartion and sequencing.

#### FASTA

There are a few different fasta files, but all of them will hold some sort of sequence. Sometime you'll see `.fna` to inidicate nuclear sequence or `.faa` to indicate amino acid sequence, but more generally it'll be `.fa` or a longer version `.fasta`. Like any biological plain text file. This most certainly will be zipped so expect to see `.fa.gz` or `.fasta.gz`.

For the purpose of RNAseq analysis know that FASTA file holds your reference sequence. 

#### GTF/GFF

These are annotation files


There are many different biology / bioinformatics related file formats. You will naturally come across different files
formats. It doesn't matter so much what they are called, i.e what they file extention is, rather what they hold. 

Essentially all bioinformaticie files are either plain text (a.k.a ASCII) or binnary. Plain text files are "easy" to interface with. Unix/Linux command line provide many great tools that can work with plain text files. To list a few populart and powerful command line tools:

- `grep` search for a pattern
- `sed` search and replace
- `awk` search and replace and more
- `cat` look inside
- `cut` what the knife would do to bread

It is out of the scope of this course to go through any of the tools or command line in general, but if you going to do any kind of bioifnormatics you'll eventually going to come across these tools.

The other file type is binnary, this will requires designated tool for interfacing with the file for example SAM/BAM files have `samtools` that aid interaction with them.


## Plain text files


Given that we know the structure of the file TSV or CSV we can use standard command line tools to get relevant/interesting bits e.g

```
~$ cut -f1,3,5-6 t.tsv

Gene.ID	Gene.Name	KO3_S3	KO4_S4
ENSMUSG00000051951	Xkr4	0	0
ENSMUSG00000025900	Rp1	0	0
ENSMUSG00000109048	Rp1	0	0
ENSMUSG00000025902	Sox17	0	0
ENSMUSG00000033845	Mrpl15	934	1317
ENSMUSG00000025903	Lypla1	705	848
ENSMUSG00000104217	Gm37988	0	0
ENSMUSG00000033813	Tcea1	354	436
ENSMUSG00000002459	Rgs20	0	0
```

## Glossary

- interface: extract or insert relevant information


# Raw data

## Introduction

The raw data comes from a sequencing instrument, Illumina instruments appears to dominate short-read sequencing described earlier. 

## FASTQ

This is a very important file(s) you don't mess directly with FASTQ files. Best not to every unzip those either. If think that you need to do some thing fastq files in terms of editing or some other out of ordinary manipulations. Make a copy and work on the copy. If you modify, corrupt or loose your FASTQ files, days, month or year of wet-lab work go down a toilet, let a lone large sum of money spend on RNA extraction, library preparation and sequencing.

Your reads come in the form of FASTQ files. By far the most dominant way of organising your FASTQ files one per sample. For example if your experiment is a straightforward `TP53` knock-out in mice. You'll need bear minimum 4 mice, best to get 6, this is 3 control and 3 tp53 knock-outs. This is way you have three replicates to account for mouse to mouse variability and have a better chance of estimating actual difference due to knock-out.

You should receive these files from sequencing facility:

```
cntr_rep1_R1.fastq.gz
cntr_rep2_R1.fastq.gz
cntr_rep3_R1.fastq.gz

tp53_ko_rep1_R1.fastq.gz
tp53_ko_rep2_R1.fastq.gz
tp53_ko_rep3_R1.fastq.gz
```

The naming of the files is completely up to you. Sequencing facility doesn't care about the names, as long as you give them 6 different microtubes with some unique naming on the lid, but remember that giving clear names simplifies the matter. Bioinformatician might be able to infer from FASTQ file names what the experiment was.

> Question1: How many FASTQ files do you expect in a single-end experiment with 6 samples?

Remember that if you decided to sequence from both ends of the reads i.e paired-end sequencing, you'll give FASTQ file for each sample for each end. You should expect double the number of samples. It is important to have exactly double the number of files, because downstream analysis will rely on those files and will break if not supplied.

```
cntr_rep1_R1.fastq.gz 
cntr_rep1_R2.fastq.gz

cntr_rep2_R1.fastq.gz
cntr_rep2_R2.fastq.gz

cntr_rep3_R1.fastq.gz
cntr_rep3_R2.fastq.gz

tp53_ko_rep1_R1.fastq.gz
tp53_ko_rep1_R2.fastq.gz

tp53_ko_rep2_R1.fastq.gz
tp53_ko_rep2_R2.fastq.gz

tp53_ko_rep3_R1.fastq.gz
tp53_ko_rep3_R2.fastq.gz
```

> Question2: How many FASTQ files do you expect in a paired-end experiment with 6 samples?

One other thing that you should be aware is that sometimes to get extra deep sequencing your individual samples can be split across different lanes on the sequencing instrument (mainly talking about Illumina instruments here). This might seem confusing but you will need to multiple your samples by number of lanes. If you have single-end data of 6 sample that were split across 2 lanes then you are going to end up with 12 FASTQ files.

```
cntr_rep1_R1_L001.fastq.gz
cntr_rep1_R1_L002.fastq.gz

cntr_rep2_R1_L001.fastq.gz
cntr_rep2_R1_L002.fastq.gz

cntr_rep3_R1_L001.fastq.gz
cntr_rep3_R1_L002.fastq.gz

tp53_ko_rep1_R1_L001.fastq.gz
tp53_ko_rep1_R1_L002.fastq.gz

tp53_ko_rep2_R1_L001.fastq.gz
tp53_ko_rep2_R1_L002.fastq.gz

tp53_ko_rep3_R1_L001.fastq.gz
tp53_ko_rep3_R1_L002.fastq.gz
```

If your samples have been split across 3 lanes you are going to have 18 FASTQ files.

```
cntr_rep1_R1_L001.fastq.gz       -
cntr_rep1_R1_L002.fastq.gz       | cntr_rep1
cntr_rep1_R1_L003.fastq.gz       -

cntr_rep2_R1_L001.fastq.gz       -
cntr_rep2_R1_L002.fastq.gz       | cntr_rep2
cntr_rep2_R1_L003.fastq.gz       -

cntr_rep3_R1_L001.fastq.gz       -
cntr_rep3_R1_L002.fastq.gz       | cntr_rep2
cntr_rep2_R1_L003.fastq.gz       -

tp53_ko_rep1_R1_L001.fastq.gz    -
tp53_ko_rep1_R1_L002.fastq.gz    | tp53_ko_rep1
tp53_ko_rep1_R1_L003.fastq.gz    -

tp53_ko_rep2_R1_L001.fastq.gz    -
tp53_ko_rep2_R1_L002.fastq.gz    | tp53_ko_rep2
tp53_ko_rep2_R1_L003.fastq.gz    -

tp53_ko_rep3_R1_L001.fastq.gz    -
tp53_ko_rep3_R1_L002.fastq.gz    | tp53_ko_rep3
tp53_ko_rep3_R1_L003.fastq.gz    -
```

Note that when samples are split across lanes they become technical replicates and they are typically merged into single file. Also note that if you instead had paired end data you will have to further multiple by 2 to get total number of FASTQ file. 

```
cntr_rep1_R1_L001.fastq.gz      -
cntr_rep1_R2_L001.fastq.gz      |
                                |
cntr_rep1_R1_L002.fastq.gz      | cntr_rep1
cntr_rep1_R2_L002.fastq.gz      |
                                |
cntr_rep1_R1_L003.fastq.gz      |
cntr_rep1_R2_L003.fastq.gz      -

cntr_rep2_R1_L001.fastq.gz      -
cntr_rep2_R2_L001.fastq.gz      |
                                |
cntr_rep2_R1_L002.fastq.gz      | cntr_rep2
cntr_rep2_R2_L002.fastq.gz      |
                                |
cntr_rep2_R1_L003.fastq.gz      |
cntr_rep2_R2_L003.fastq.gz      -

cntr_rep3_R1_L001.fastq.gz      -
cntr_rep3_R2_L001.fastq.gz      |
                                |
cntr_rep3_R1_L002.fastq.gz      | cntr_rep2
cntr_rep3_R2_L002.fastq.gz      |
                                |
cntr_rep2_R1_L003.fastq.gz      |
cntr_rep2_R2_L003.fastq.gz      -

tp53_ko_rep1_R1_L001.fastq.gz   -
tp53_ko_rep1_R2_L001.fastq.gz   |
                                |
tp53_ko_rep1_R1_L002.fastq.gz   | tp53_ko_rep1
tp53_ko_rep1_R2_L002.fastq.gz   |
                                |
tp53_ko_rep1_R1_L003.fastq.gz   |
tp53_ko_rep1_R2_L003.fastq.gz   -

tp53_ko_rep2_R1_L001.fastq.gz   -
tp53_ko_rep2_R2_L001.fastq.gz   |
                                |
tp53_ko_rep2_R1_L002.fastq.gz   | tp53_ko_rep2
tp53_ko_rep2_R2_L002.fastq.gz   |
                                |
tp53_ko_rep2_R1_L003.fastq.gz   |
tp53_ko_rep2_R2_L003.fastq.gz   -

tp53_ko_rep3_R1_L001.fastq.gz   -
tp53_ko_rep3_R2_L001.fastq.gz   |
                                |
tp53_ko_rep3_R1_L002.fastq.gz   | tp53_ko_rep3
tp53_ko_rep3_R2_L002.fastq.gz   |
                                |
tp53_ko_rep3_R1_L003.fastq.gz   |
tp53_ko_rep3_R2_L003.fastq.gz   -
```

## Unix tooling

There are many different biology / bioinformatics related file formats. You will naturally come across different files
formats. It doesn't matter so much what they are called, i.e what they file extension is, rather what they hold. 

Essentially all bioinformatics files are either plain text (a.k.a ASCII) or binary. Plain text files are "easy" to interface with. Unix/Linux command line provide many great tools that can work with plain text files. To list a few popular and powerful command line tools:

- `grep` search for a pattern
- `sed` search and replace
- `awk` search and replace and more
- `cat` look inside
- `cut` what the knife would do to bread

It is out of the scope of this course to go through any of the tools or command line in general, but if you are going to do any kind of bioinformatics you'll eventually going to come across these tools.

The other file type is binary, this will requires designated tool for interfacing with the file for example SAM/BAM files have `samtools` that aid interaction with them.



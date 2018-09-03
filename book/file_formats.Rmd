# Bioinformatics file formats

Before diving into specific file formats. I would like to discuss what could file actually mean and hold in general, after all bioinformatics files aren't that different form any other files. In fact fair number of bioinformatics files are just a variant of [TSV file format](#tab-separated-variables), discussed shortly.
Bioinformatics world largely rotates around Unix/Linux ecosystem, and remember that macOS is Unix derived operating system too. That means that a lot of the tooling and compute happens on linux computers often referred to as servers. In unix world file name is simply a string of letters (text) that points to a location of that file content that is stored elsewhere. Therefore the only thing that matters for file names is they are unique. Often people get caught out by file's extensions, they do not matter. File extentions are simply an indicator for a user what to expect when they are going to open that file. To more accurate other programs often look at file extensions too trying to guess if this is the file format they can handle. In general it is a very good idea to have correct file extension. I just want you to know that just because you've renamed a file from `ref.fasta` to `ref.fa` nothing had happened to it content. Bioinformatics is an evolving field and new technologies will bring about new file formats.

## Introduction

Broadly speaking any computer file is either a plain text or binary format. Under the hood everything is binary of course, but a plain text file can be looked at and modified using standard unix/linux tool sets as well simply opened with any text editor for more custom modification. If the file isn't plain text you have to have specific tool to work with that file type. For example pdf files aren't plain text and this is why you need pdf viewer (e.g adobe reader) to work with pdfs. Similarly in bioinformatics BAM files aren't plain text and do require `samtools` to work with it. As I've hinted earlier large number of bioinformatics files are plain text, however a lot of the times plain text files are ziped with `gzip` tool adding another suffix to the file name and thereby changing the file into binary for that now will require `gzip` tool to work with. We zip file to reduce they size. Zipping works particular well on files that have repetitive patterns e.g repeats of ATCG sequence.

Note the difference in size is essentially three times !

```
-rw-r--r-- 1 kirill kirill 3.0G Apr 10 10:11 Homo_sapiens.GRCh38.dna_sm.removed_contigs.fa
-rw-r--r-- 1 kirill kirill 895M Apr 10 10:10 Homo_sapiens.GRCh38.dna_sm.removed_contigs.fa.gz
```

It is a natural behaviour wanting to unzip file before looking inside. It is okay to do so, but be aware that this isn't the best practice, and you don't want to be storing your files in plain text for a long time, this will eat up your disk space very quickly.

```
example of large BAM file and plain text SAM
```

Remember that best practice is always keep your files zipped 

Let's talk next about what makes different file formats different

## What is a file format?

The file format at it simplest defines structure with in the file. By far the most common structure of the plain text file is tabular. The spreadsheet that everyone is so familiar with is simply a plain text file with rows and columns, where each cell separated by a "special" character called `tabular` or `tab` for short, which makes tab separated variables file or tsv for short with a sister file of comma separated variables or csv for short where instead of `tab` character comma is used.

**Tab Separated Variables (tsv)**

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

**Comma Separated Variables (csv)**

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

Common bioinformatics files such gff/gtf, bed and vcf are all variant of tsv in some respect except with defined column names and hence value types that can fit in those columns. I haven't explained what each of those files used for. Let's focus on gff/gtf format only and leave the other two for later discussion. 

## Annotation files

The essence of annotation file, guessable from the name, is to provide information of coordinates of features in the genome. A feature could mean several things including a gene, transcript, exon, 3'UTR or any other region of the gnome that is "worth" documenting. Basically this is your google map without pictures. If you think about what information would you need in order to identify a gene for example well known tumor suppressor gene `TP53`. 

- bear minimum we need to know which chromosome it is one
- where about it is on chromosome 17
- remember that humans are diploid - which strand of chromosome 17 it is on 

In a simply tabular format this would look like this

```
tp53	chr17	7661779	7687550	+
```

Turns out that this is actually is an annotation file format called [Simplified Annotation Format (SAF)](http://bioinf.wehi.edu.au/featureCounts/). It isn't that widely used, because it has some limitations, which is outside of the course to discuss and there are at least three other annotation formats that exist, which we not going to discuss any further.
Side tracking to our earlier discussion about file extensions, `saf` is a file format given that it has defined structure, but what should the extension be? Anything you like `.txt` because it is a text file, `.tsv` well it is tab separated. I usually do `.saf`, because that tells me straight away exactly what the content of the file is. This is what file extension supposed to do.

The file format that we are going to focus on is General Feature Format (gff)

- Plain text file format
- The format was proposed as a means to transfer feature information
- We do not intend GFF format to be used for complete data management of the analysis and annotation of genomic sequence
- Originally wanted file format that will be easily parsable by Unix tools such `grep`, `sort` and `awk`

## Glossary

- interface: extract or insert relevant information


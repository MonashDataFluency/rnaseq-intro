# Reference sequence

In this course will be focusing on DNA/RNA molecules and hence our sequences will be nucleotides sequences. In the case of *Mus_musculus* (mouse) genome, we have 19 autosomal chromosomes and two sex chromosomes X and Y plus a mitochondrial chromosome (genome). This makes up 22 separate molecules and therefore 22 separate sequences. Typically that sequence is stored in **FASTA** file format

- FASTQ for raw short reads
- FAST5 for raw long reads
- FASTA for any other kind of sequence

The other possible bioinformatics files that we weren't focus on are, genbank and gff. Both of those files can hold annotation and sequence information in one file. It often works fine with small genomes, but large eukaryotic genomes are better split into two files reference sequence and annotation information.

### FASTA

FASTA file typically can hold any type of sequence data. We are not going to talk about amino acid sequence in this course and so for your purpose we can think of FASTA as just holding nucleotides sequence. That sequence can be anything, primer or adapter sequence, individual transcripts (genes) sequence OR entire chromosome sequence. In the case when FASTA holds entire genome, that is all chromosomes for a given species, we tend to refer to that FASTA file as a reference genome file. If I'm asking biologist of a **reference genome**, I typically imply that I need a FASTA file with genomic sequence.

Be aware that there isn't such thing as "the genome" for a particular species. This is because any genome is a 

There are a few different fasta files, but all of them will hold some sort of sequence. Sometime you'll see `.fna` to inidicate nuclear sequence or `.faa` to indicate amino acid sequence, but more generally it'll be `.fa` or a longer version `.fasta`. Like any biological plain text file. This most certainly will be zipped so expect to see `.fa.gz` or `.fasta.gz`.

Note that 
our purpose we can think of FASTA file holding our reference genome sequence of intereste e.g mouse genome.

This is previously assembled genome that was made puplically available. There are several different vendors that provide reference genomes. In general either one of these three will is a good place to start looking for you reference genome. 

- [Ensembl](https://asia.ensembl.org/index.html)
- [RefSeq](https://www.ncbi.nlm.nih.gov/refseq/)
- [UCSC genomes](http://hgdownload.soe.ucsc.edu/downloads.html)

Those will have majority of species, however it is common to have a stand along community that host reference genomes from a different place. A good example is [yeast genome database](https://www.yeastgenome.org/). If you are working with yeast this is the place to look for reference genomes.

It is important to note that reference genome isn't a defined sequence. It is simply the best we have so far and it is a continuos effort to improve quality of the genomes. For widely used model organisms like mouse and yeast their genomes have been sequenced and assembled many times over the years and we have very good quality genomes. Species like axolotl or spiny mouse are less commonly used as model organism in comparison to mouse genomes and quality of those genomes is poorer. There are however other factors in place that influence genome quality e.g genome complexety.

## Exercise

- go to [Ensembl website](https://asia.ensembl.org/index.html)
- from the drop down on the left hand site select *Saccharomyces_cerevisiae*, which is a yeast species.
- click on download FASTA file. This will redirect you to ftp site
- find file **Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa.gz** and download it by clicking
- once downloaded double click on the file to open it and view the content.

depending on the operating system that you have you might have to unzip fasta file first before opening.
It is best not to open with MS Office suite. Use text editor instead. On windows it'll be `notepad` on macOS it'll `textmate`.

At the very top you should see this

```
>I dna_sm:chromosome chromosome:R64-1-1:I:1:230218:1 REF
ccacaccacacccacacacccacacaccacaccacacaccacaccacacccacacacaca
caTCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTT
ACCCTCCATTACCCTGCCTCCACTCGTTACCCTGTCCCATTCAACCATACCACTCCGAAC
```

Note the very first line. 

```
>I dna_sm:chromosome chromosome:R64-1-1:I:1:230218:1 REF
```

This is a FASTA header that indicates which sequence is follows. In this case it is `I` i.e sequence from chromosome one of yeast.
If there are multiple chromosomes (usually the  case for eukaryotic species) then you keep reading the sequence until you hit either the end of the file OR the next ">" sign

**NOTE the actual sequnce have been truncated**

```
>I dna_sm:chromosome chromosome:R64-1-1:I:1:230218:1 REF
ccacaccacacccacacacccacacaccacaccacacaccacaccacacccacacacaca
caTCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTT
ACCCTCCATTACCCTGCCTCCACTCGTTACCCTGTCCCATTCAACCATACCACTCCGAAC
>II dna_sm:chromosome chromosome:R64-1-1:II:1:813184:1 REF
CCCACACACCACACCCACACCACACCCACACACCACACACACCACACCCACACACCCACA
CCACACCACACCCACACCACACCCACACACCCACACCCACACACCACACCCACACACACC
ACACCCACACACACCCACACCCACACACCACACCCACACACACACCACACCCACACACAC
CACACCACACCCACACCACACCCACACCCACACACCACACCCACACCCACACCCCACACC
```

The format of the FASTA header is rather loosely defined, but these are key points:

- must start with ">" sign
- the contig/chromsome name follows straight after ">" sign. Can be any string
- anything after a space is a comment/description 

Below are all valid FASTA headers

```
>I
```

```
>chrI
```

```
>NC_000067.6
```

```
>I_named_it
```

Each header in a single FASTA file has to be uqniue in order to identify each sequence.

> Are this two FASTA header the same?

```
>I
```

```
>I named it
```

> Are this two FASTA header unique?

```
>I
```

```
>I_named_it
```

While this apper to be very are small details, the reason it is important because you want to know which chromosome (molecule) your reads came from.

## Rule of thumb

Unless you are working with some exotic species and/or have a strong prefernce for genome vendor you can generally leave this part up to your bioinformatician to sort out. It is important to know that there are different vendors that have different versions (builds) of genomes. 

. Often times bacterial RNAseq data come with some custome reference and annotation files. If that happens bioinformatician will need to convert everythign to FASTA and GTF/GFF files.



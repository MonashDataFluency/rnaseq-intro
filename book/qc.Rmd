# QC

I hope that everyone appreciates important of checking things for quality. Any kind of work needs to be checked for some kind of integrity, being it agarose gel run, testing for whether the bands - DNA/RNA is present, or some spectorphotometer technique tesing absorbs of light at 260nm. Similarly in bioinformatics world we also quality checks or QCs for short. I've broken this chapters into different QC's we typically do, dedicating a section for each type of QC.

## Number of mapped reads

This would be one of the simplest checks that one should do or ask for, how many of my sequenced reads mapped to the reference genome? In previous chapter it was mentioned that the reference genome of any species is work in progress and that it'll will change with time and between different vendors. Although this is a become less true for mouse (*Mus_musculus*) genome as it has been extensively studied, but never the less one shouldn't assume the genome is static and is the "golden reference" so to speak. 

Typically for mouse RNAseq data we tend to see anywhere between 80 and 99 percent. It is rare to see 100 % mapping to the reference in mouse at least and if you did I'd be a little worried. You should however not think of this or any other metrics as plain cutoff at a set value, rather think about what that means. Having seen a few mouse RNAseqs I'm not concern if mapping rate is above 80 %. If I'm seeing mapping rate lower than that. I have to start asking the question; Where do those 20-30% of reads come from? 

- Is my reference not of high quality? 
- Have the samples been contaminated?
- Why those reads don't map?

    - How long are the reads? (shorter reads harder to map)
    - skewed library? 
    - bad quality reads (issue at the sequencer machine?)

As you can see there are number of possible things that could happened. One should brain storm all possible ways thing could have gone wrong and then try to rule out and thereby narrow down on possible problems. In general different QC metrics augment each other. This is why a tools like [MultiQC](http://multiqc.info/) is a great way to aggregate result in a single report. 

In the case of mouse genome, it is unlikely to be the problem with the genome quality, unless you've used some alternative version, so we can rule that out. As somebody who potentially extracted RNA you should be able to go back and check the lab book notes for wet-lab QC's and rule contamination out on your end. Perhaps sequencing facility didn't do a good job on they end.

The good place to start troubleshooting low mapping is to simply grab unmapped reads and [BLAST (basic local alignment search tool)](https://blast.ncbi.nlm.nih.gov/Blast.cgi) against all possible species databases (NCBI). Provided the read(s) had a hit, this should give you pretty good understanding of the potential contamination source. The reads don't have to have a hit, and if they don't once again you need to think critically what that means. Is there something in your biology that could lead to unknown reads or chimeric reads or once again an artifact at the sequencing facility end where the machine just produces "garbage" reads. 

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) is another excellent places to start checking your reads quality and overrepresented sequences, which once again should give a hit of why you reads don't map as well. We will talk about FastQC report later.

Having established what mapping rate is lets dig a little deeper into different types of "mapped reads", after all not all reads that mapped can be used for RNAseq analysis later on.

## STAR aligner

There is really three types of reads as far as aligner concerned:

- mapped uniquely i.e a single location in the genome
- mapped not uniquely i.e mapped to multiple places in the genome
- not mapped at all

Multi-mapping reads usually split into a couple of classes. The best way to describe a multi-mapper is to give it some score - probability how likely that a read belongs to a particular location in the genome and bwa aligner does exactly that.

```
MAPQ: MAPping Quality. It equals −10 log10 Pr{mapping position is wrong}, rounded to the nearest
integer. A value 255 indicates that the mapping quality is not available.
```

I can't give you details as to why, but most other aligners use slightly different scheme, they basically assign an integer value instead:

- 50|255 = Uniquely mapping
- 3 = Maps to 2 locations in the target
- 2 = Maps to 3 locations in the target
- 1 = Maps to 4-9 locations in the target
- 0 = Maps to 10 or more locations in the target

Depending on the aligner, but there will be some threshold at which it will stop trying to map a multi-mapping read further. For STAR that threshold is set to 10 location, you can tweak that parameter to be what ever you like. 

For STAR there are five categories of reads:

- uniquely mapped
- multi-mapped to less then 10 loci
- multi-mapped to more then 10 loci
- unmapped too short
- unmapped

Remember discussion about soft-clipping reads from previous section. If the read had been soft-clipped beyond the threshold then it'll be marked as too short and discarded. Going back to troubleshooting of unmapped reads if you are getting large proportion of reads that are too short, then despite what being said in the trimming section it is worth while trying to adapter and quality trim before mapping. Perhaps your library has high adapter content.

### Details

There is a slight variation in how different tools count and interpret mapped reads. In terms of terminology there are three important concepts one need to understand:

- library size / total number of reads
- primary and secondary alignments
- supplementary alignment

Library size in this context means total number of reads in the FASTQ files, this is typically in order of millions of reads, 20 million reads per sample seems to be used as a rule of thumb for RNAseq analysis, but that number can be anywhere between 5 and 80 millions per sample. Remember from previous section that we are trying to map all reads from FASTQ to the reference. Therefore you expect to find all 20 million in your bam file. Bam file holds one alignment per line and remember that reads can have multiple alignments, there fore one read could occupy multiple lines. If the read maps to multiple location one of those location will be marked as primary (a.k.a primary alignment) all other will be marked as secondary. It is outside of the scope of this book how primary alignment gets picked, sometimes this is rather random process. Supplementary alignment on the other hand marking a read that has chimeric alignment such mapping between two chromosomes or an inversion of some kind.
A uniquely mapped reads are the ones that actually going to make into differential analysis those are the read that have been marked as primary but also carry mapq of 255.

This command will give you the number of uniquely mapped reads that are good for differential expression

```
samtools view -c -F 256 -q 255 ctrl_rep1_sorted_mdups.bam
```

To actually get number of reads that mapped to the reference one need to keep track of number of unmapped reads as well and output them to bam, this is usually default behaviour. If you see 100% mapping rate I would suspect first thing that you didn't output unmapped reads into bam file


Also note that for paired end library total number of reads is double to what it is in the fastq file, because there is two fastq files R1 and R2. While STARs interpretation of reads isn't strictly correct it is actually the correct number of fragments that you need to consider for differential analysis.

## Number of assigned reads

The second most important metric that you should look at is number of reads assigned to a feature. `featureCounts` provides nice summary metrics about read assignment. Remember just because your reads have mapped to the reference genome it doesn't mean your reads came from protein coding reads. We would like to see as many reads assigned as possible and once again there isn't hard threshold that one can apply to see if read assignment was "good" or "bad". Think about biology and what it means in the context of your experimental design.

Below are some of typical metrics for `featureCounts` that one should look at. There isn't enough time in this book to cover every metrics output by `featureCounts`. These metrics will be covered in details:

- Assigned: reads mapped to a feature
- Unassigned Ambiguity: overlapping with two or more features
- Unassigned MultiMapping: reads that map to mode then one locations in the genome
- Unassigned NoFeatures: not overlapping with any features included in the annotation.
- Unassigned Unmapped: reads are reported as unmapped in SAM/BAM input. Note that if the ‘–primary’ option of featureCounts program is specified, the read marked as

These metrics are for future reference only and are not discussed any further in the book:

- primary alignment will be considered for assigning to features.
- Unassigned MappingQuality: mapping quality scores lower than the specified threshold.
- Unassigned Chimera: two reads from the same pair are mapped to different chromosomes or have incorrect orientation.
- Unassigned Duplicate: reads marked as duplicate in the FLAG field in SAM/BAM input.
- Unassigned Secondary: reads marked as second alignment in the FLAG field in SAM/BAM input.
- Unassigned Nonjunction: reads that do not span exons will not be assigned if the ‘--countSplitAlignmentsOnly’ option is specified.
- Unassigned Overlapping Length: no features/meta-features were found to have the minimum required overlap length.

The one reads that go into differential analysis are assigned reads. All other reads are simply discarded for the purpose of RNAseq analysis. No feature reads depending on the study would be one of the most interesting "can of worms". Together with other metrics no feature can suggest DNA contamination at it's simplest. More interestingly though if DNA contamination isn't true it is an interesting follow up of what those reads do and mean in your experiment, once again a good place to start is to [BLAST them](https://blast.ncbi.nlm.nih.gov/Blast.cgi). There isn't much you can do with ambiguous reads. One can try a different annotation, but really the only work around would be to get longer reads and hope that they will be less ambiguous. Similar to ambiguous reads long reads could help with multi-mapping reads. One other possible solution is to look where reads multi-map and perhaps if reads only multi-map to one other location and that location hasn't been annotated with a feature, reassign those reads to a known feature. This however is very speculative topic, which we won't go into in this book. For our purpose unfortunately we simply going to discard those reads.

Coming back to a threshold value and what to expect. Typically for mouse RNAseq I tend to see approximately around 60% of reads being assigned to features. That is 60 % out of your 80 % or so mapped reads, so about 50 % of your total library goes into RNAseq analysis. It is a lossy process.

```
¯\_(ツ)_/¯

```

## FastQC

Overrepresented sequences could mean a couple of different things

- your library is highly duplicated
- issues at the library preparation 
- issues at the instrument

## Intragenic vs Intergenic region

## Reads mapping bias

If the RNA wasn't carefully treated and became fragmented then you are more likely to see 3 prime bias 
for reads mapping

## Insert size distribution

## Where to look for more help

- Biostarts
- SeqAnswers
- googling in general
- at the end of the day best way to get information is look at the source code OR ask the author

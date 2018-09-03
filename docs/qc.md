# QC

## Number of mapped reads

Different mapping types:

- Uniquely mapped (255)
- Mapped to multiple location a.k.a multi-mapper
- Mapped to too many loci - discarded

## Number of assigned reads

- Unassigned Unmapped: reads are reported as unmapped in SAM/BAM input. Note that if the ‘–primary’ option of featureCounts program is specified, the read marked as
- primary alignment will be considered for assigning to features.
- Unassigned MappingQuality: mapping quality scores lower than the specified threshold.
- Unassigned Chimera: two reads from the same pair are mapped to different chromosomes or have incorrect orientation.
- Unassigned FragementLength: length of fragment does not satisfy the criteria.
- Unassigned Duplicate: reads marked as duplicate in the FLAG field in SAM/BAM input.
- Unassigned MultiMapping: reads marked as multi-mapping in SAM/BAM input (the ‘NH’ tag is checked by the program).
- Unassigned Secondary: reads marked as second alignment in the FLAG field in SAM/BAM input.
- Unassigned Nonjunction: reads that do not span exons will not be assigned if the ‘--countSplitAlignmentsOnly’ option is specified.
- Unassigned NoFeatures: not overlapping with any features included in the annotation.
- Unassigned Overlapping Length: no features/meta-features were found to have the minimum required overlap length.
- Unassigned Ambiguity: overlapping with two or more features (feature-level summarization) or meta-features (meta-feature-level) summarization.

## Intragenic vs Intergenic region

## Reads mapping bias

If the RNA wasn't carefully treated and became fragmented then you are more likely to see 3 prime bias 
for reads mapping

## Insert size distribution

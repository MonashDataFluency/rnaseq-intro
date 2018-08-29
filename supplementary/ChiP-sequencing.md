# Hsiao Voon, Epigenetics and Chromatin Lab

Power of chromatin. One genome can code for two different organism e.g catapillo and butterfly
- you can actively change chromatic 
- histone modification controls gene expression
- chromatin is used to remember which genes had been expressed

## Chromatin ImmunoPrecipitation (ChiP)

### ChiP protocol

- cross-link proteins to DNA
- fragment genome
- pull by protein

1. Cross-linking

 - no crosslinking (native ChiP)
 - formaldehyde crosslink (standard, short cross linker) (2 A (anstrong))
 - long range crosslinking

2. Fragmentation

 - sonication
 - Mictococcal nuclease 

You always get over representing ChiP seq because of the way chromatic is condense 
uncondese chromatic is always will be over represented compare to the tightly packed chromatin

Good input sequencing is essential

3. Antibody pulldown

- batch to batch variation
- non-specific antibodies

Should validate you antibody in knockout cell

4. Bioinformatics Analysis of ChiP-seq

 - align to the genome (e.g bowtie)
 - always eliminate PCR duplicates
 - "Uniquely mapped reads" very common, BUT also exclude mapping to the
   duplicated gene. (mammalian genome would have many duplicated genes)

KLF1 binds the  mouse aplha and beta globin loci at pproximal promoters and locus control

- Seqmonk - The swiss army knife of chip-seq

  - Genome viewer
  - flexible file import for datat and aannotations
  - fast
  - inbuild MAC 

ChiP-seq data reproducibility will depend on the cell type and organism type

ChipP-seq you target one particular protein genome wide, that is you want to know where abouts
you protein of interest binds in the genome. When you call peaks you get a list of coordinates/positions 
of where you protein binds.

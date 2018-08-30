# GFF 1, 2 and 3

> The essence of GFF file format is to avoid databases

## General Feature Format

> A 'Feature' could mean complete gene, RNA transcript or protein
> structure or pretty much anything

- Plain text file format
- The format was proposed as a means to transfer feature information
- We do not intend GFF format to be used for complete data management of the analysis and annotation of genomic sequence
- Originally wanted file format that will be easily parsable by Unix tools such `grep`, `sort` and `awk`

## General Feature Format Version 1 (GFF1)

- I have never seen one
- I think it is obsolete and was superseded by GFF2

**The main change from version 1 to 2 is the requirement for a tag-value
type structure**

## General Feature Format Version 2 (GFF2)

- 9 fields
- Tab separated

```
<SeqName>\t<Source>\t<Feature>\t<start>\t<end>\t<score>\t<strand>\t<frame>\t<[Attributes]>\t<[Comments]>
```

- The attribute field is some what free form:
    1. It must have Tag-Value Pairing, where each pair is separated by semicolon
    2. The Tag name can be anything within `[A-Za-z][A-Za-z0-9_]*`
    3. The value can be anything. Free text must be surrounded by double quotes
    4. All 'special' Unix character must be properly escaped e.g newline as `\n` and tab as `\t`

- [General Feature Format Version 2 (GFF2) specifications](http://www.sanger.ac.uk/resources/software/gff/spec.html)

**All other flavours of GFF's and GTF's are divergent of GFF2**

## General Feature Format Version 3 (GFF3)

- Reason for 'new', GFF3 format is that GFF2 has become insuffcient for bioinformatcians
- Key aspects about GFF3:

    1.  Adds a mechanism for representing more than one level of hierarchical grouping of features and subfeatures.
    2.  Separates the ideas of group membership and feature name/id.
    3.  Constrains the feature type field to be taken from a controlled vocabulary.
    4.  Allows a single feature, such as an exon, to belong to more than one group at a time.
    5.  Provides an explicit convention for pairwise alignments.
    6.  Provides an explicit convention for features that occupy disjunct regions.

- Tag-Value pairing is now must be separated by an `=` sign
- Tag-Value pairs are still separated by `;`
- Predefined meaning for some tags

    1. **ID** Indicates the ID of the feature. IDs for each feature must be unique within the scope of the GFF file. In the case of discontinuous features (i.e. a single feature that exists over multiple genomic locations) the same ID may appear on multiple lines. All lines that share an ID collectively represent a single feature.
    2. **Name** Display name for the feature. This is the name to be displayed to the user. Unlike IDs, there is no requirement that the Name be unique within the file.
    3. **Alias** A secondary name for the feature. It is suggested that this tag be used whenever a secondary identifier for the feature is needed, such as locus names and accession numbers. Unlike ID, there is no requirement that Alias be unique within the file.
    4. **Parent** Indicates the parent of the feature. A parent ID can be used to group exons into transcripts, transcripts into genes, an so forth. A feature may have multiple parents. Parent can *only* be used to indicate a partof relationship.
    5. **Target** Indicates the target of a nucleotide-to-nucleotide or protein-to-nucleotide alignment. The format of the value is "target_id start end strand", where strand is optional and may be "+" or "-". If the target_id contains spaces, they must be escaped as hex escape
    6. **Gap** The alignment of the feature to the target if the two are not collinear (e.g. contain gaps). The alignment format is taken from the CIGAR format described in the Exonerate documentation. See "THE GAP ATTRIBUTE" for a description of this format.
    7. **Derives\_from** Used to disambiguate the relationship between one feature and another when the relationship is a temporal one rather than a purely structural "part of" one. This is needed for polycistronic genes. See "PATHOLOGICAL CASES" for further discussion.
    8. **Note** A free text note.
    9. **Dbxref** A database cross reference. See the section "Ontology Associations and Db Cross References" for details on the format.
    10. **Ontology\_term** A cross reference to an ontology term. See the section "Ontology Associations and Db Cross References" for details.
    11. **Is\_circular** A flag to indicate whether a feature is circular. See extended discussion below.

-   Able to add sequence to the GFF3 file. Use `## FASTA` as a separator line between annotation and sequence

-   [Generic Feature Format Version 3 (GFF3) specifications](http://www.sequenceontology.org/gff3.shtml)

    1. **Tag-Value pair separated by `=`**
    2. **Tag-Value pairs separated by `;`**
    3. **You can now associate features together through `ID`/`Parent` tag**

## Gene Transfer Format (GTF)

- `GTF` is a refinement of `GFF2` and is sometimes referred to as `GFF2.5`

**Be careful about this assumption ! Some tools might produce/convert your other `GFF` file to `GFF2.5`, but this new `GFF2.5` file might not be compatible with your specific tool that expects `GTF` file**

- `GTF` file is somewhat a subclass of `GFF`
- Original GTF specification said that all features must have two mandatory attributes:

    1. `gene_id` *value*
    2. `transcript_id` *value*

- This is to handle different transcript from the same gene
- However [GENCODE](http://www.gencodegenes.org/gencodeformat.html) has more mandatory fields
- Tag-Value pair separated by space !
- Tag-Value paies separated by `;`
- [Gene Transfer Format (GTF) specification](http://mblab.wustl.edu/GTF2.html)

**To me at least `GTF` is the most established and predefined gene annotation format**

> [Three GFF versions
> comparison](http://www.broadinstitute.org/annotation/argo/help/gff.html)

## How to parse GFF/GTF file..?

1. Unix tools

    - `grep Grhl1 yourAnnotationFile.gff | less`
    - `grep -w gene yourAnnotationFile.gff | less`
    - `grep -w exon yourAnnotationFile.gff | less`
    - `cut -f1,3,4,5,7 yourAnnotationFile.gff | less`

2. Text Editor or spreadsheet tools

    - Vim
    - Gedit
    - sublime
    - LibreOffice
    - MS Office

3. Programmatically

    - Python
    - R
    - Perl

### Parse GFF/GTF with Python

- Tricky to associate features together e.g exon to transcript and transcript to gene
- Need to 'look ahead and look behind', but how far ..?
- Different gene will have different number of features (lines) associated with it
- GFF/GTF is rather big file around 1.0 - 1.5 Gb (the size will really depend on the species)
- Can make one big hash (dictionary) and keep it all in memory..
- Best I think to write your personalised hash (dictionary) to a file

### Python packages for dealing with GFF/GTF

1. [Nice bunch of functions from Gist](https://gist.github.com/slowkow/8101481)

    - Found this too slow and didn't want to keep it all in memory

2. [bcbio-gff a.k.a GFF parser](https://pypi.python.org/pypi/bcbio-gff/0.6.2)

    - Also found it to be slow and confusing

3. [gffutils](http://pythonhosted.org/gffutils/)

    - Really liked it using it and now use if all the time
    - Two step process:

        1.  Make database file `.db` from your GFF/GTF file
        2.  Parse anything you want from your `.db` file

```python
db = gffutils.FeatureDB(dbFile, keep_order=True)
features = db.all_features()
```

- `features` is now your generator object, meaning you can loop over it

```python
db = gffutils.FeatureDB(dbFile, keep_order=True)
features = db.all_features()

for feature in features:
    print feature
```

- And now you can get all this things for your single feature (GFF line)

    - `astuple`
    - `attributes`
    - `bin`
    - `calc_bin`
    - `chrom`
    - `dialect`
    - `end`
    - `extra`
    - `featuretype`
    - `file_order`
    - `frame`
    - `id`
    - `keep_order`
    - `score`
    - `seqid`
    - `sequence`
    - `sort_attribute_values`
    - `source`
    - `start`
    - `stop`
    - `strand`

> By trying very hard to move away from databases we ended having
> database as the best solution


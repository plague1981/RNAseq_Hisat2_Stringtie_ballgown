# RNAseq_Hisat2_Stringtie_ballgown
Hisat2,Stringtie and ballgown pipelines

# Before running the pipelines
1. check Hisat2 commands at http://daehwankimlab.github.io/hisat2/manual/
2. 
# Packages for linux OS
\> sudo apt-get install Hisat2 <br/>
\> sudo apt-get install Samtools
# Packages for R
1. Rhisat2
2. Rsamtools
3. dplyr
4. Xmisc
# Command lines for linux OS
1. build the index <br/>
\> hisat2-build ref.fa index <br/>
index is the basename of index files. This command line will generate 8 index files with suffix '.ht2'
# Command lines for windows with R scripts
You only can run 'Rhisat2' and 'ballgown' in windows OS system. 'Stringtie' and 'gffcompare' only can be installed in MacOS or Linux OS. </br>
\> Rscript Rhisat2_index_cl.R -ref \<genome.fa\> -i \<basename of index\> -od \<output directory\> <br/>
   This script will build up \<index\>.ht2 (8 index files) </br>
\> Rscript Rhisat2_align_cl.R -i \<index\> -t \<type\>

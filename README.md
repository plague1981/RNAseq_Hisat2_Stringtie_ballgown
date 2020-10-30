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

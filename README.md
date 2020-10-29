# RNAseq_Hisat2_Stringtie_ballgown
Hisat2,Stringtie and ballgown pipelines

# Before running the pipelines
1. check Hisat2 commands at http://daehwankimlab.github.io/hisat2/manual/
2. 
# Packages for linux OS
> sudo apt-get install Hisat2
> sudo apt-get install Samtools

# Command lines
1. build the index\n
> hisat2-build ref.fa index\n
index is the basename of index files. This command line will generate 8 index files with suffix name *.ht2\n

## Pairwise genome alignment
minimap2 -ax asm5 -t 32 --eqx GRCg6a_chrZ.fa GRCg7b_chrZ.fa | samtools sort -O BAM - > GRCg6a_GRCg7b_chrZ.bam
samtools index GRC_CAU_corrected_Fm.bam

minimap2 -ax asm5 -t 32 --eqx GRCg6a_chrZ.fa Huxu_chrZ.fa | samtools sort -O BAM - > GRCg6a_Huxu_chrZ.bam
samtools index GRCg6a_Huxu_chrZ.bam

minimap2 -ax asm5 -t 32 --eqx GRCg7b_chrZ.fa Huxu_chrZ.fa | samtools sort -O BAM - > GRCg7b_Huxu_chrZ.bam
samtools index GRCg7b_Huxu_chrZ.bam

## Identification of structural rearrangements
syri -c GRCg6a_GRCg7b_chrZ.bam -r GRCg6a_chrZ.fa -q GRCg7b_chrZ.fa -F B --prefix GRCg6a_GRCg7b_chrZ --nosnp &

syri -c GRCg6a_Huxu_chrZ.bam -r GRCg6a_chrZ.fa -q Huxu_chrZ.fa -F B --prefix GRCg6a_Huxu_chrZ --nosnp &

syri -c GRCg7b_Huxu_chrZ.bam -r GRCg7b_chrZ.fa -q Huxu_chrZ.fa -F B --prefix GRCg7b_Huxu_chrZ --nosnp &

## Visualization using PlotSR
plotsr --sr GRCg6a_GRCg7b_chrZsyri.out --genomes GRCg6a_GRCg7b_genome.txt -o GRCg6a_GRCg7b_ZARU.png -d 1200 -H 6 -W 15 -f 12
plotsr --sr GRCg6a_Huxu_chrZsyri.out --genomes GRCg6a_Huxu_genome.txt -o GRCg6a_Huxu_ZARU.png -d 1200 -H 6 -W 15 -f 12
plotsr --sr GRCg7b_Huxu_chrZsyri.out --genomes GRCg7b_Huxu_genome.txt -o GRCg7b_Huxu_7b_ZARU.png -d 1200 -H 6 -W 15 -f 12

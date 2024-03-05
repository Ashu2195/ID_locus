bedtools getfasta -fi Gallus_gallus.bGalGal1.mat.broiler.GRCg7b.dna_sm.toplevel.fa -bed GRCg7b_Z.bed -fo GRCg7b_Z.fa


# Create 1Kb and 1Kb base pair non-overlapping windows
bedtools makewindows -b GRCg7b_Z.bed -w 10000 -s 10000 > GRCg7b_Z_10kb_window.bed
bedtools makewindows -b GRCg7b_Z.bed -w 1000 -s 1000 > GRCg7b_Z_1kb_window.bed

##Calculate coverage of the 10kb windows
for i in `cat bamlist`
do 
echo $i
j=`echo $i | cut -f1 -d '.'`
samtools view -b $i Z > "$j"_Z.bam
bedtools coverage -counts -sorted -a GRCg7b_Z_10kb_window.bed -b "$j"_Z.bam > "$j".10kb.cov
done

##Perform a BLAST search in bed format
for q in `cat list_query`
do
makeblastdb -in  GRCg7b_Z.fa -out  GRCg7b_Z.fa -dbtype nucl
blastn -query $q -evalue 0.01 -db  GRCg7b_Z.fa -outfmt 6 -num_threads 24 -out  GRCg7b_Z.fa_"$q".blastn.outfmt6
done

cat  GRCg7b_Z.fa_Gallus_gallus_ADCY10.fa.blastn.outfmt6 |cut -f2,9,10 > ADCY10_blast_hit.bed
cat  GRCg7b_Z.fa_Gallus_gallus_ARHGAP33.fa.blastn.outfmt6 |cut -f2,9,10 > ARHGAP33_blast_hit.bed
cat  GRCg7b_Z.fa_Gallus_gallus_C2orf3.fa.blastn.outfmt6 |cut -f2,9,10 > C2orf3_blast_hit.bed
cat  GRCg7b_Z.fa_Gallus_gallus_MRPL19.fa.blastn.outfmt6 |cut -f2,9,10 > MRPL19_blast_hit.bed

##Process and sort BLAST hit coordinates in BED format

awk '{if($3>$2) print $1,$2,$3}' C2orf3_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > C2orf3_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' C2orf3_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > C2orf3_blast_hit_sorted2.bed
cat C2orf3_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > C2orf3_blast_hit_final.bed

awk '{if($3>$2) print $1,$2,$3}' ARHGAP33_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > ARHGAP33_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' ARHGAP33_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > ARHGAP33_blast_hit_sorted2.bed
cat ARHGAP33_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > ARHGAP33_blast_hit_final.bed

awk '{if($3>$2) print $1,$2,$3}' MRPL19_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > MRPL19_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' MRPL19_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > MRPL19_blast_hit_sorted2.bed
cat MRPL19_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > MRPL19_blast_hit_final.bed

awk '{if($3>$2) print $1,$2,$3}' ADCY10_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > ADCY10_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' ADCY10_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > ADCY10_blast_hit_sorted2.bed
cat ADCY10_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > ADCY10_blast_hit_final.bed

#calculate covrage of 1Kb windows
bedtools coverage -a  GRCg7b_Z_1kb_window.bed -b ADCY10_blast_hit_final.bed > ADCY10_blast_hit.cov
bedtools coverage -a  GRCg7b_Z_1kb_window.bed -b C2orf3_blast_hit_final.bed > C2orf3_blast_hit.cov
bedtools coverage -a  GRCg7b_Z_1kb_window.bed -b ARHGAP33_blast_hit_final.bed > ARHGAP33_blast_hit.cov
bedtools coverage -a  GRCg7b_Z_1kb_window.bed -b MRPL19_blast_hit_final.bed > MRPL19_blast_hit.cov


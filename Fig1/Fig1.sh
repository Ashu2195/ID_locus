# Create 1Kb and 1Kb base pair non-overlapping windows
bedtools makewindows -b Z.bed -w 10000 -s 10000 > Z_10kb_window.bed
bedtools makewindows -b Z.bed -w 1000 -s 1000 > Z_1kb_window.bed

##Calculate coverage of the 10kb windows
for i in `cat bamlist`
do 
echo $i
j=`echo $i | cut -f1 -d '.'`
bedtools coverage -counts -sorted -a Z_10kb_window.bed -b $i > "$j".10kb.cov
done

##Perform a BLAST search in bed format
for q in `cat list_query`
do
makeblastdb -in Z.fa -out Z.fa -dbtype nucl
blastn -query $q -evalue 0.01 -db Z.fa -outfmt 6 -num_threads 24 -out Z.fa_"$q".fa.blastn.outfmt6
done

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
bedtools coverage -a Z_1kb_window.bed -b ADCY10_blast_hit.bed > ADCY10_blast_hit.cov
bedtools coverage -a Z_1kb_window.bed -b C2orf3_blast_hit_final.bed > C2orf3_blast_hit.cov
bedtools coverage -a Z_1kb_window.bed -b ARHGAP33_blast_hit_final.bed > ARHGAP33_blast_hit.cov
bedtools coverage -a Z_1kb_window.bed -b MRPL19_blast_hit_final.bed > MRPL19_blast_hit.cov

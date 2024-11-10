# Create 1Kb and 1Kb base pair non-overlapping windows
bedtools makewindows -b GRCg6a_Z.bed -w 1000 -s 1000 > GRCg6a_Z_1kb_window.bed


##Perform a BLAST search in bed format
for q in `cat list_query`
do
i="GRCg6a_Z.fa"
makeblastdb -in $i -out $i -dbtype nucl
blastn -task blastn -evalue 0.01 -db $i -out blastn_"$i"_"$q".hits.outfmt6 -num_threads 42 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore sstrand qcovs qcovhsp" -query $q
done

##
cat blastn_GRCg6a_Z.fa_Gallus_gallus_ADCY10_mRNA_multifasta.fa.hits.outfmt6 |cut -f2,9,10 > GRCg6a_ADCY10_blast_hit.bed
cat blastn_GRCg6a_Z.fa_Gallus_gallus_ARHGAP33_mRNA_multifasta.fa.hits.outfmt6 |cut -f2,9,10 > GRCg6a_ARHGAP33_blast_hit.bed
cat blastn_GRCg6a_Z.fa_Gallus_gallus_C2ORF3_mRNA_multifasta.fa.hits.outfmt6 |cut -f2,9,10 > GRCg6a_C2orf3_blast_hit.bed
cat blastn_GRCg6a_Z.fa_Gallus_gallus_MRPL19_mRNA_multifasta.fa.hits.outfmt6 |cut -f2,9,10 > GRCg6a_MRPL19_blast_hit.bed

##Process and sort BLAST hit coordinates in BED format

awk '{if($3>$2) print $1,$2,$3}' GRCg6a_C2orf3_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_C2orf3_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' GRCg6a_C2orf3_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_C2orf3_blast_hit_sorted2.bed
cat GRCg6a_C2orf3_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_C2orf3_blast_hit_final.bed

awk '{if($3>$2) print $1,$2,$3}' GRCg6a_ARHGAP33_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_ARHGAP33_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' GRCg6a_ARHGAP33_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_ARHGAP33_blast_hit_sorted2.bed
cat GRCg6a_ARHGAP33_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_ARHGAP33_blast_hit_final.bed

awk '{if($3>$2) print $1,$2,$3}' GRCg6a_MRPL19_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_MRPL19_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' GRCg6a_MRPL19_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_MRPL19_blast_hit_sorted2.bed
cat GRCg6a_MRPL19_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_MRPL19_blast_hit_final.bed

awk '{if($3>$2) print $1,$2,$3}' GRCg6a_ADCY10_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_ADCY10_blast_hit_sorted1.bed
awk '{if($3<$2) print $1,$3,$2}' GRCg6a_ADCY10_blast_hit.bed |sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_ADCY10_blast_hit_sorted2.bed
cat GRCg6a_ADCY10_blast_hit_sorted*|sort -k1,1 -k2,2n|sed 's/ /\t/g' > GRCg6a_ADCY10_blast_hit_final.bed

#calculate covrage of 1Kb windows
bedtools coverage -a GRCg6a_Z_1kb_window.bed -b GRCg6a_ADCY10_blast_hit_final.bed > GRCg6a_ADCY10_blast_hit.cov
bedtools coverage -a GRCg6a_Z_1kb_window.bed -b GRCg6a_C2orf3_blast_hit_final.bed > GRCg6a_C2orf3_blast_hit.cov
bedtools coverage -a GRCg6a_Z_1kb_window.bed -b GRCg6a_ARHGAP33_blast_hit_final.bed > GRCg6a_ARHGAP33_blast_hit.cov
bedtools coverage -a GRCg6a_Z_1kb_window.bed -b GRCg6a_MRPL19_blast_hit_final.bed > GRCg6a_MRPL19_blast_hit.cov


####################################################################################################################################
read.table(file="GRCg6a_ADCY10_blast_hit.cov",header=FALSE)->S
read.table(file="GRCg6a_C2orf3_blast_hit.cov",header=FALSE)->S1
read.table(file="GRCg6a_ARHGAP33_blast_hit.cov",header=FALSE)->S2
read.table(file="GRCg6a_MRPL19_blast_hit.cov",header=FALSE)->S3
tiff(file="Fig_2_GRCg6a.tif",res=220, width=2800,height=1600)
par(mgp=c(3,1,0),mar=c(5,5,1,1))
plot(S$V2[(S$V2>72000000) & S$V2<82529921],(S$V7[S$V2>72000000 & S$V2<82529921]),type="l",ylab=c(expression(bold("Coverage of Blast hits/1Kb window"))),col="red",bty="n",ylim=c(0,1.2),xlab=c(expression(bold("Position along Chromosome Z"))))
lines(S1$V2[(S1$V2>72000000) & S1$V2<82529921],(S1$V7[S1$V2>72000000 & S1$V2<82529921]),type="l",col="orange")
lines(S2$V2[(S2$V2>72000000) & S2$V2<82529921],(S2$V7[S2$V2>72000000 & S2$V2<82529921]),type="l",col="blue")
lines(S3$V2[(S3$V2>72000000) & S3$V2<82529921],(S3$V7[S3$V2>72000000 & S3$V2<82529921]),type="l",col="green")
legend("topright", legend=c(expression(italic("ADCY10")), expression(italic("C2orf3")), expression(italic("ARHGAP33")), expression(italic("MRPL19"))),
       col=c("red", "orange", "blue", "green"), cex=1.5, lwd=2.5, horiz=TRUE, bty="n")
dev.off()

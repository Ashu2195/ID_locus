##subset bamfiles for chromosome Z
for i in `cat bam.list`; do j=`echo $i |sed 's/\//_/g'`; echo $j; samtools view -b $i Z > "$j".chrZ.bam; done

for i in *chrZ.bam
do
j=`echo $i |cut -f1 -d '.'`
bam-readcount -f Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -w 0 $i -l MTAP_SNP.bed > "$j".count.txt
done

for j in `cat count_list`;do cut -f 1-4,6-9 $j|sed 's/:/\t/g'|cut -f 1-4,5,6,19,20,33,34,47,48 > $j.count;done


for i in *count
do
j=`echo $i |cut -f1 -d '.'`
sed -i "s/^/$j\t/g" $i
done

for i in `cat MTAP_SNP_Position`
do
cat *count|awk -v val=$i '$3==val{print $0}' >> $i.position
done


for i in `ls -1 *.position`;do sed -i 's/\./\t/' $i;done


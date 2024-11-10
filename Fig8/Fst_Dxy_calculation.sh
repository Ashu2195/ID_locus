pop="$1"
angsd -GL 2 -ref Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -anc Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -dosaf 1 -baq 1 -C 50 -setMinDepthInd 6 -minInd 10 -minMapQ 30 -minQ 20 -b "$pop" -nThreads 16 -out "$pop" -doCounts 1 -r Z
#Estimate SFS
realSFS "$pop".saf.idx -P 8 -fold 1 > "$pop".sfs
realSFS saf2theta "$pop".saf.idx -outname "$pop" -sfs "$pop".sfs -fold 1
#Estimate theta
thetaStat do_stat "$pop".thetas.idx
#Estimate theta for 1Kb non overlapping windows
thetaStat do_stat "$pop".thetas.idx -win 1000 -step 1000 -outnames "$pop".thetasWindow_1kb.gz

#Fst comparison
for i in `cat list_KADK`
do
j=`echo $i |cut -f1 -d '.'`
echo $i $j
realSFS KADK.saf.idx $i -P 16 > KADK_"$j".ml
realSFS fst index -P 16 KADK.saf.idx $i -sfs KADK_"$j".ml -fstout KADK_"$j"

for m in KADK_"$j".fst.idx
do
realSFS fst stats2 $m -win 1000 -step 1000 >$m.1kb
done
done

for i in `cat list_SILK`
do
j=`echo $i |cut -f1 -d '.'`
echo $i $j
realSFS SILK.saf.idx $i -P 16 > SILK_"$j".ml
realSFS fst index -P 16 SILK.saf.idx $i -sfs SILK_"$j".ml -fstout SILK_"$j"

for m in SILK_"$j".fst.idx
do
realSFS fst stats2 $m -win 1000 -step 1000 >$m.1kb
done
done

# First loop: Extract specific columns from files and save the results to .txt files.
for i in *1kb; do
    sed 's/(/\t(/3' "$i" | awk '{print $1,$2"_"$3,$4,$5,$6}' | sed 's/ /\t/g' | cut -f2 > "$i.txt"
done

# Second loop: Extract specific columns from files and save the results to .column files.
for i in *1kb; do
    sed 's/(/\t(/3' "$i" | awk '{print $1,$2"_"$3,$4,$5,$6}' | sed 's/ /\t/g' > "$i.column"
done

# for extracting selected columns
for i in *column; do sed 's/_/\t/g' $i |sed 's/(//3' |sed 's/)//3' |sed 's/,/\t/3' |awk '{print $2"\t"$3"\t"$4"\t"$7}'|awk '{print $3"\t"$1"\t"$2"\t"$4}' |grep -v "chr" |sort -V |awk '{print $2"\t"$3"\t"$1"\t"$4"\t"$1}' |sed '1s/^/BP\tSNP\tCHR\tP\tchr\n/g'| grep -v -w "W"|grep -v "AA" > $i.txt; done


# Third loop: Perform further column manipulation and add numbers in the 5th column chromosome-wise.
for i in $(cut -f3 *.column.txt | sort | uniq -c | grep -v "CHR" | awk '{print $1+1"_"$3}' | sed '1,32d'); do
    j=$(echo "$i" | sed 's/_.*//g')
    k=$(echo "$i" | sed 's/.._//g')
    for m in *.txt; do
        sed -i "s/$k/$j/2" "$m"
    done
done

for i in $(cat Fst_Dxy_comparison_list); do
  t=$(grep "Z" "$i" | wc -l)
  l=$(expr $t \* 90 / 100)
  m=$(expr $t - $l)
  echo $m
  grep -w "Z" $i |sort -k4n |tail -n$m |head -n1
done

#top 10% outlier threshold of Fst comparison
KADK_SILK	0.835979
KADK_WHLH	0.829057
SILK_WHLH	0.845818
#Black pop specific window
cat KADK_SILK.fst.idx.1kb.column.txt KADK_WHLH.fst.idx.1kb.column.txt SILK_WHLH.fst.idx.1kb.column.txt |cut -f1,2 |sed 's/\t/_/g'|sort|uniq -c |awk '$1>2 {print$2}'> common_windows1kb

for i in `cat common_windows1kb`; do j=`echo $i |sed 's/_/\t/g'`; grep "$j" SILK_WHLH.fst.idx.1kb.column.txt >>SILK_WHLH_ID_comm_windows_1kb ; done
for i in `cat common_windows1kb`; do j=`echo $i |sed 's/_/\t/g'`; grep "$j" KADK_WHLH.fst.idx.1kb.column.txt >>KADK_WHLH_ID_comm_windows_1kb ; done
for i in `cat common_windows1kb`; do j=`echo $i |sed 's/_/\t/g'`; grep "$j" KADK_SILK.fst.idx.1kb.column.txt >>KADK_SILK_ID_comm_windows_1kb ; done

cat KADK_WHLH_ID_comm_windows_1kb |awk '$4>0.8{print$0}'> KADK_WHLH_more_than_0.8
cat SILK_WHLH_ID_comm_windows_1kb |awk '$4>0.8{print$0}'> SILK_WHLH_more_than_0.8
cat KADK_SILK_ID_comm_windows_1kb |awk '$4<0.5{print$0}' >KADK_SILK_less_than_0.5

cat KADK_SILK_less_than_0.5 KADK_WHLH_more_than_0.8 SILK_WHLH_more_than_0.8 |sed 's/\t/_/1'|cut -f1 |sort |uniq -c |awk '$1>2{print $2}' > Black_pop_specific_window

#Dxy calculation
vcftools --vcf commons_snps_30_ind_bcftools.vcf.recode.vcf --remove-indels --max-alleles 2 --max-missing 0.95 --recode --recode-INFO-all --out Z_30.filtered.vcf


python parseVCF.py -i Z_30.filtered.vcf.recode.vcf --skipIndels| bgzip > Z_30.filtered.vcf.geno.gz

for i in `cat combination`
do
p1=`echo $i |cut -f 1 -d '_'`
p2=`echo $i |cut -f 2 -d '_'`
python popgenWindows.py -g Z_30.filtered.vcf.geno.gz -o Z_"$p1"_"$p2".1kb_Fst.Dxy.pi.csv.gz -f phased -w 1000 -s 1000 -p $p1 -p $p2 --popsFile pop_list
done


for i in Z_SILK_KADK.1kb_Fst.Dxy.pi.csv Z_SILK_WHLH.1kb_Fst.Dxy.pi.csv Z_KADK_WHLH.1kb_Fst.Dxy.pi.csv
do
sed 's/,/\t/g' $i > "$i".txt
done
#top 10% outlier threshold of Dxy comparison
KADK_SILK	0.62
KADK_WHLH	0.56
SILK_WHLH	0.62


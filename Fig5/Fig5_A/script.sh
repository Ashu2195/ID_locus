##variant calling for Z
for i in Z
do 
bcftools mpileup --threads 8 -f Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -b bam.list -C 50 -Q 20 -q 20 -r $i |bcftools call --threads 8 -mv -o "$i".bcftools.vcf
done

for i in Z
do
freebayes -f Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -C 7 -L bam.list -m 10 -m 10 --min-coverage 15 -r $i > "$i".freebaye.vcf
done

##variant calling for ID locus
bcftools mpileup --threads 16 -f Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -b 270_ind_bam_list -C 50 -Q 20 -q 20 -r Z:78725000-80340000 |bcftools call --threads 8 -mv -o 78_80.bcftools.vcf

freebayes -f Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -C 7 -L 270_ind_bam_list -m 10 -m 10 --min-coverage 10 -r Z:78725000-80340000 > 78_80.freebaye.vcf


##filtering
for i in `cat flist`
do
echo $i
vcftools --vcf $i --remove-indels --max-alleles 2 --max-missing 0.95 --recode --recode-INFO-all --out $i.filtered.vcf
done

#extract common snps
cat Z.bcftools.vcf |grep -v "^#" |awk '{print $1"_"$2}' >bcftools_SNPs_only.list
cat bcftools_SNPs_only.list |sort |uniq -c |awk '{print $2}' >bcftools_uniq.list


cat Z.freebayes.vcf |grep -v "^#" |awk '{print $1"_"$2}' >freebayes_SNPs_only.list
cat freebayes_SNPs_only.list |sort |uniq -c |awk '{print $2}' >freebayes_uniq.list



##genrate common SNPs bed
cat bcftools_uniq.list freebayes_uniq.list |sort |uniq -c |sed 's/      //g' |sed 's/ /\t/g' |awk '$1==2{print $0}'|cut -f2 |sed 's/_/\t/g' |awk '{print $1"\t"$2"\t"$2}' >common.snp.bed

sort -V common.snp.bed > common.snp.sorted.bed
## get common SNPs using vcftools
vcftools --vcf Z.bcftools.vcf --bed common.snp.sorted.bed --out Z.common_snps_bcftools.vcf --recode --keep-INFO-all



#vcftophylip format conversion
python /media/ashutosh/sde2/FM_ID_project/vcf/vcf2phylip.py -i R1.vcf

#phylogeny construction
/media/ashutosh/sde2/FM_ID_project/vcf/iqtree-2.3.4-Linux-intel/bin/./iqtree2 -s R1.min4.phy -T 24 -m MFP --alrt 1000 -B 1000 --boot-trees


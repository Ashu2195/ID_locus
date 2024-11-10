##Variant calling
bcftools mpileup --threads 4 -f Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -b 270_ind_bam_list -C 50 -Q 20 -q 20 | bcftools call -mv --threads 2 -f GQ -o genome_wide.vcf

##Filtering
vcftools --vcf genome_wide.vcf --remove-indels --max-alleles 2 --max-missing 0.95 --recode --recode-INFO-all --out 270_genome_wide_filtered

##Phylogeny_construction 
/media/ashutosh/sde2/158_ind_VCF/SNPhylo/./snphylo.sh -v 270_genome_wide_filtered.recode.vcf -P 270_genome_wide_vcf_snphylout -B 1000 -t 32


bgzip -c  ID_locus.recode.vcf >  ID_locus.recode.vcf.gz
tabix -p vcf  ID_locus.recode.vcf.vcf.gz

#phylogeny 
vk phylo tree nj  ID_locus.recode.vcf.vcf.gz >ID_locus_vkphylo_NJ.nwk
vk phylo tree upgma  ID_locus.recode.vcf.vcf.gz >ID_locus_vkphylo_UPGMA.nwk

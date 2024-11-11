##SNP density calculation
vcftools --vcf 270_Z_common.vcf.recode.vcf --SNPdensity 10000 --out Z_270_ind_common_filtered_vcf.10kb

## Identification of callable sites in ZARU
java -Xmx64g -jar GenomeAnalysisTK.jar -T CallableLoci -R Gallus_gallus.GRCg6a.dna_sm.toplevel.fa -I /home/workstation/backup_disk3/J3.JETB.mk.sorted.bam -o Kadak_J3_callable_loci.bed -L GRCg6a_chrZ.bed --minDepth 10 --minMappingQuality 20 --minBaseQuality 10 --minDepthForLowMAPQ 20 --maxFractionOfReadsWithLowMAPQ 20 --summary J3.summary

##plotting
read.table("Z_270_ind_common_filtered_vcf.10kb.snpden")-> snp_d
read.table("ZARU1_callable_regions_snpdensity.10kb.snpden")-> Z1_C
read.table("ZARU2_callable_regions_snpdensity.10kb.snpden")-> Z2_C
read.table("ZARU1_all_region_snpdensity")-> Z1_A
read.table("ZARU2_all_region_snpdensity")-> Z2_A
tiff("SNP_density_comparision.tiff",width = 4280, height = 3080, res = 300)
par(mfrow=c(3,1))
par(mar=c(5,5,5,1))
plot(snp_d$V2,snp_d$V3,type="l",col="darkcyan",main="SNP Density",xlab="Position along Chr Z",ylab="SNP Count in 10Kb window",ylim=c(0,1700),cex.main=2, cex.axis=1,cex.lab=1.5,lwd=2)
rect(73613151,1200,78725000,1300,col="magenta")
rect(78724999,1200,80340000,1300,col="blue")
rect(80340001,1200,81039999,1300,col="brown")
rect(81040000,1200,82226500,1300,col="yellowgreen")
legend("topright",legend=c("ZARU1", "R1", "ZARU2","R2"), col=c("magenta","blue", "brown", "yellowgreen"),cex=2, lwd=3, horiz=TRUE, bty="n")

plot(Z1_C$V2,Z1_C$V3,type="l",col="darkviolet",main="SNP Density in ZARU1",xlab="Position along Chr Z",ylab="SNP Count in 10Kb window",ylim=c(0,1350),cex.main=2, cex.axis=1,cex.lab=1.5,lwd=2)
lines(Z1_A$V2,Z1_A$V3,type="l",col="darkcyan",lwd=2)
legend("topright",legend=c("Callable sites", "All sites"), col=c("darkviolet","darkcyan"),cex=2, lwd=3, horiz=TRUE, bty="n")

plot(Z2_C$V2,Z2_C$V3,type="l",col="darkviolet",main="SNP Density in ZARU2",xlab="Position along Chr Z",ylab="SNP Count in 10Kb window",ylim=c(0,1350),cex.main=2, cex.axis=1,cex.lab=1.5,lwd=2)
lines(Z2_A$V2,Z2_A$V3,type="l",col="darkcyan",lwd=2)
legend("topright",legend=c("Callable sites", "All sites"), col=c("darkviolet","darkcyan"),cex=2, lwd=3, horiz=TRUE, bty="n")
dev.off()


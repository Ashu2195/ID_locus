angsd -GL 2 -out genolike_ID_78_80 -nThreads 32 -minMapQ 30 -minQ 20 -doGlf 2 -doMajorMinor 1 -SNP_pval 1e-6 -doMaf 1 -bam 270_ind_bam_list -r Z:78725000-80340000

ls -1 *beagle.gz > list_beagle
for i in `cat list_beagle`; do python pcangsd.py -beagle $i -out $i.cov -threads 64; done

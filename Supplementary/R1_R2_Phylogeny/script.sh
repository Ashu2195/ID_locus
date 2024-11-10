
python /media/ashutosh/sde2/FM_ID_project/vcf/vcf2phylip.py -i R1.vcf
python /media/ashutosh/sde2/FM_ID_project/vcf/vcf2phylip.py -i R2.vcf


/media/ashutosh/sde2/FM_ID_project/vcf/iqtree-2.3.4-Linux-intel/bin/./iqtree2 -s R1.min4.phy -T 24 -m MFP --alrt 1000 -B 1000 --boot-trees
/media/ashutosh/sde2/FM_ID_project/vcf/iqtree-2.3.4-Linux-intel/bin/./iqtree2 -s R2.min4.phy -T 24 -m MFP --alrt 1000 -B 1000 --boot-trees

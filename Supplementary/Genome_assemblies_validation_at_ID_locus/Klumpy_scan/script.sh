##GRCg6a
klumpy scan_alignments --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg6a.bam --threads 4 --annotation Gallus_gallus.GRCg6a.96.gtf

klumpy alignment_plot --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg6a.bam --reference Z --leftbound 72000000 --rightbound 82529921 --candidates SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg6a_Candidate_Regions.tsv --min_len 5000 --min_percent 75 --color green --vertical_line_gaps --height 4000 --width 9000 --annotation Gallus_gallus.GRCg6a.96.gtf --no_subsample --gap_file GRCg6a_Z_gaps.tsv

##GRCg7b
klumpy scan_alignments --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg7b.bam --threads 4 --annotation Gallus_gallus.bGalGal1.mat.broiler.GRCg7b.110.gtf

klumpy alignment_plot --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg7b.bam --reference Z --leftbound 72335361 --rightbound 86044486 --candidates SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg7b_Candidate_Regions.tsv --color red --vertical_line_gaps --annotation Gallus_gallus.bGalGal1.mat.broiler.GRCg7b.110.gtf --height 3000 --width 9000 --gap_file GRCg7b_Z_gaps.tsv --min_len 5000 --min_percent 75 --no_subsample

##Huxu
klumpy scan_alignments --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_Huxu.bam --threads 4

klumpy alignment_plot --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_Huxu.bam --reference CP100594.1 --leftbound 73325684 --rightbound 87735852 --candidates SRR15421342_43_44_45_46_SRR13494713_14_chrZ_Huxu_Candidate_Regions.tsv --min_len 55000 --min_percent 75 --color red --vertical_line_gaps --vertical_line_klumps --height 2000 --width 5000 --no_subsample


## no subsample
klumpy alignment_plot --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg6a.bam --reference Z --leftbound 72000000 --rightbound 82529921 --candidates SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg6a_Candidate_Regions.tsv --min_len 5000 --min_percent 75 --vertical_line_gaps --height 4000 --width 9000 --annotation Gallus_gallus.GRCg6a.96.gtf --no_subsample --gap_file GRCg6a_Z_gaps.tsv --format png

klumpy alignment_plot --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg7b.bam --reference Z --leftbound 72335361 --rightbound 86044486 --candidates SRR15421342_43_44_45_46_SRR13494713_14_chrZ_GRCg7b_Candidate_Regions.tsv --vertical_line_gaps --annotation Gallus_gallus.bGalGal1.mat.broiler.GRCg7b.110.gtf --height 4000 --width 9000 --gap_file GRCg7b_Z_gaps.tsv --min_len 5000 --min_percent 75 --no_subsample --format png

klumpy alignment_plot --alignment_map SRR15421342_43_44_45_46_SRR13494713_14_chrZ_Huxu.bam --reference CP100594.1 --leftbound 73325684 --rightbound 87735852 --candidates SRR15421342_43_44_45_46_SRR13494713_14_chrZ_Huxu_Candidate_Regions.tsv --min_len 5000 --min_percent 75 --color red --vertical_line_gaps --height 4000 --width 9000 --no_subsample --format png

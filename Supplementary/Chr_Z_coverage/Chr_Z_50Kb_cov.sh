##Coverage calculation
bedtools makewindows -b Z.bed -w 50000 -s 50000 > Z_50kb_window.bed
for i in `cat bamlist`
do 
echo $i
j=`echo $i | cut -f1 -d '.'`
bedtools coverage -counts -sorted -a Z_50kb_window.bed -b $i > "$j".50kb.cov
done

##Renaming
mv G1.50kb.cov Kadaknath1.50kb.cov
mv G2.50kb.cov Kadaknath2.50kb.cov
mv G3.50kb.cov Kadaknath3.50kb.cov
mv GP.50kb.cov Kadaknath4.50kb.cov
mv J1.50kb.cov Kadaknath5.50kb.cov
mv J2.50kb.cov Kadaknath6.50kb.cov
mv J3.50kb.cov Kadaknath7.50kb.cov
mv P1.50kb.cov Kadaknath8.50kb.cov
mv P2.50kb.cov Kadaknath9.50kb.cov
mv P3.50kb.cov Kadaknath10.50kb.cov 
mv SILK.50kb.cov Silkie1.50kb.cov
mv SRR10161527.50kb.cov Silkie2.50kb.cov
mv SRR17968698.50kb.cov Silkie3.50kb.cov
mv SRR17968699.50kb.cov Silkie4.50kb.cov
mv SRR17968700.50kb.cov Silkie5.50kb.cov
mv SRR17968701.50kb.cov Silkie6.50kb.cov
mv SRR17968702.50kb.cov Silkie7.50kb.cov
mv SRR17968703.50kb.cov Silkie8.50kb.cov
mv SRR17968709.50kb.cov Silkie9.50kb.cov
mv SRR17968710.50kb.cov Silkie10.50kb.cov
mv SRR1951796.50kb.cov White_Leghorn1.50kb.cov
mv SRR1951798.50kb.cov White_Leghorn2.50kb.cov
mv SRR1951821.50kb.cov White_Leghorn3.50kb.cov
mv SRR10527197.50kb.cov White_Leghorn4.50kb.cov
mv SRR13518483.50kb.cov White_Leghorn5.50kb.cov
mv SRR13518484.50kb.cov White_Leghorn6.50kb.cov
mv SRR13518485.50kb.cov White_Leghorn7.50kb.cov
mv SRR13518486.50kb.cov White_Leghorn8.50kb.cov
mv SRR13518487.50kb.cov White_Leghorn9.50kb.cov
mv SRR13518488.50kb.cov White_Leghorn10.50kb.cov

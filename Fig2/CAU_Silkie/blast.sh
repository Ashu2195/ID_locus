for q in `cat list_query`
do
i="Z_CAU_Silkie.fa"
makeblastdb -in $i -out $i -dbtype nucl
blastn -task blastn -evalue 0.01 -db $i -out blastn_"$i"_"$q".hits.out -num_threads 42 -outfmt 1 -query $q
blastn -task blastn -evalue 0.01 -db $i -out blastn_"$i"_"$q".hits.outfmt6 -num_threads 42 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore sstrand qcovs qcovhsp" -query $q
done

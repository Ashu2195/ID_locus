##R
#rm all.trees
for tree in `ls -1 Z*.min4.phy.treefile`
do
echo $tree
echo $tree >> trees.list
cat $tree >> all.trees
done

cat trees.list |cut -f 11 -d '/'|cut -f 1 -d '.'|sed 's/\_/\t/g' > trees.list.bed

java -Xmx64g -jar treeCmp.jar -P -d ms rf pd qt um -i all.trees -o out.tree.metrics -r entire_R1_tree/R1.min4.phy.treefile

##R

read.table(file="out.tree.metrics",header=TRUE)->M
read.table(file="trees.list.bed",header=FALSE)->T
M$Start<-T$V2
M$End<-T$V3
tiff("Phylogeny_comparison.tiff",width = 5080, height = 3580, res = 300)
par(mfrow=c(5,1))
par(mar=c(5,5,5,1))
plot(M$Start,M$MatchingSplit,pch=16,col="darkcyan",main="Phylogenetic Distance compared to R1 in 10Kb windows",xlab="Position along Chr Z",ylab="MatchingSplit metrics",cex.main=1.5, cex.axis=1,cex.lab=1.2,ylim=c(2000,16000))
rect(78724999,15100,80340000,15800,col="magenta")
legend("topleft",legend=c("R1"), col=c("magenta"),cex=2, lwd=5, horiz=TRUE, bty="n")

plot(M$Start,M$RF.0.5.,pch=16,col="darkcyan",main="Phylogenetic Distance compared to R1 in 10Kb windows",xlab="Position along Chr Z",ylab="RF metrics",cex.main=1.5, cex.axis=1,cex.lab=1.2,ylim=c(230,270))
rect(78724999,265,80340000,267,col="magenta")
legend("topleft",legend=c("R1"), col=c("magenta"),cex=2, lwd=5, horiz=TRUE, bty="n")

plot(M$Start,M$PathDiffernce,pch=16,col="darkcyan",main="Phylogenetic Distance compared to R1 in 10Kb windows",xlab="Position along Chr Z",ylab="PathDiffernce metrics",cex.main=1.5, cex.axis=1,cex.lab=1.2,ylim=c(2000,15000))
rect(78724999,14300,80340000,14900,col="magenta")
legend("topleft",legend=c("R1"), col=c("magenta"),cex=2, lwd=5, horiz=TRUE, bty="n")

plot(M$Start,M$Quartet,pch=16,col="darkcyan",main="Phylogenetic Distance compared to R1 in 10Kb windows",xlab="Position along Chr Z",ylab="Quartet metrics",cex.main=1.5, cex.axis=1,cex.lab=1.2,ylim=c(70000000,150000000))
rect(78724999,141000000,80340000,145000000,col="magenta")
legend("topleft",legend=c("R1"), col=c("magenta"),cex=2, lwd=5, horiz=TRUE, bty="n")

plot(M$Start,M$UMAST,pch=16,col="darkcyan",main="Phylogenetic Distance compared to R1 in 10Kb windows",xlab="Position along Chr Z",ylab="UMAST metrics",cex.main=1.5, cex.axis=1,cex.lab=1.2,ylim=c(200,270))
rect(78724999,250,80340000,254,col="magenta")
legend("topleft",legend=c("R1"), col=c("magenta"),cex=2, lwd=5, horiz=TRUE, bty="n")
dev.off()


 

pdf(file="Chromosome_Z_50Kb_coverage.pdf",width=20,height=8)
dir(pattern = ".50kb.cov", full.names = FALSE)->Files
par(mgp=c(3,1,0),mar=c(7,10,6,2))
for(i in Files){
read.table(file=i,header=FALSE)->S
plot(S$V2,log(S$V4),pch=16,col="indianred4",ylab=c(expression(bold("log (coverage)"))),xlab=c(expression(bold("Position along chromosome Z"))),cex.main=2, cex.lab=2, cex.axis=1.5,cex =2, main =gsub(pattern = "\\.50kb.cov$", "", i))
}
dev.off()



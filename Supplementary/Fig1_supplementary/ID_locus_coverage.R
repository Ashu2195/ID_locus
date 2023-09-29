pdf(file="ID_locus_coverage.pdf",width=20,height=8)
dir(pattern = ".10kb.cov", full.names = FALSE)->Files
par(mgp=c(3,1,0),mar=c(7,10,6,2))
for(i in Files){
read.table(file=i,header=FALSE)->S
plot(S$V2[(S$V2>72000000) & S$V2<82529921],log(S$V4[S$V2>72000000 & S$V2<82529921]),pch=16,col="indianred4",ylab=c(expression(bold("log (coverage)"))),xlab=c(expression(bold("Position along chromosome Z"))),cex.main=2, cex.lab=2, cex.axis=1.5,cex =2, main =gsub(pattern = "\\.10kb.cov$", "", i))
}
dev.off()

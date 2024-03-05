tiff(file="Id_Locus_GRCg7b.tif",res=200, width=3000,height=1800)
par(mfrow=c(2,1))
read.table(file="SRR1951821.10kb.cov",header=FALSE)->A
read.table(file="ADCY10_blast_hit.cov",header=FALSE)->S
read.table(file="C2orf3_blast_hit.cov",header=FALSE)->S1
read.table(file="ARHGAP33_blast_hit.cov",header=FALSE)->S2
read.table(file="MRPL19_blast_hit.cov",header=FALSE)->S3
par(mgp=c(3,1,0),mar=c(0,7,5,2))
plot(S$V2[(S$V2>72000000) & S$V2<86044486],(S$V5[S$V2>72000000 & S$V2<86044486]),type="l",ylab=c(expression(bold("Length of blast hits in bp"))),col="red",bty="n",xaxt='n')
lines(S1$V2[(S1$V2>72000000) & S1$V2<86044486],(S1$V5[S1$V2>72000000 & S1$V2<86044486]),type="l",col="orange")
lines(S2$V2[(S2$V2>72000000) & S2$V2<86044486],(S2$V5[S2$V2>72000000 & S2$V2<86044486]),type="l",col="blue")
lines(S3$V2[(S3$V2>72000000) & S3$V2<86044486],(S3$V5[S3$V2>72000000 & S3$V2<86044486]),type="l",col="green")
legend("topright", legend=c(expression(italic("ADCY10")), expression(italic("C2orf3")), expression(italic("ARHGAP33")), expression(italic("MRPL19"))),
       col=c("red", "orange", "blue", "green"), cex=1, lwd=2, bty="n")

par(mgp=c(3,1,0),mar=c(7,7,1,2))
plot(A$V2[(A$V2>72000000) & A$V2<86044486],log(A$V4[A$V2>72000000 & A$V2<86044486]),pch=16,bty="n",ylab=c(expression(bold("log (coverage)"))), xlab=c(expression(bold("Position along Chromosome Z"))),col= "indianred4",ylim=c(4,10))
dev.off()


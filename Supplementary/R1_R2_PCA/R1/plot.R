tiff("R1_1_2.tiff", width = 7500, height = 5000, res = 350)
C <- read.table(file="genolike_ID_78_80.beagle.gz.cov.cov")
m<-as.matrix(C)
e <- eigen(m, symm=TRUE)
e$val <- e$val/sum(e$val)
cat(signif(e$val, digits=3)*100,"\n")
signif(e$val, digits=3)*100->evec
s<-strsplit(basename(scan("name.list",what="the")),"\\.")
pop<-sapply(s,function(x){paste(x[1],sep="")})
ifelse(pop %in% "BBC","black",ifelse(pop %in% "NBC","blue",ifelse(pop %in% "COM","orange",ifelse(pop %in% "RJF","red",ifelse(pop %in% "GJF","green",ifelse(pop %in% "CJF","magenta",ifelse(pop %in% "GSF","grey","purple")))))))->popcol

ifelse(pop %in% "BBC","16",ifelse(pop %in% "NBC","16",ifelse(pop %in% "COM","16",ifelse(pop %in% "RJF","16",ifelse(pop %in% "GJF","16",ifelse(pop %in% "CJF","16",ifelse(pop %in% "GSF","16","1")))))))->poppch

pop1<-as.data.frame(pop)
pop1$col<-popcol
pop1$pch<-poppch
unique(pop1,)->a
par(mar=c(5,5,1,13),mgp=c(2.7, 0.5, 0),xpd = T)
plot(e$vectors[,1],e$vectors[,2],lwd=2,ylab=c(paste("PC2","(",evec[2],"%",")")),xlab=c(paste("PC1","(",evec[1],"%",")")),font=2,col=popcol,pch=as.numeric(pop1$pch),cex=2.5,cex.lab=1.7,cex.axis=1.3,font.lab=2)
box(lwd=3)
legend("bottomleft",legend=c("Black Bone Chicken", "Non Black Native Chicken","Commercial Chicken","Red Junglefowl", "Green Junglefowl","Ceylon Junglefowl","Grey Junglefowl" ),col=c("black","blue","orange","red","green","magenta","grey"),pch=c(16, 16, 16,16, 16, 16,16),cex=2,pt.cex=2)
dev.off()


tiff("R1_1_3.tiff", width = 7500, height = 5000, res = 350)
C <- read.table(file="genolike_ID_78_80.beagle.gz.cov.cov")
m<-as.matrix(C)
e <- eigen(m, symm=TRUE)
e$val <- e$val/sum(e$val)
cat(signif(e$val, digits=3)*100,"\n")
signif(e$val, digits=3)*100->evec
s<-strsplit(basename(scan("name.list",what="the")),"\\.")
pop<-sapply(s,function(x){paste(x[1],sep="")})
ifelse(pop %in% "BBC","black",ifelse(pop %in% "NBC","blue",ifelse(pop %in% "COM","orange",ifelse(pop %in% "RJF","red",ifelse(pop %in% "GJF","green",ifelse(pop %in% "CJF","magenta",ifelse(pop %in% "GSF","grey","purple")))))))->popcol

ifelse(pop %in% "BBC","16",ifelse(pop %in% "NBC","16",ifelse(pop %in% "COM","16",ifelse(pop %in% "RJF","16",ifelse(pop %in% "GJF","16",ifelse(pop %in% "CJF","16",ifelse(pop %in% "GSF","16","1")))))))->poppch

pop1<-as.data.frame(pop)
pop1$col<-popcol
pop1$pch<-poppch
unique(pop1,)->a
par(mar=c(5,5,1,13),mgp=c(2.7, 0.5, 0),xpd = T)
plot(e$vectors[,1],e$vectors[,3],lwd=2,ylab=c(paste("PC3","(",evec[3],"%",")")),xlab=c(paste("PC1","(",evec[1],"%",")")),font=2,col=popcol,pch=as.numeric(pop1$pch),cex=2.7,cex.lab=1.7,cex.axis=1.3,font.lab=2)
box(lwd=3)
legend("bottomleft",legend=c("Black Bone Chicken", "Non Black Native Chicken","Commercial Chicken","Red Junglefowl", "Green Junglefowl","Ceylon Junglefowl","Grey Junglefowl" ),col=c("black","blue","orange","red","green","magenta","grey"),pch=c(16, 16, 16,16, 16, 16,16),cex=2,pt.cex=2)
dev.off()


tiff("R1_2_3.tiff", width = 7500, height = 5000, res = 350)
C <- read.table(file="genolike_ID_78_80.beagle.gz.cov.cov")
m<-as.matrix(C)
e <- eigen(m, symm=TRUE)
e$val <- e$val/sum(e$val)
cat(signif(e$val, digits=3)*100,"\n")
signif(e$val, digits=3)*100->evec
s<-strsplit(basename(scan("name.list",what="the")),"\\.")
pop<-sapply(s,function(x){paste(x[1],sep="")})
ifelse(pop %in% "BBC","black",ifelse(pop %in% "NBC","blue",ifelse(pop %in% "COM","orange",ifelse(pop %in% "RJF","red",ifelse(pop %in% "GJF","green",ifelse(pop %in% "CJF","magenta",ifelse(pop %in% "GSF","grey","purple")))))))->popcol

ifelse(pop %in% "BBC","16",ifelse(pop %in% "NBC","16",ifelse(pop %in% "COM","16",ifelse(pop %in% "RJF","16",ifelse(pop %in% "GJF","16",ifelse(pop %in% "CJF","16",ifelse(pop %in% "GSF","16","1")))))))->poppch

pop1<-as.data.frame(pop)
pop1$col<-popcol
pop1$pch<-poppch
unique(pop1,)->a
par(mar=c(5,5,1,13),mgp=c(2.7, 0.5, 0),xpd = T)
plot(e$vectors[,2],e$vectors[,3],lwd=2,ylab=c(paste("PC3","(",evec[3],"%",")")),xlab=c(paste("PC2","(",evec[2],"%",")")),font=2,col=popcol,pch=as.numeric(pop1$pch),cex=2.7,cex.lab=1.7,cex.axis=1.3,font.lab=2)
box(lwd=3)
legend("bottomleft",legend=c("Black Bone Chicken", "Non Black Native Chicken","Commercial Chicken","Red Junglefowl", "Green Junglefowl","Ceylon Junglefowl","Grey Junglefowl" ),col=c("black","blue","orange","red","green","magenta","grey"),pch=c(16, 16, 16,16, 16, 16,16),cex=2,pt.cex=2)
dev.off()

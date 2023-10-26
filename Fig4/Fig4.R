library(ggplot2)
library(ggthemes)
library(extrafont)
library(plyr)
library(scales)
library(ggpubr)
BBC.data <- read.table("CCDC112_BBC.txt", header=T)
NBBC.data <- read.table("CCDC112_NBBC.txt", header=T)

tiff("Fig4.tif", width = 25, height = 12, units = 'in', res = 200)
BBC_stack <- ggplot() + geom_bar(aes(y = Percentage, x = Pos, fill = Base), data = BBC.data, stat="identity")+ labs(x="Positions", y="% of Bases") +ggtitle("Black Bone Chickens")      + theme(
plot.title = element_text(color="black", size=25, face="bold",hjust=0.5),
axis.title.x = element_text(color="blue", size=20, face="bold"),
axis.title.y = element_text(color="red", size=20, face="bold"),
axis.text.y = element_text(face="bold", color="black",size=15),
legend.title = element_blank(),
legend.text = element_blank(),
axis.text.x = element_blank(),
legend.position="none",
plot.margin = margin(1, 1, 1, 1, "cm")
)  

NBBC_stack <- ggplot() + geom_bar(aes(y = Percentage, x = Pos, fill = Base), data = NBBC.data, stat = "identity") + labs(x="Positions", y="% of Bases") +ggtitle("Non-Black Bone Chickens")+ theme(
plot.title = element_text(color="black", size=25, face="bold",hjust=0.5),
axis.title.x = element_text(color="blue", size=20, face="bold"),
axis.title.y = element_text(color="red", size=20, face="bold"),
axis.text.y = element_text(face="bold", color="black",size=15),
legend.title = element_text(colour="black", size=25, face="bold"),
legend.text = element_text(colour="black", size=18, face="bold"),
axis.text.x = element_blank(),

plot.margin = margin(1, 1, 1, 0, "cm")
)
           
figure <- ggarrange(BBC_stack, NBBC_stack, ncol = 2, nrow = 1)
figure

dev.off()




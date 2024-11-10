library(ggplot2)
library(ggthemes)
library(extrafont)
library(plyr)
library(scales)
library(ggpubr)
BBC.data <- read.table("BBC.txt", header=T)
NBBC.data <- read.table("NBBC.txt", header=T)

tiff("Fig6_E.tif", width = 45, height = 15, units = 'in', res = 300)
BBC_stack <- ggplot() + geom_bar(aes(y = Percentage, x = Pos, fill = Base), data = BBC.data, stat="identity")+ labs(x="Positions", y="% of Bases") +ggtitle("Black-Bone Chickens")      + theme(
plot.title = element_text(color="black", size=25, face="bold",hjust=0.5),
axis.title.x = element_text(color="blue", size=20, face="bold"),
axis.title.y = element_text(color="red", size=20, face="bold"),
axis.text.y = element_text(face="bold", color="black",size=15),
legend.title = element_text(colour="black", size=20, face="bold"),
legend.text = element_text(colour="black", size=15, face="bold"),
axis.text.x = element_blank(),
plot.margin = margin(1, 2, 1, 1, "cm")
)  

NBBC_stack <- ggplot() + geom_bar(aes(y = Percentage, x = Pos, fill = Base), data = NBBC.data, stat = "identity") + labs(x="Positions", y="% of Bases") +ggtitle("non Black-Bone Chickens")+ theme(
plot.title = element_text(color="black", size=25, face="bold",hjust=0.5),
axis.title.x = element_text(color="blue", size=20, face="bold"),
axis.title.y = element_text(color="red", size=20, face="bold"),
axis.text.y = element_text(face="bold", color="black",size=15),
legend.title = element_text(colour="black", size=20, face="bold"),
legend.text = element_text(colour="black", size=15, face="bold"),
axis.text.x = element_blank(),
plot.margin = margin(1, 2, 1, 1, "cm")
)
           
figure <- ggarrange(BBC_stack, NBBC_stack, ncol = 2, nrow = 1)
figure

dev.off()


#######################################################################################################

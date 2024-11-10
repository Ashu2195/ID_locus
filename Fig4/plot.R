# Function to plot data with gene-specific colors and option to reverse
plot_data <- function(data, title, colors, reverse = FALSE) {
  copy_numbers <- table(data$Gene)
  gene_info <- data.frame(Gene = names(copy_numbers), 
                          CopyNumber = as.integer(copy_numbers), 
                          y_position = 1:length(copy_numbers))
  
  # Plot setup
  if (reverse) {
    plot(NA, xlim = c(max(data$END), min(data$START)), ylim = c(0, max(gene_info$y_position) + 1), 
         xlab = "Positions along Chr Z", ylab = "Repeat Units", yaxt = "n", cex.axis=1.2,cex.lab=1.8)
  } else {
    plot(NA, xlim = c(min(data$START), max(data$END)), ylim = c(0, max(gene_info$y_position) + 1), 
         xlab = "Positions along Chr Z", ylab = "Repeat Units",yaxt = "n", cex.axis=1.2,cex.lab=1.8)
  }
  
  axis(2, at = gene_info$y_position, labels = gene_info$Gene)
  
  # Plot rectangles
  if (reverse) {
    for (i in nrow(data):1) {
      y_pos <- gene_info$y_position[gene_info$Gene == data$Gene[i]]
      rect(data$START[i], y_pos - 0.4, data$END[i], y_pos + 0.4, 
           col = colors[data$Gene[i]], border = "black")
    }
  } else {
    for (i in 1:nrow(data)) {
      y_pos <- gene_info$y_position[gene_info$Gene == data$Gene[i]]
      rect(data$START[i], y_pos - 0.4, data$END[i], y_pos + 0.4, 
           col = colors[data$Gene[i]], border = "black")
    }
  }
  
  # Add a legend with italicized names except for "Tandem_Repeat"
  legend_labels <- sapply(names(colors), function(gene) {
    if (gene == "Tandem_Repeat") {
      return(gene)
    } else {
      return(bquote(italic(.(gene))))
    }
  })
  
  legend("topright", legend = legend_labels, fill = colors, cex = 1.5, horiz = TRUE, bty = "n")
}

# Load datasets
data_CAUJ1 <- read.table("CAU_J1.txt", header = TRUE)
data_CAUJ2 <- read.table("CAU_J2.txt", header = TRUE)
data_HuxuJ1_P1 <- read.table("Huxu_J1_part1.txt", header = TRUE)
data_HuxuJ1_P2 <- read.table("Huxu_J1_part2.txt", header = TRUE)
data_HuxuJ2_P1 <- read.table("Huxu_J2_Part1.txt", header = TRUE)
data_HuxuJ2_P2 <- read.table("Huxu_J2_Part2.txt", header = TRUE)

# Set up the color scheme for the 5 genes
colors <- c("ADCY10" = "red", "MRPL19" = "green", "C2orf3" = "orange", 
            "ARHGAP33" = "blue", "Tandem_Repeat" = "darkcyan")

# Plot all six datasets with separate figures
# Set up tiff files and adjust the width for CAU and Huxu datasets
tiff("CAU_J1_plot.tiff", width = 7000, height = 3000, res = 250)
par(mar=c(5,5,1,1))
plot_data(data_CAUJ1, "CAU_J1", colors)
dev.off()

tiff("CAU_J2_plot.tiff", width = 7000, height = 3000, res = 250)
par(mar=c(5,5,1,1))
plot_data(data_CAUJ2, "CAU_J2", colors)
dev.off()


tiff("Huxu_J1_part1_plot.tiff", width = 4000, height = 2500, res = 250)
par(mar=c(5,5,1,1))
plot_data(data_HuxuJ1_P1, "Huxu_J1_Part1", colors)
dev.off()


tiff("Huxu_J1_part2_plot.tiff", width = 4000, height = 2500, res = 250)
par(mar=c(5,5,1,1))
plot_data(data_HuxuJ1_P2[order(data_HuxuJ1_P2$START, decreasing = TRUE), ], "Huxu_J1_Part2 (Reversed)", colors, reverse = TRUE)
dev.off()

tiff("Huxu_J2_part1_plot.tiff", width = 4000, height = 2500, res = 250)
par(mar=c(5,5,1,1))
plot_data(data_HuxuJ2_P1, "Huxu_J2_Part1", colors)
dev.off()


tiff("Huxu_J2_part2_plot.tiff", width = 4000, height = 2500, res = 250)
par(mar=c(5,5,1,1))
plot_data(data_HuxuJ2_P2[order(data_HuxuJ2_P2$START, decreasing = TRUE), ], "Huxu_J2_Part2 (Reversed)", colors, reverse = TRUE)
dev.off()

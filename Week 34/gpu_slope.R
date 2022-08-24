# Figure adapted from Nathan Yau (https://flowingdata.com/2013/06/03/how-to-make-slopegraphs-in-r/)
library(tidyverse)
library(ggplot2)
library(svglite)

# Read Data
gpu_data <- read.csv("./data/figure_data.csv")

# Define Plot
# png(file=paste("./updates/plot_update", Sys.time(), "png"), width=floor(640*.95), height=floor(1136*.95))
svglite("./test.svg", width=6.66, height=11.83)
x_scale_factor <- 6
y_scale_factor <- 200
plot(x=0,
     y=0,
     type="n",
     main="",
     xlab="",
     ylab="",
     xlim=c(min(gpu_data$Year)-x_scale_factor,
            max(gpu_data$Year)+x_scale_factor),
     ylim=c(min(gpu_data$value)-y_scale_factor,
            max(gpu_data$value)+1.5*y_scale_factor),
     las=1,
     bty="n",
     axes=FALSE)

for (v in unique(gpu_data$Vendor)) {
  v_min <- gpu_data %>%
    filter(Vendor==v) %>%
    filter(Year==min(gpu_data$Year)) %>%
    select(value)

  v_max <- gpu_data %>%
    filter(Vendor==v) %>%
    filter(Year==max(gpu_data$Year)) %>%
    select(value)

  lines(c(min(gpu_data$Year),
          max(gpu_data$Year)),
        c(v_min[1],
          v_max[1]))

  # 2010 Label
  text(min(gpu_data$Year), v_min[1], v_min[1], pos=2, cex=0.8)
  text(2010, v_min[1], v, pos=2, cex=0.8, offset=2.2)

  # 2020 Label
  text(max(gpu_data$Year), v_max[1], v_max[1], pos=4, cex=0.8)
  text(2020, v_max[1], v, pos=4, cex=0.8, offset=2.2)
}

# Title
text(2004, 2450, "Evolution of\nGPU Performance\nby Vendor, 2010--2020", cex=1.3, pos=4, family="Helvetica")

# Year labels
text(2010, 90, "2010", cex=0.9, pos=2)
text(2020, 2300, "2020", cex=0.9, pos=4, offset=0.5)

dev.off()

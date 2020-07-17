library(ggseg)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggsegDesterieux)
library(cowplot)

amygdala <- data.frame(
    region = c("amygdala", "amygdala"),
    p = c(0.001, 0.001),
    stringsAsFactors = F
)

amygdala_plot <- ggseg(
    .data = amygdala,
    atlas = aseg,
    colour = "white",
    view = "axial",
    size = 0.1,
    mapping = aes(fill = p)
) + theme(
    axis.text = element_text(size = 20),
    legend.justification = c(1, 0),
    legend.position = "none",
    legend.text = element_text(size = 4),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)


occi_temp <- data.frame(
    region = c("G and S occipital inf", "S temporal sup"),
    p = c(0.001, 0.005),
    stringsAsFactors = F
)

fusifor <- data.frame(
    region = c("G oc-temp lat-fusifor"),
    p = 0.005,
    stringsAsFactors = F
)

temporal_sup_left <- data.frame(
    region = c("S temporal sup"),
    p = 0.001,
    stringsAsFactors = F
)

frontal <- data.frame(
    region = rep("rostral middle frontal", 2),
    p = c(0.001, 0.001),
    stringsAsFactors = F
)

superior_frontal <- data.frame(
    region = rep("superior frontal", 4),
    p = rep(0.001, 4),
    stringsAsFactors = F
)

occi_temp_plot <- ggseg(
    .data = occi_temp,
    atlas = desterieux,
    colour = "black",
    size = 0.1,
    hemisphere = "right",
    view = "lateral",
    position = "stacked",
    mapping = aes(fill = p, color = p)
) + theme(
    axis.text = element_text(size = 25),
    legend.justification = c(1, 0),
    legend.position = "none",
    legend.text = element_text(size = 4),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)

fusifor_plot <- ggseg(
    .data = fusifor,
    atlas = desterieux,
    colour = "black",
    size = 0.1,
    position = "stacked",
    view = "medial",
    hemisphere = "left",
    mapping = aes(fill = p, color = p)
) + theme(
    axis.text = element_text(size = 25),
    legend.justification = c(1, 0),
    legend.position = "none",
    legend.text = element_text(size = 4),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)

temporal_sup_left_plot <- ggseg(
    .data = temporal_sup_left,
    atlas = desterieux,
    colour = "black",
    size = 0.1,
    position = "stacked",
    view = "lateral",
    hemisphere = "left",
    mapping = aes(fill = p, color = p)
) + theme(
    axis.text = element_text(size = 25),
    legend.justification = c(1, 0),
    legend.position = "none",
    legend.text = element_text(size = 4),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)

frontal_left_plot <- ggseg(
    .data = frontal,
    atlas = dk,
    colour = "black",
    size = 0.1,
    # position = "stacked",
    view = "lateral",
    hemisphere = "left",
    mapping = aes(fill = p, color = p)
) + theme(
    axis.text = element_text(size = 25),
    legend.justification = c(1, 0),
    legend.position = "none",
    legend.text = element_text(size = 4),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)

frontal_middle_plot <- ggseg(
    .data = superior_frontal,
    atlas = dk,
    colour = "black",
    size = 0.1,
    # position = "stacked",
    view = "medial",
    hemisphere = "right",
    mapping = aes(fill = p, color = p)
) + theme(
    axis.text = element_text(size = 25),
    legend.justification = c(1, 0),
    legend.position = "none",
    legend.text = element_text(size = 4),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)

plot_grid(occi_temp_plot, fusifor_plot, temporal_sup_left_plot, amygdala_plot,
          labels = c("G & S occi inf / S temp sup", "G fusifor", "S temp sup", "Amigdala"),
          nrow = 2,
          hjust = -.05
)

plot_grid(
    frontal_left_plot, frontal_middle_plot,
    labels = c("PFC lateral izquierda", "PFC medial derecha"),
    nrow = 2,
    hjust = -0.05,
    label_size = 20
)

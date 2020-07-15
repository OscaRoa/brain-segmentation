library(ggseg)
library(ggseg3d)
library(ggsegExtra)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggsegDesterieux)
library(cowplot)

ggseg()

# Atlas DK
View(dk)
ggseg(atlas = dk)

# Atlas aseg
View(aseg)
ggseg(atlas = aseg)

ggseg(atlas = dk, position = "stacked")
ggseg(atlas = dk, position = "stacked") + theme_classic() + labs(title = "Mi primera práctica")
ggseg(atlas = dk, position = "stacked", hemisphere = "left", view = "lateral")

p1 <- ggseg(position = "stacked") +
    theme_dark() +
    labs(title="Atlas DKT oscuro")

p2 <- ggseg(position = "stacked") +
    theme_classic() +
    labs(title = "Atlas DKT clásico")

med <- ggseg(view = "medial") +
    labs(title = "Atlas DKT vista medial")

left <- ggseg(hemisphere = "left") +
    labs(title = "Atlas DKT Hemisferio Izquierdo")

combo <- ggseg(view = "medial",
               hemisphere = "left") +
    labs(title="Left medial")

p3 <- ggseg(atlas = aseg) +
    labs(title = "SUBCORTICAL")

cowplot::plot_grid(p1, med, combo, p2, left, p3, 
                   labels = c("A: dkt - dark", "B: dkt - medial",
                              "C: dkt - combo", "D: dkt - classic",
                              "E: dkt - left", "F: aseg"),
                   hjust = -.05)

ggseg(mapping = aes(fill = region), colour = "white", size=.1, position = "stacked") + 
    scale_fill_brain("dk") +
    theme(legend.justification = c(1,0),
          legend.position = "bottom",
          legend.text = element_text(size = 5)) +
    guides(fill = guide_legend(ncol = 7))

# Simulación de datos para mostrar en el atlas dk
someData <-  data.frame(
    region = rep(c("transverse temporal", "insula",
                   "precentral","superior parietal"),2),
    p = sample(seq(0,.5,.001), 8),
    AgeG = c(rep("Young",4), rep("Old",4)),
    stringsAsFactors = FALSE) %>%
    group_by(AgeG)

cx_primarias <- data.frame(
    region = rep(c("paracentral", "postcentral", "precentral", "cuneus",
                   "pericalcarine", "transverse temporal"),2),
    p = rep(0.01, 12)
)

ggseg(
    .data = cx_primarias,
    colour = "white",
    size = 0.1,
    position = "stacked",
    mapping = aes(fill = p)
)

# Regiones subcorticales
ggseg(atlas = aseg, mapping = aes(fill = region)) +
    theme(
        legend.justification = c(1, 0),
        legend.position = "bottom",
        legend.text = element_text(size = 10)
    ) +
    guides(fill = guide_legend(ncol = 3))

# Simulación de datos para mostrar en el atlas aseg
cerebellum <- data.frame(
    region = c("cerebellum white matter", "cerebellum cortex"),
    p = sample(seq(0.001, 0.05, 0.0001), 2),
    stringsAsFactors = F
)

ggseg(
    atlas = aseg,
    .data = cerebellum,
    colour = "white",
    hemisphere = "midline",
    size = 0.1,
    mapping = aes(fill = p)
)

# Multiplot con regiones de interés
cortical_areas <- data.frame(
    region = c(rep("fusiform", 4), rep("lateral occipital", 2)),
    p = sample(seq(0.001, 0.05, 0.0001), 6),
    stringsAsFactors = F
)

amygdala <- data.frame(
    region = c("amygdala", "amygdala"),
    p = sample(seq(0.001, 0.05, 0.0001), 2),
    stringsAsFactors = F
)

cortical_seg <- ggseg(
    .data = cortical_areas,
    colour = "white",
    size = 0.1,
    position = "stacked",
        mapping = aes(fill = p)
)

subcortical_seg <- ggseg(
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
    legend.text = element_text(size = 4)
)

# Regiones de interés para la práctica
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

# gyrus3 <- data.frame(
#     region = c("S temporal sup"),
#     p = 0.001,
#     stringsAsFactors = F
# )

occi_temp_plot <- ggseg(
    .data = gyrus,
    atlas = desterieux,
    colour = "black",
    size = 0.1,
    position = "stacked",
    view = "lateral",
    mapping = aes(fill = p, color = p)
) + theme(
    axis.text = element_text(size = 25),
    legend.justification = c(1, 0),
    legend.position = "none",
    legend.text = element_text(size = 4)
)

occi_temp_plot

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
    legend.text = element_text(size = 4)
)

fusifor_plot

# gyrus_plot_left <- ggseg(
#     .data = gyrus3,
#     atlas = desterieux,
#     colour = "black",
#     size = 0.1,
#     position = "stacked",
#     view = "lateral",
#     hemisphere = "left",
#     mapping = aes(fill = p, color = p)
# ) + theme(
#     axis.text = element_text(size = 25),
#     legend.justification = c(1, 0),
#     legend.position = "none",
#     legend.text = element_text(size = 4)
# )

gyrus_plot_med

plot_grid(occi_temp_plot, NULL, fusifor_plot, NULL, subcortical_seg, NULL,
                   # labels = c("A", "B", "C"),
                   nrow = 2,
                   hjust = -.05,
                   # scale = c(1.2, 1, 1.2, 1, 1, 1),
                   rel_heights = c(1.5, 1),
                   rel_widths = c(1, 0.8, 1)
                   # rel_widths = c(0.8, 1, 0.8)
)
##############################################################

# Simulacion de datos 3D
data_3D = dk_3d %>% 
    filter(surf == "inflated" & hemi == "right") %>% 
    unnest(cols = c(ggseg_3d)) %>% 
    select(region) %>%
    na.omit() %>% 
    mutate(p = sample(seq(0,.5, length.out = 100), nrow(.)) %>% 
    round(2)) 

ggseg3d(.data = data_3D, atlas = dk_3d, colour = "p", text = "p")

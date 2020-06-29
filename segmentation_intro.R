library(ggseg)
library(ggseg3d)
library(ggsegExtra)
library(plotly)
library(dplyr)
library(tidyr)
library(ggplot2)

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

# Simulador de datos para mostrar en un atlas
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

ggseg(.data = cx_primarias, colour = "white", size = 0.1, position = "stacked", mapping = aes(fill = p))

# TODO hacer lo mismo pero con el atlas de aseg

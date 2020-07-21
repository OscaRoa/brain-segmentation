library(ggseg)
library(ggplot2)
library(ggsegGlasser)
library(cowplot)

subcor <- data.frame(
    region = c(
        rep("amygdala", 2),
        rep("thalamus proper", 2),
        "brain stem"
    ),
    roi = c(
        rep("Amígdala", 2),
        rep("Tálamo", 2),
        "Tallo Cerebral"
    ),
    stringsAsFactors = F
)

subcor_plot <- ggseg(
    .data = subcor,
    atlas = aseg,
    colour = "white",
    size = 0.1,
    mapping = aes(fill = roi, color = roi)
) + theme(
    axis.text = element_text(size = 20),
    legend.justification = c(1, 0),
    legend.text = element_text(size = 15),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)

# V2 V4, VVC Ventral visual
# TE1a, TE1m, TE1p, and PHT Middle temporal gyrus
# FFC Fusiform
# 9-46d, 46, a9-46v, and p9-46v Prefrontal dorsolateral
# 9m a y p prefrontal medial
# AVI, AAIC Insula
cortical <- data.frame(
    region = rep(c(
        "STSva", "STSvp", "STSda", "STSdp", # STS
        "VVC", "VMV2", "VMV3", # Visual ventral
        "TE1a", "TE1m", "TE1p", "PHT", # Giro Temporal medio
        "9-46d", "46", "a9-46v", "p9-46v", # Prefrontal dorsolateral
        "9m", # PFC medial
        "AVI", "AAIC", # Insula
        "FFC"
        ), 2),
    roi = rep(
        c(
            rep("STS", 4),
            rep("Ventral visual", 3),
            rep("Giro temporal medio", 4),
            rep("PFC lateral", 4),
            rep("PFC medial", 1),
            rep("Insula", 2),
            rep("Giro fusiforme", 1)
    ), 2),
    stringsAsFactors = F
)

cortical_plot <- ggseg(
    .data = cortical,
    atlas = glasser,
    colour = "black",
    size = 0.1,
    position = "stacked",
    mapping = aes(fill = roi, color = roi)
) + theme(
    axis.text = element_text(size = 25),
    legend.justification = c(1, 0),
    # legend.position = "none",
    legend.text = element_text(size = 15),
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
)

plot_grid(subcor_plot, labels = "Regiones subcorticales")
plot_grid(cortical_plot, labels = "Regiones corticales")

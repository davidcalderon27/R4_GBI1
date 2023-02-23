# Library
library(dplyr); library(ggsankey); library(ggplot2); library(ggpubr)
library(readxl); library(plotly)

if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")
devtools::install_github("davidsjoberg/ggsankey")









## SANKEY:  DATOS PERMISOS DE CONSTRUCCIÓN 2021
setwd("D:/GDrive2/My Drive/IKIAM/CLASES/2022II/ETB4")
data = read_excel("construcciones2021.xlsx")
dc1 = data %>% select(codreg, careaur, mes, propie, cimi, piso, estru, 
                      pared, cubi, CTIPOBR, CORES)
colnames(dc1) = c("Region", "Zona", "Mes", "Propiedad", "Cimientos", "Piso",
                  "Estructura", "Pared", "Cubierta", "Obra", "Residencia")

dc2 <- dc1 %>% make_long(Mes, Zona, Region, Propiedad, Obra, Residencia, 
                         Cimientos, Piso, Estructura, Pared, Cubierta)

# Conteo para todos los niveles de las cinco variables
dagg <- dc2%>% dplyr::group_by(node)%>% tally()
# Unir datos de df con dagg
dc3 <- merge(dc2, dagg, by.x = 'node', by.y = 'node', all.x = TRUE)
# Chart 2
pl <- ggplot(dc3, aes(x = x, next_x = next_x, node = node, 
                      next_node = next_node, fill = factor(node), 
                      label = paste0(node," n=", n))) + 
  geom_sankey(flow.alpha = 0.8,  show.legend = TRUE) + 
  geom_sankey_label(size = 3, color = "white", fill= "gray30", hjust = -0.2) +
  scale_fill_viridis_d(option = "D") +
  labs(title = "Permisos de construcción - 2021",
       caption = "@GualapuroMoises") +
  theme_bw() + theme(legend.position = "none")+
  theme(axis.title = element_blank(), axis.text.y = element_blank(), 
        axis.ticks = element_blank(), panel.grid = element_blank(), 
        plot.title = element_text(hjust = 0.5))
pl
ggsave(pl, file="sanchez.png", units="in", 
       width=16, height=8, dpi = 600)

ggplotly(pl)



#uso mt cars para esatas fiiguras
{r}
data(mtcars)
mtcars$name = rownames(mtcars)
mtcars$cyl = as.factor(mtcars$cyl)

# barplot por registro
p5 <- ggbarplot(mtcars, x = "name", y = "mpg", fill = "cyl",  
                color = "white",  palette = "jco", 
                sort.val = "asc", sort.by.groups = TRUE,
                x.text.angle = 90) + font("x.text", size = 8)

# scatterplot con regresión y ecuaciones
p6 = ggscatter(mtcars, x = "wt", y = "mpg", add = "reg.line", conf.int = TRUE,
               color = "cyl", palette = "jco", shape = "cyl") +
  stat_cor(aes(color = cyl), label.x.npc = "centre", label.y.npc="top")

# densityplot
p7 = ggplot(diamonds, aes(depth, fill = cut, colour = cut)) +
  geom_density(alpha = 0.2, na.rm = TRUE) + 
  xlim(58, 68) +  theme_classic() + theme(legend.position = "bottom")

p8 = ggplot(faithfuld, aes(eruptions, waiting)) + 
  geom_raster(aes(fill = density)) + theme_classic() +
  scale_fill_gradientn(colours = heat.colors(10, rev = TRUE), na.value = "white")

ggarrange(p5,p6, labels = c("A", "B"), ncol = 2, nrow = 1, common.legend = TRUE, legend = "bottom")
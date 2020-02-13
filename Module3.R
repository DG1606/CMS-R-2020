# Installing & Loading the package
library(ggplot2)

# read the data
location4 <- "D:/CMS/R_2020/Placement_Data_Class.csv" # copy applicable path
placementgg <- read.csv(location4)
head(placementgg)
colnames(placementgg)
str(placementgg)

# 1. Scatter Plot
base1 <- ggplot(placementgg, mapping = aes(x= ssc_p, y = hsc_p))
# base1 <- ggplot(placementgg, aes(x= ssc_p, y = hsc_p))
base1 + geom_point()
base1 + geom_point(shape = 22, color = "blue", fill = "red", size = 2) # Static
# https://cran.r-project.org/web/packages/ggplot2/vignettes/ggplot2-specs.html

# Dynamic - Make the aesthetics vary based on a variable
base1 + geom_point(aes(color = status))
base1 + geom_point(aes(shape = status))
base1 + geom_point(aes(size = status))
base1 + geom_point(aes(alpha = status))
# add additional varaibales with aesthetics
base1 + geom_point(aes(color = status, shape = gender))
base1 + geom_point(aes(color = status, shape = gender, size = workex))

# add labels
base1 + geom_point()
gg1 <- base1 + geom_point() +
  labs(title = "Scatterplot", x = "% in class 10", y = "% in class 12")
gg1
gg2 <- gg1 +
  theme(plot.title = element_text(face = 'bold.italic', colour = "blue", size = 12, hjust = 0.5),
        axis.title.x = element_text(face = 'bold', colour = "red", size = 10),
        axis.title.y = element_text(face = 'bold', colour = "red", size = 10))
gg2

# make the plot interactive
# install.packages("plotly")
library(plotly)
ggplotly(gg2)


# flip x and y axis
gg2 + coord_flip()

# geom_smooth()
base1 + geom_point() + geom_smooth()
base1 + geom_point() + geom_smooth(method = "lm", se = F) # Don't add shaded confidence region
base1 + geom_smooth()
base1 + geom_smooth(aes(linetype = status))
base1 + geom_smooth(aes(group = status))
base1 + geom_smooth(aes(colour = status))
base1 + geom_point(aes(colour = status)) + geom_smooth(aes(colour = status))

# 2. Bar Chart
base2 <- ggplot(placementgg, aes(degree_t))
base2 + geom_bar() 
base2 + geom_bar(aes(y= stat(prop), group=1))
base2 + geom_bar(aes(fill = degree_t)) # color the bar chart (use same variable)
base2 + geom_bar(aes(color = status))
base2 + geom_bar(aes(fill = status)) # the bars are stacked
base2 + geom_bar(aes(fill = status), position = "dodge") #side-by-side
base2 + geom_bar(aes(fill = status), position = "fill") # percenatge bar chart
base2 + geom_bar(fill = "yellow") + coord_flip()
# Beautifying
base2 + geom_bar(aes(fill = status)) + theme(legend.position = "bottom") +
  ggtitle("Bar Chart")
base2 + geom_bar(aes(fill = status), width = 0.75) +
  geom_text(stat = "count", aes(label=stat(count)), vjust = 1)
base2 + geom_bar(aes(fill = status)) + theme_bw() #theme function changes appearance

# 3. Dot Plot
ggplot(placementgg, aes(degree_p)) + geom_dotplot(binwidth = 1)

# 4. Histogram
base3 <- ggplot(placementgg, aes(degree_p))
base3 + geom_histogram()
base3 + geom_histogram(bins = 10)
base3 + geom_histogram(binwidth = 5, fill = "brown")
base3 + geom_freqpoly(binwidth = 5) #  frequency polygons use lines instead of bars
base3 + geom_histogram(aes(fill = status), binwidth = 5) 
base3 + geom_histogram(aes(fill = status), binwidth = 5) +
  facet_wrap(~gender)

# 5. Density Plot
ggplot(placementgg) + geom_density(aes(etest_p), fill = "pink") + theme_classic()
ggplot(placementgg) + geom_density(aes(etest_p, fill = degree_t))
ggplot(placementgg) + geom_density(aes(etest_p, fill = degree_t), alpha = 0.5)

# 6. Box Plot
base4 <- ggplot(placementgg, aes(y = hsc_p))
base4 + geom_boxplot(fill = "yellow")
base4 + geom_boxplot(aes(x = gender))
base4 + geom_boxplot(aes(y = hsc_p, fill = status))
base4 + geom_boxplot(aes(y = hsc_p, fill = status)) +
  facet_wrap(~gender)
base4 + geom_boxplot(aes(y = hsc_p, fill = status)) +
  facet_grid(workex~gender)

# 7. Violin Plot
base4 + geom_violin(aes(x = status), fill = "green")

# 8. Pie Chart
piebar <- ggplot(placementgg, aes(x = " ", fill = degree_t)) + geom_bar(width = 1)
piebar
piechart <- piebar + coord_polar("y") + theme_void()
piechart

# 9. Line Chart
location5 <- "D:/CMS/R_2020/data_line_chart.csv" # copy applicable path
linedata <- read.csv(location5)
str(linedata)
linedata$year2019 <- factor(linedata$year2019, 
                            levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                                       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), 
                            ordered = T)
linebase <- ggplot(linedata, aes(x = year2019, group = 1))
linebase + geom_line(aes(y = nifty)) + labs(y = "value")
# Beautify
linebase + geom_line(aes(y = nifty), colour = "blue") +
  geom_text(aes(y = nifty, label = nifty), size = 3)
# Multiple lines
linebase + geom_line(aes(y = nifty), colour = "blue") + 
  geom_line(aes(y = nasdaq), colour = "red") + labs(y = "value")

# 10. Treemap
#install.packages("treemapify")
library(treemapify)
treedata <- read.csv("D:/CMS/R_2020/data_treemap.csv") # copy applicable path
colnames(treedata)
mytree <- ggplot(treedata, aes(area = seats, fill = party, label = party)) +
  geom_treemap()
mytree
# name the rectangales
mytree + 
  geom_treemap_text(fontface = "italic", colour = "white", place = "centre",
                    grow = TRUE)

# 11. Heat Map
colnames(placementgg)
placementgg_num <- placementgg[, c(3, 5, 8, 11)] # select only numeric
colnames(placementgg_num)
corr_matrix <- round(cor(placementgg_num),2)
df_corr <- reshape2::melt(corr_matrix)
ggplot(data = df_corr) + 
  geom_tile(mapping = aes(x=Var1, y=Var2, fill=value))

# 12. Pairwise scatterplot matrix
#install.packages("GGally")
library("GGally")
ggcorr(placementgg_num)
ggpairs(placementgg_num) # correlogram
ggscatmat(placementgg, columns = c(3,5,8,11), color = "status") # alternative

# create a frequency table with status and degree_t to understand Mosaic plot
library(dplyr)
placementgg %>% filter(status == "Placed", degree_t == "Comm&Mgmt") %>% 
  summarize(count = n()) # repeat code for other combinations of status v/s degree_t

# 13. Mosaic Plot
# install.packages("ggmosaic")
library(ggmosaic)
base5 <- ggplot(placementgg)
base5 + geom_mosaic(aes(x = product(status, degree_t)))
base5 + geom_mosaic(aes(x = product(status, degree_t), fill = status))
# interactive
library(plotly)
ggplotly(base5 + geom_mosaic(aes(x = product(status, degree_t), fill = status)))

base5 + geom_mosaic(aes(x = product(status, degree_t), fill = status)) +
  facet_grid(gender~.)

# quick plot
qplot(ssc_p, hsc_p, data = placementgg)

# saving a plot
ggsave("myplot.pdf")
ggsave("myplot.png")






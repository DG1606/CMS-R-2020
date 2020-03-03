
# a1
news <- ("The traffic in Bangalore is chaotic. Bangalore is an IT city")
sub("Bangalore", "Bengaluru", news) # replace first match
gsub("Bangalore", "Bengaluru", news) # replace all match
#a2
toupper(news)
tolower(news)


# b1
sportfact <- c("Hockey","Cricket","Football","Hockey","Football", "Football")
sportfact <- as.factor(sportfact)
class(sportfact)
print(sportfact)
#b2
matA <- matrix(1:6, nrow = 2)
matA
matB <- matrix(6:1, ncol = 2)
matB
matAB <- matA %*% matB
matAB
dim(matAB)
matAB[1, 2]
rownames(matAB) <- c("Row1", "Row2")
colnames(matAB) <- c("Col1", "Col2")
matAB

#c1
setwd("D:/Material_CMS/R_2020")
head(mtcars)
str(mtcars)
#c2
write.csv(mtcars, "mycars.csv", row.names = F)
path <- "D:/Material_CMS/R_2020/mycars.csv"
mymtcars <- read.csv(path)
#c3
mymtcars$cyl <- as.factor(mymtcars$cyl)
str(mymtcars)


#a1
name <- c("Abid", "Babul", "Chetna", "David")
ugdegree <- c("commerce", "management", "science", "engineering")
ugpercent <- c(55, 65, 75, 85)
studentdf <- data.frame(name, ugdegree, ugpercent)
studentdf
#a2
tail(studentdf, 2)
studentdf[ , c(1,3)]
#a3
fee <- c(10000, 12000, 14000, 16000)
feedf <- data.frame(name, fee)
class(feedf)
studentdf_full <- merge(studentdf, feedf)
studentdf_full

#b1
path2 <- "D:/Material_CMS/R_2020/Placement_Data_Class.csv"
placement <- read.csv(path2)
library(dplyr)
pldplyr <-  filter(placement, degree_t == "Sci&Tech", degree_p >= 75)
pldplyr
#b2
arrange(pldplyr, degree_p)
#b3
select(pldplyr, starts_with("h"))
#b4
mutate(pldplyr, avg_p = (ssc_p + hsc_p)/2)

#c1
library(ggplot2)
ggplot(placement, aes(x=ssc_p, y=degree_p)) + geom_point()
ggplot(placement, aes(x=ssc_p, y=degree_p)) + geom_point(aes(color=status))
#c2
ggplot(placement, aes(gender)) + geom_bar()
ggplot(placement, aes(gender)) + geom_bar(aes(fill=status))
#c3
ggplot(placement, aes(degree_p)) + geom_histogram(fill = "yellow", binwidth = 5)


# case
path3 <- "D:/Material_CMS/R_2020/data_line_exam.csv"
linedata <- read.csv(path3)
str(linedata)
linedata$month <- as.factor(linedata$month)
ggplot(linedata, aes(x=month, group =1)) + geom_line(aes(y=nifty))

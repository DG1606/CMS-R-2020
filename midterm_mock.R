
#1
infotext <- ("Bombay is a city in Maharashtra state. Bombay is the state capital")
sub("Bombay", "Mumbai", infotext)

#2
toupper(infotext)

#3
studcity <- c("Bangalore","Chennai","Hyderabad","Hyderabad","Chennai", "Hyderabad")
studcity <- as.factor(studcity)
class(studcity)

#4
mat1 <- matrix(1:4, nrow = 2)
mat1
mat2 <- matrix(5:10, ncol = 3)
mat2
mat12 <- mat1 %*% mat2
mat12
rownames(mat12) <- c("Row1", "Row2")
mat12

#5
setwd("D:/Material_CMS/R_2020")
head(iris)
str(iris)

#6
write.csv(iris, "irisdata.csv", row.names = F)
path <- "D:/Material_CMS/R_2020/irisdata.csv"
myiris <- read.csv(path)

#7
myiris$Species <- as.character(myiris$Species)
str(myiris)

#8
name <- c("Abid", "Babul", "Chetna", "David")
department <- c("accounts", "stores", "logistics", "marketing")
salary <- c(10000, 15000, 25000, 20000)
employeedf <- data.frame(name, department, salary)
employeedf

#9
age <- c(30, 40, 45, 35)
agedf <- data.frame(name, age)
newemployeedf <- merge(employeedf, agedf)
newemployeedf

#10
path2 <- "D:/Material_CMS/R_2020/Placement_Data_Class.csv"
placement <- read.csv(path2)
library(dplyr)
studplyr <- filter(placement, degree_t == "Comm&Mgmt", degree_p >= 80)
studplyr
arrange(studplyr, ssc_p)
select(studplyr, contains("_"))
mutate(studplyr, sum_p = ssc_p + hsc_p)

#11
library(ggplot2)
colnames(placement)
ggplot(placement, aes(x=ssc_p, y=degree_p)) + geom_point()
ggplot(placement, aes(x=ssc_p, y=degree_p)) + geom_point(aes(color=gender))

ggplot(placement, aes(workex)) + geom_bar()
ggplot(placement, aes(workex)) + geom_bar(aes(fill=gender))

ggplot(placement, aes(degree_p)) + geom_histogram()



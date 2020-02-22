
matA <- matrix(1:6, nrow = 2)
matA
matB <- matrix(1:6, ncol = 2)
matB

rbind(matA, t(matB))
cbind(t(matA), matB) # alternative

matA
matA[ ,c(1,3)]

colnames(matB) <- c("c1", "c2")
matB

employee <- c("Amol", "Badri", "Chetan", "David")
salary <- c(10000, 11000, 12000, 13000)
startdate <- as.Date(c("2019-12-01", "2018-12-01", "2017-12-01", 
                     "2016-12-01"))
class(startdate)
highqual <- factor(c("UG", "PG", "PhD", "PG"), 
                   levels = c("UG", "PG", "PhD"), ordered = T)
highqual

empdata <- data.frame(employee, salary,startdate, highqual)
empdata
str(empdata)

newguy <- data.frame(employee = "newguy", salary = 15000,
                     startdate = "2020-02-26",
                     highqual = "UG")
empdata <- rbind(empdata, newguy)
empdata

setwd("D:/Material_CMS/R_2020")
write.csv(empdata, "tempdata.csv", row.names = F)

library(dplyr)
arrange(empdata, desc(startdate))
filter(empdata, highqual == "UG")
sample_n(empdata, size = 2)
mutate(empdata, salincre = 0.10*salary)

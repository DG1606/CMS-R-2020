# Vectors
register_no <- c(1001:1005)
participant_name <- c("Anil", "Badri", "Chetna", "Dinesh", "Elisa")
test_1_marks <- c(35,42,47,23,37)
test_2_marks <- c(43,32,40,37,35)

# Vector operations
test_1_marks + 3
sqrt(test_1_marks)
total_marks <- test_1_marks + test_2_marks
print(total_marks)
average_marks <- total_marks/2 # average marks of each student from two tests
mean(total_marks) # average total marks of all the students
max(test_1_marks)
sort(test_2_marks, decreasing = T)
range(test_2_marks)
test_1_marks > 50
any(test_2_marks > 50)
all(total_marks < 100)
test_2_marks > test_1_marks
length(register_no)
nchar(participant_name)
is.na(test_2_marks)
anyNA(test_1_marks)
participant_income <- c(60000, 100000, 45000, NA, 70000)
participant_income

# Accesing vector elements
test_1_marks[1]
participant_name[1:3]
register_no[c(1,3)]
participant_name[-1]

# Factor Vectors
participant_sport <- c("Hockey","Cricket","Basketball","Hockey","Basketball")
sport_factor <- as.factor(participant_sport)
sport_factor
participant_qualification <- factor(c("UG","PhD","UG","PG","UG"),
                                  levels = c("UG","PG","PhD"), ordered = TRUE)
participant_qualification


# Matrices
mat_A <- matrix(1:10, nrow = 5)
mat_A
mat_B <- matrix(1:10, ncol = 5)
mat_B
mat_C <- matrix(11:20, 5)
mat_C
mat_D <- matrix(11:20, , 5)
mat_D
add_mat <- mat_A + mat_C
rbind(mat_A, mat_C)
cbind(mat_A, mat_C)
mul_mat <- mat_A %*% mat_B # size of two mat should be mxn and nxm to multiply
mul_mat
mat_A == mat_C
mat_A %*% t(mat_C) # t is used for transpose
colnames(mat_A) <- c("Level 1", "Level 2")
rownames(mat_A) <- c("A", "B", "C", "D", "E")
print(mat_A)
mat_B <- matrix(1:10, ncol=5, 
                dimnames = list(c("Row1", "Row2"), 
                c("Col1", "Col2", "Col3", "Col4", "Col5")))
mat_B
mat_A %*% mat_B # observe row and col names
# Compare matrix C and E
mat_E <- matrix(11:20,5, byrow = TRUE)
mat_E
mat_C
# To check the dimensions of a matrix
dim(mat_E)
nrow(mat_B)
ncol(mat_D)
length(mat_E)
dim(mat_E) <- c(2, 5) # to reshape a matrix
mat_E
# Extract elements of a matrix
mat_E[1, 2]
mat_E[1, ]
mat_E[ ,3:5]
mat_E[3]

# Data Frames
# below are vectors already defined
participant_name
participant_qualification
participant_income
participant_sport
# creating the DF
df1.participant <- data.frame(participant_name, participant_qualification,
                           participant_income, participant_sport)
df1.participant
# simplify column names
names(df1.participant) <- c("name", "qualification", "income", "sport")
colnames(df1.participant)

# To check various attributes of a DF
class(df1.participant)
nrow(df1.participant)
ncol(df1.participant) # alternatively length()
dim(df1.participant)        
names(df1.participant)
colnames(df1.participant)[2]
rownames(df1.participant)
head(df1.participant)
head(df1.participant, 2)
tail(df1.participant, 2)
df1.participant$name
df1.participant$sport
df1.participant[1, 3]
df1.participant[ , 3]
df1.participant["income"]
df1.participant[1, ]
df1.participant[1, c(1,3)]
df1.participant[ , c(1,3)]
df1.participant[[1]][2:3]
is.na(df1.participant)

# Manipulation of a DF
# Adding columns and rows to a DF
register_no
total_marks
df2.participant <- data.frame(register_no, total_marks)
df3.participant <- cbind(df1.participant, df2.participant)
df3.participant
df4.participant <- cbind(df1.participant$name, df2.participant, 
                         df1.participant[ ,-1])
df4.participant
new_admission <- data.frame(name = "Newguy",
                            qualification = "Dip",
                            sport = "Football",
                            income = 150000,
                            register_no = 1006,
                            total_marks = 35)
rbind(df3.participant,new_admission)
# rbind is smart enough to reorder the columns (sport/income) to match

# To merge two DF horizontally
fee <- c(100000, 75000, 80000, 100000, 0)
df5.partcipant <- data.frame(register_no, fee)
df5.partcipant
merge(df3.participant, df5.partcipant)
merge(df3.participant, df5.partcipant, by = "register_no") 

# Sorting
df3.participant[order(df3.participant$total_marks), ]
df3.participant[order(-df3.participant$income), ]

# Subsetting a DF
df6.participant <- df3.participant[c(-2:-4)]
df6.participant
subset(df3.participant, select = -c(2:4)) # alternate way

# Ediitng data frame
# Task is to add initials to all names
df6.new <- edit(data.frame(df6.participant))
df6.new

# Lists
list_1 <- list(1:5, c("a","b","c","d","e"))
list_1
list_2 <- list(df3.participant, mat_A, fee, myname = "DG")
list_2[[2]]
list_2[[5]] <- list_1
list_2

# Activity - create a csv file from Notepad

# Reading CSVs
# Download Nifty data as csv to your working directory from -
# https://www1.nseindia.com/products/content/equities/indices/historical_index_data.htm

location1 <- "D:/CMS/R_2020/nifty_data_2019.csv" # copy applicable path
nifty_values <- read.table(file = location1, sep = ",", header = TRUE)
nifty_csv <- read.csv(location1) # alternate way
class(nifty_csv)
head(nifty_csv)
View(nifty_csv)
str(nifty_csv)
# as.Date(nifty_csv$Date, format = "%d-%b-%y") # to change class of Date

# Reading Excel files
install.packages("xlsx")
library(xlsx)
location2 <- "D:/CMS/R_2020/nifty_data_2019.xlsx" # copy applicable path
nifty_excel <- read.xlsx(location2, sheetIndex = 1)

# Web Data - Sites with API
library(quantmod)
# options(getSymbols.auto.assign = F)
nifty_yahoo <- getSymbols("^NSEI")
tail(nifty_yahoo)
chartSeries(nifty_yahoo$NSEI.Close) # create a quick chart

# Writing a file
setwd("D:/CMS/R_2020") # copy applicable path
df6.participant
write.csv(df6.participant, "df6_csv")
write.csv(df6.participant, "df6_csv", row.names = F) # to prevent the extra column created earlier
write.xlsx(df6.participant, "df6_excel.xlsx", sheetName = "Sheet1", row.names = F)
View(mtcars)
write.xlsx(mtcars, "mtcars.xlsx", sheetName = "carinfo", row.names = F)
write.csv(nifty_yahoo, "nifty_yahoo_csv", row.names = F)

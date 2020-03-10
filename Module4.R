library(dplyr)
library(ggplot2)

path <- "D:/Material_CMS/R_2020/Placement_Data_Full_Class.csv" # copy applicable path
placementds <- read.csv(path)
placementds$sl_no <- NULL # remove sl.no column
colnames(placementds)
# split the dataset
placementnum <- select(placementds, ends_with("_p"), salary) 
placementcat <- select(placementds, -(ends_with("_p")), -salary)
placedset <- filter(placementds, status == "Placed")
placedset <- na.omit(placementds) # alternative
notplacedset <- subset(placementds, status == "Not Placed")

# basic exploration of the dataset
class(placementds)
anyNA(placementds) # check for NAs
colSums(is.na(placementds))
lapply(placementds, anyNA)
str(placementds)
unique(placementds$degree_t)

# summary statistics

# measures of central tendency
mean(placementnum$degree_p) # Describing center of the data 
placementds %>% group_by(degree_t) %>% summarise(mean(degree_p))
group_by(placementds, degree_t, status) %>% summarise(mean(degree_p))
aggregate(degree_p ~ status + degree_t, placementds, FUN = mean) # alternative
sapply(placementnum, mean) # add na.rm if necessary
apply(placementnum, 2, mean) # other apply family fucntion
lapply(placementnum, mean)
tapply(placementds$degree_p,placementds$gender, mean)
median(placementnum$salary, na.rm = T) # Dealing with missing values 
quantile(placementnum$salary, na.rm = T)
quantile(placementnum$salary, 0.25, na.rm = T) # Customized quantiles
fivenum(placementnum$salary, na.rm = T) # same as quantile for odd no. of observations

# The core packages in R don't have a function for calculating the mode
lsr::modeOf(placementds$salary)

# other means
colMeans(placementnum)
rowMeans(placementnum[ , -6])

# skewness and kurtosis
psych::skew(placementnum) # value close to 0 indicates data is symmetrical
ggplot(placementnum, aes(salary)) + geom_histogram(binwidth = 25000, na.rm = T)
ggplot(placementnum, aes(mba_p)) + geom_histogram(binwidth = 5)

psych::kurtosi(placementnum) # negative-flat, positive-pointy, zero-just enough pointy
ggplot(placementnum, aes(ssc_p)) + geom_histogram(bins = 10)
ggplot(placementnum, aes(hsc_p)) + geom_histogram(bins = 10)

# mean v/s median
mean(placementnum$salary, na.rm = T)
median(placementnum$salary, na.rm = T)
mean(placementnum$salary, trim = 0.10, na.rm = T) #Trimmed mean

# measures of variation
min(placementnum$mba_p)
max(placementnum$mba_p)
range(placementnum$mba_p)
IQR(placementnum$salary, na.rm = T)
sd(placementnum$degree_p)
var(placementnum$degree_p)
mad(placementnum$degree_p)

# Summarizing a variable
summary(placementnum$mba_p)

# Summarizing a complete dataset
summary(placementnum) 
summary(placementds)
psych::describe(placementnum)

# Describing Categories
table(placementcat$status)  
sapply(placementcat, table)
table(placementcat$specialisation, placementcat$status) # Creating a two-way table 
mytab <- with(placementcat, table(specialisation, status)) # alternative
mytab
addmargins(mytab)
prop.table(mytab) # proportion based on total number
prop.table(mytab, margin = 1) # proportions over rows and columns
# visualisation
df_mytab <- as.data.frame(mytab)
df_mytab
ggplot(df_mytab, aes(x=specialisation, y = Freq)) +
  geom_bar(aes(fill = status), stat = "identity")
# Note - when heights of the bars have to represent values (freq) in the data, 
# use stat="identity" and map a value to the y aesthetic

tab3 <- xtabs(~gender+specialisation+status, placementds) # 3-way crosstabs
tab3
ftable(tab3)

# Tracking correlations
cor(placementnum$degree_p, placementnum$mba_p) 
ggplot(placementnum, aes(degree_p, mba_p)) + geom_point()
corcomplete <- cor(placementnum) # correlations for multiple variables
corcomplete
corcomplete["ssc_p", "mba_p"]
placementnum %>% cor()  # alternative
# Dealing with missing values 
cor(placementnum$mba_p, placementnum$salary, use="complete.obs") 
cor(placementnum, use = "pairwise.complete.obs")

# Assess the normality - Visual methods
ggplot(placementds) + geom_density(aes(degree_p)) # density plot
ggplot(placementds) + geom_histogram(aes(degree_p), bins = 10) # histogram
qqbase <- ggplot(placementds, aes(sample=degree_p))
qqbase + geom_qq()
qqbase + geom_qq() + geom_qq_line() # qq plot
qqbase + stat_qq() + stat_qq_line() # alternative
qqbase1 <- ggplot(placementds, aes(sample=degree_p, color = status))
qqbase1 + geom_qq() + geom_qq_line()

# Shapiro-Wilk's test to test normality
shapiro.test(placementds$degree_p) 
# Note: p>= 0.05 which is our choosen alpha, we can assume normality
shapiro.test(placementds$mba_p)

# Correlation test between two variables
ggplot(placementnum, aes(degree_p, mba_p)) + geom_point() + geom_smooth()
cor(placementnum$degree_p, placementnum$mba_p) 
# Pearson correlation test
cor.test(placementnum$degree_p, placementnum$mba_p)
# Note: p < 0.05, we can conclude the variables are significantly correlated

# Correlation test between multiple variables
round(cor(placementnum, use = "pairwise.complete.obs"), 2)
GGally::ggpairs(placementnum)
library(Hmisc)
rcorr(as.matrix(placementnum))

# One-sample t-test
# Select a sample of size 100
set.seed(25)
mysample <-  sample_n(placementds, size = 100)
summary(mysample$degree_p)

# We want to prove that the average degree_p differs from 60% (two-tailed test)
#H0=60
t.test(mysample$degree_p, mu = 60, alternative = "two.sided") # default is two sided
# Note: p < 0.05,  We can conclude that the mean degree_p is significantly different from 60% 

# We want to prove that the average degree_p is less than 66% (one-tailed test)
# H0 >=66
t.test(mysample$degree_p, mu = 66, alternative = "less")

# Two-sample t-test
# create two samples based on gender
set.seed(25)
malesample <- placementds %>% filter(gender == "M") %>% sample_n(size = 50)
femalesample <- placementds %>% filter(gender == "F") %>% sample_n(size = 50)

# Is there any significant difference between male and female percentage?
t.test(malesample$degree_p, femalesample$degree_p, var.equal = T) # default two.sided
# Note: p < 0.05,  We can conclude that the mean degree_p is significantly different  between the two groups

# We want to prove that the average percentage of male is less than that of female
#H0: mm >= mf
t.test(malesample$degree_p, femalesample$degree_p, var.equal = T, alternative = "less")

# Method 2 - If the data are saved in single dataframe
t.test(degree_p~gender, data = mysample, var.equal = T)

# Welch t-statistic (unequal varaince)
t.test(degree_p~gender, data = mysample, var.equal = F)

# Paired sample t-test
pairdata <- read.csv("D:/Material_CMS/R_2020/data_paired_t_test.csv")
colnames(pairdata)
# we want to check whether alcohol consumption is more after break-up
# H0: mu(d) <= 0
t.test(pairdata$After_Breakup, pairdata$Before_Breakup, paired = T, alternative = "greater")
# Note: we retain the null and conclude the diff. in alcohol consumption is not greater than 0 before and after breakup

# one-way ANOVa
levels(placementds$degree_t)
# compute the summary statistics for understanding
placementds %>% group_by(degree_t) %>% summarise(count = n(), 
                                                 mean(mba_p), sd(mba_p))
# visulaise for a better understanding
ggplot(placementds, aes(y=mba_p)) +geom_boxplot(aes(fill = degree_t))

# we want to check whether type of degree had any significant impact on the average MBA %
myaov1 <-  aov(mba_p ~ degree_t, data = placementds)
summary.aov(myaov1)
# Note: p >= 0.05,  We can conclude that the mean MBA % under different degree type are same

# Diagnostic Checking
# a. Homogeneity of variance
plot(myaov1, 1)
bartlett.test(mba_p ~ degree_t, data = placementds)
# Null hypothesis is there is homogeneity of variances across groups

# b. Check the normality assumption
plot(myaov1, 2)
myaov1residuals <- residuals(myaov1)
shapiro.test(myaov1residuals)
# Note: normality assumption is violated

# chi-square goodness of fit test
deg_count <-  table(placementcat$degree_t)
deg_count
chi_degree <- chisq.test(deg_count, p = c(0.6, 0.05, 0.35))
chi_degree
# Note: p >= 0.05,  We retain the null
chi_degree$expected #(should be greater than 5)

# Chi-square test of independence
table(placementcat$degree_t, placementcat$status)
chi_degpla <- chisq.test(placementcat$degree_t, placementcat$status)
chi_degpla
# Note: p >= 0.05,  We retain the null
chi_degpla$expected # reason for the approximation may be incorrect warning

# different variable
chisq.test(placementcat$specialisation, placementcat$status)

# One-sample Wilcoxon signed rank test
# first, check for normality
# Shapiro-Wilk's test to test normality
shapiro.test(placementds$salary)
# Note: p<0.05, reject null and hence we cannot assume normality

# We want to prove that the median salary differs from Rs.250000 (two-tailed test)
#H0=250000
wilcox.test(placementds$salary, mu = 250000, alternative = "two.sided")
# Note: p < 0.05,  We can conclude that the median salary is significantly different from 250000

# We want to prove that the median salary is less than Rs.275000 (one-tailed test)
# H0 >=275000
wilcox.test(placementds$salary, mu = 275000, alternative = "less")

# Mann Whitney U Test
# explore the median
group_by(placementds, gender) %>% summarise(median(salary, na.rm = T))

# Is there any significant difference between male and female salary?
wilcox.test(salary~gender, data = placementds)
# Note: p < 0.05, We can conclude that the median salary is significantly different between the genders


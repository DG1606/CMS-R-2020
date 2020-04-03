library(dplyr)
library(ggplot2)

location <- "D:/Material_CMS/R_2020/Placement_Data_Full_Class.csv"
placement.df <- read.csv(location)

# select only relevant columns
colnames(placement.df)
placement.reg <- select(placement.df, degree_p, mba_p)
str(placement.reg)
placement.reg %>%  cor()

# Basic Visualisation
ggplot(placement.reg, aes(degree_p, mba_p)) +
  geom_point()
ggplot(placement.reg, aes(x = cut(degree_p, breaks = 5), y = mba_p)) +
  geom_boxplot()
ggplot(placement.reg, aes(degree_p, mba_p)) +
  geom_point() + geom_smooth()

# SLR model
# mba_p = b0 + b1*degree_p
model1 <- lm(mba_p~degree_p, data = placement.reg)
model1
# for every one percentage increase in degree percent, 
# the MBA percent will increase by 0.319% on an average

# Regression line
ggplot(placement.reg, aes(degree_p, mba_p)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE)


# Model assessment
summary(model1)

# Characteristics
mba_p.hat <- fitted.values(model1)
head(mba_p.hat)
head(placement.reg$mba_p)
mean(mba_p.hat) == mean(placement.reg$mba_p) #should be same
mod1residual <- residuals(model1)
head(mod1residual)
mean(mod1residual) #should be zero
sum(mod1residual) #should be zero

# Highlighting the Residuals
ggplot(placement.reg, aes(degree_p, mba_p)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  geom_segment(aes(xend = degree_p, yend = mba_p.hat), color = "red", size = 0.3)
# Histogram of residuals for understanding
residual.df <- as.data.frame(mod1residual)
ggplot(residual.df,aes(mod1residual)) +  geom_histogram(bins = 8, fill='blue')

# Diagnostic Plots
plot(model1)

# Cook's distance
plot(model1, 4)

# MLR
# select only relevant columns
colnames(placement.df)
placement.mlr <- placement.df %>% select(ends_with("_p"), -etest_p)
colnames(placement.mlr)
str(placement.mlr)

# Correlation among numeric columns
placement.mlr %>% cor()
# Correlation Visualisation
GGally::ggcorr(placement.mlr)
GGally::ggpairs(placement.mlr)

# Train and Test data
library(caTools) # to split data into train and test
set.seed(1001)
sample <- sample.split(placement.mlr$mba_p, SplitRatio = 0.80)
train = subset(placement.mlr, sample == TRUE)
test = subset(placement.mlr, sample == FALSE)

# MLR model
mlrmodel <- lm(mba_p~., train)
mlrmodel

# Model assessment
summary(mlrmodel)

# Remove insignificant independent variable
mlrmodel1 <- lm(mba_p ~ hsc_p + degree_p, train)
summary(mlrmodel1)

# Residual analysis
plot(mlrmodel1)

# VIF
car::vif(mlrmodel1)

# Prediction on test data
mbapred <- predict(mlrmodel1, test)
data.frame(test$mba_p, mbapred)

# cross-validation
mse <- mean((test$mba_p - mbapred)^2)
rmse <- sqrt(mse)
rmse
prederror <- rmse/mean(test$mba_p)
prederror

# using caret package
library(caret)
RMSE(mbapred, test$mba_p)
R2(mbapred, test$mba_p)
MAE(mbapred, test$mba_p)
RMSE(mbapred, test$mba_p)/mean(test$mba_p)

# Logistic Regression

# select only relevant columns
colnames(placement.df)
placement.lr <- placement.df %>% select(ends_with("_p"), -etest_p, status)
colnames(placement.lr)
table(placement.lr$status)
contrasts(placement.lr$status) # to check how a variable have been coded
# we need Not Placed class to be coded as 1 (positive)
placement.lr$status <- ifelse(placement.lr$status == "Not Placed", 1, 0)
table(placement.lr$status)

# Train and Test data
library(caTools) # to split data into train and test
set.seed(101)
sample <- sample.split(placement.lr$status, SplitRatio = 0.80)
train.lr = subset(placement.lr, sample == TRUE)
test.lr = subset(placement.lr, sample == FALSE)

#check the splits
prop.table(table(train.lr$status))
prop.table(table(test.lr$status))

# Train the model
model.lr <- glm(status ~ degree_p, family = binomial, data = train.lr)
summary(model.lr)

# prediction
lr.pred <- predict(model.lr, newdata = test.lr, type = "response")
head(lr.pred)
# The probabilities always refer to the class dummy-coded as "1"
head(test.lr$status)

# Classification Table
# categorize into groups based on the predicted probability
lr.pred.class <- ifelse(lr.pred>=0.5, 1, 0)
head(lr.pred.class)
table(lr.pred.class)
table(test.lr$status)
conf.matrix <- table(test.lr$status, lr.pred.class)
conf.matrix
rownames(conf.matrix) <- c("Placed", "Not Placed")
colnames(conf.matrix) <- c("Placed", "Not Placed")
addmargins(conf.matrix)

# model accuracy
mean((test.lr$status == lr.pred.class)) 


# different cut-off
lr.pred.class1 <- ifelse(lr.pred>=0.35, 1, 0)
conf.matrix1 <- table(test.lr$status, lr.pred.class1)
conf.matrix1

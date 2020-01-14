# Mathematical Operations 
1 + 1
1 + 2 + 3
2 - 3
2 * 3
2 * 3 + 1
5 / 2
3^2
5 %% 2 # Modulo, gives the remainder


# Variables
# Assign a value to a variable
x1 <- 2
x2 <- -4
x2
(x3 <- 1:5) # observe the console. Colon operator creates a sequence
x4 <- x5 <- 3
assign("x6", 9)
x7 <- "Hello World"
print(x7)
x8 <- 5.5
x1 <- 3.5
x9 <- 5L #L is used to indicate integer
x10 <- seq(1:5)
x10
my_marks_in_r <- 75
print("I have got a hang of this")

# Remove a variable        
rm(x5)
x5 #undertand the error

# Use the created variables/objects in calculations
x1 + x2
my_sum <- x8 + x9
print(my_sum)
x9 * 5


# Data types
class(x1)
class(x9)
class(x7)
typeof(x10)
is.numeric(x2) # Alternate way of asking the variable its type

# Alternate way of handling character data
my_name <- factor("Dhimant Ganatra")
class(my_name)
my_name
x7 # did you notice the difference

# Dates
today_date <- as.Date("2020-01-13")
today_date
class(today_date)
today_date + 7

# Logical
is_r_easy <- TRUE
class(is_r_easy)
2 > 3
1 + 1 == 3 # is 1+1 equal to 3?
1/49 * 49 == 1 #Surprised??

# Built-in Functions
# Numeric Functions
abs(-4.5)
sqrt(16)
ceiling(4.565)
floor(4.565)
trunc(4.565) # For positive numbers, trunc and floor give the same result.
ceiling(-4.565)
floor(-4.565)
trunc(-4.565) # This is because trunc always rounds toward 0
round(4.565)
round(4.565, digits = 2)
round(-4.565)
round(-4.1)
signif(4.565, digits = 2)
log(10)
exp(1)
factorial(3)

# Character Functions
word <- "programmingwithR"
substr(word, start = 12, stop = 15) # extract
substr(word, start = 12, stop = 15) <- "thru" # replace
word
word_1 <- "Split the words in a sentence"
strsplit(word_1, " ")
full_name <- "Firstname Surname"
strsplit(full_name, " ")
strsplit(full_name, " ")[[1]][1]
rating <- c("A", "B", "A+", "AA", "C")
grep("A", rating) #Globally search a Regular Expression and Print
news <- ("The traffic in Bangalore is chaotic. Bangalore is an IT city")
sub("Bangalore", "Bengaluru", news) # replace first match
gsub("Bangalore", "Bengaluru", news) # replace all match
toupper(news)
tolower(news)

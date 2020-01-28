library(dplyr)

# load the placement data file
location3 <- "D:/CMS/R_2020/Placement_Data_Class.csv" # copy applicable path
placement <- read.csv(location3)
class(placement)
View(placement)
colnames(placement)
head(placement)
str(placement)
levels(placement$hsc_s)
levels(placement$degree_t)
levels(placement$degree_t) <- c("CM", "Ot", "ST")
str(placement$degree_t)

# pick observations by their values using filter()
filter(placement, degree_t == "CM",
       degree_p >= 80)
filter(placement, degree_t == "CM",   
         degree_p >= 80,  
         gender != "M")  
filter(placement, degree_t == "CM",
         degree_p >= 80 | degree_p <= 55)
filter(placement, degree_t == "CM", 
         degree_p >= 80 | degree_p <= 55,
         gender != "F")

# select a small subset of data for ease of understanding
p_xtreme <- filter(placement, degree_p >= 85 | degree_p <= 52)
p_xtreme

# reorder the rows using arrange()       
arrange(p_xtreme, etest_p)
arrange(p_xtreme, desc(ssc_p))
arrange(p_xtreme, gender, desc(ssc_p))

# pick variables (columns) by their names using select()
select(p_xtreme, ssc_p, hsc_p, degree_p)
select(p_xtreme, ssc_p:degree_p)
select(p_xtreme,-(ssc_p:degree_p))
select(p_xtreme, ends_with("_p")) 
select(p_xtreme, starts_with("h"))
select(p_xtreme, contains("_")) # there are other helper functions also
rename(p_xtreme, gen = gender) # to rename variables
select(p_xtreme, 1:3)

# create new varaibles which are functions of existing varaibles using mutuate()
mutate(p_xtreme, avg_p = (ssc_p + hsc_p + degree_p)/3)
transmute(p_xtreme, avg_P = (ssc_p + hsc_p + degree_p)/3)

# Group summary using summarize()
summarise(p_xtreme, mean(degree_p))
summarise(group_by(p_xtreme, degree_t), mean(degree_p))

# select rows randomly
sample_n(placement, size = 10)
set.seed(100) # seed helps to get the same set
sample_n(placement, size = 10) 
sample_frac(placement, size = 0.10)


# combining multiple operations with the Pipe
placement %>% group_by(degree_t) %>% summarise(count = n()) # read %>% as 'then'. Use shortcut
placement %>% group_by(degree_t) %>% 
  summarise(mean(degree_p)) 
placement %>% group_by(degree_t, gender) %>% 
  summarise(mean(degree_p))
placement %>% filter(status == "Placed") %>% 
  group_by(degree_t, workex) %>% summarise(mean(degree_p))
placement %>% group_by(status) %>% summarise(count = n(), mean(degree_p))
placement %>% filter(status == "Not Placed") %>% 
  group_by(degree_t) %>% summarise(count = n())
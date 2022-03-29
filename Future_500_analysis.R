getwd()
setwd("C:/Users/Dell/Desktop")
rm(list = ls(all.names = TRUE))# remove all lprevious data frames from R studio
#fin<-read.csv("Future_500.csv") # this is basic data loading
# To effective data manipulation we will replace the blank values with NA at very beginning
fin<-read.csv("Future_500.csv", na.strings = c("")) 
fin
head(fin)
tail(fin)
str(fin)
summary(fin)
# changing from integer to factor(nominal label)
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)
summary(fin)
str(fin)
#Factor variable Trap
# x<-as.numeric(as.character(z)) ---- In brief first convert factor in to character then to numeric
# sub()and gsub()--- Sub replaces object in first instance 
?sub
fin$Expenses<-gsub("Dollars","",fin$Expenses)
fin$Expenses<-gsub(",","",fin$Expenses)
fin$Revenue<-gsub("\\$","",fin$Revenue) # if dealing with special character like doller use escape sequence (google it)
fin$Revenue<-gsub(",","",fin$Revenue)
head(fin)
str(fin)
fin$Growth<-gsub("%","",fin$Growth)
head(fin)
# convert character to numeric for calculations
fin$Expenses<-as.numeric(fin$Expenses)
fin$Revenue<-as.numeric(fin$Revenue)
fin$Growth<-as.numeric(fin$Growth)
str(fin)
#Locate and  Dealing with missing Data
head(fin,25)
complete.cases(fin)# vector representing row which are complete
!complete.cases(fin)# vector representing row which are not complete i.e. conains NA values
fin[!complete.cases(fin),] # pick only NA data leaves  blank values

# Filtering : using which() for non- missing data

fin[fin$Employees == 45,] # created a filter  but it also return NA value along side filter hence we use which command
fin[which(fin$Employees == 45),]# only filter returns filtered values

# Filtering ; using is.na() for missing data

is.na(fin$Expenses)
fin[is.na(fin$Expenses),]

# removing records with missing data

fin_backup<- fin # create a backup to preserve original data

fin <- fin[!is.na(fin$Industry),]
head(fin)
fin
fin[!complete.cases(fin),]
dim(fin)
# Resetting index
row.names(fin)<-1:nrow(fin)
fin
row.names(fin) <- NULL
fin
# replacing Missing data : Factual analysis
fin[!complete.cases(fin),]
fin[!is.na(fin$State),][1:10,]
fin[is.na(fin$State) & fin$City=="San Francisco","State"]<- "CA"# Replacing the NA with statecode
fin[is.na(fin$State) & fin$City=="San Francisco ","State"]
fin[is.na(fin$State) & fin$City=="New York","State"] <- "NY"
# Check
fin[!complete.cases(fin),]
# replacing the missing data : Median Imputation Method(Part-1)
fin[!complete.cases(fin),]
median(fin[,"Employees"],na.rm=TRUE) # calculate ignoring  na values
med_empl_retail<- median(fin[fin$Industry=="Retail","Employees"],na.rm=TRUE) # calculate ignoring  na values and adding filter
fin[is.na(fin$Employees)& fin$Industry=="Retail",]
fin[is.na(fin$Employees)& fin$Industry=="Retail", "Employees"] <- med_empl_retail
# check by row no
fin[3,]
med_empl_finserv<- median(fin[fin$Industry=="Financial Services","Employees"],na.rm=TRUE)
med_empl_finserv
fin[is.na(fin$Employees)& fin$Industry=="Financial Services",] # find out na row with filter
fin[is.na(fin$Employees)& fin$Industry=="Financial Services","Employees"]<-med_empl_finserv
fin[330,]
med_growth_constr<- median(fin[fin$Industry=="Construction","Growth"],na.rm=TRUE)
med_growth_constr
fin[is.na(fin$Growth)& fin$Industry=="Construction",]
fin[is.na(fin$Growth)& fin$Industry=="Construction","Growth"] <- med_growth_constr
fin[8,]
fin[!complete.cases(fin),]
# To calculate expenses section you need to be double sure else 
#revenue
med_rev_constr <- median(fin[fin$Industry=="Construction","Revenue"],na.rm=TRUE)
med_rev_constr
fin[is.na(fin$Revenue)& fin$Industry=="Construction","Revenue"] <- med_rev_constr
# expenses
med_expl_constr <- median(fin[fin$Industry=="Construction","Expenses"],na.rm=TRUE)
med_expl_constr 
fin[is.na(fin$Expenses)& fin$Industry=="Construction",]
fin[is.na(fin$Expenses)& fin$Industry=="Construction","Expenses"] <- med_expl_constr
fin[!complete.cases(fin),]
# Deriving  values method by calculation
fin[is.na(fin$Profit),]
fin[is.na(fin$Profit),"Profit"] <-fin[is.na(fin$Profit),"Revenue"]-fin[is.na(fin$Profit),"Expenses"]
fin[!complete.cases(fin),]
fin[is.na(fin$Expenses),]
fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"]-fin[is.na(fin$Expenses),"Profit"]
fin[!complete.cases(fin),]
fin[is.na(fin$Expenses),]

# Data preparation has been done we must start analysis.

install.packages("ggplot2")

p <- ggplot(data=fin)

# Data visulization
#Scatterplot classfied by industry showing revenue, exepnses, profit etc.
p
p + geom_point(aes(x=Revenue,y=Expenses,colour=Industry ,size=Profit))

#Scatterplot industry trends for the expenses

d <- ggplot(data=fin,aes(x=Revenue,y=Expenses,colour=Industry)) 

d + geom_point()+geom_smooth(fill=NA,size=0.2)              
# Boxplot

f <- ggplot(data=fin,aes(x=Industry,y=Growth,colour=Industry))
f+geom_boxplot(size=.5)
# Extra
f+geom_jitter()+geom_boxplot(size=0.75,alpha=0.5,outlier.color = NA)

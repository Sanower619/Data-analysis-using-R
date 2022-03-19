stats<-read.csv(file.choose())# manually allows you to select file via Pop window
stats
nrow(stats)
ncol(stats)
str(stats)
summary(stats)
stats
head(stats)
stats$Internet.users[4]
levels(stats$Income.Group)
# basic operations for dataframe
stats[1:10,] #subset
# Filtering dataframe
head(stats)
Highbirthrate <- stats$Birth.rate>40
stats[Highbirthrate,]

Wealthy<-stats$Income.Group=="Upper middle income"# First Method
stats[Wealthy,]

stats[stats$Income.Group=="Upper middle income",]# Second method

# Visualizing with Qplot

install.packages("ggplot2")
library(ggplot2)
?qplot()
qplot(data = stats,x=Internet.users,y= Birth.rate)
qplot(data = stats,x=Income.Group,y= Birth.rate,color = Income.Group,geom = "boxplot")

# Create new Data.frame

mydf <-data.frame(Countries_2012_Dataset,Codes_2012_Dataset,Regions_2012_Dataset)

head(mydf)
colnames(mydf) <- c("Countries","Codes","Region")
head(mydf)

rm(mydf)
# Create new DataFrame second method
mydf <-data.frame(Countries=Countries_2012_Dataset,Codes=Codes_2012_Dataset,Region=Regions_2012_Dataset)

head(mydf)

#Merging Dataframe

New_stats <- merge( stats, mydf, by.x = "Country.Name", by.y = "Countries")


head(New_stats)

New_stats$Codes<- NULL
head(New_stats)



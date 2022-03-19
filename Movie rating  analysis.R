Movies <-read.csv(file.choose())# Importing data file and manipulation as per requirement
head(Movies)
tail(Movies)
str(Movies)
summary(Movies)
colnames(Movies) <- c("Film","Genre","CriticRating","Audience.Ratings","BudgetMillions", "Year")
factor(Movies$Year)
Movies$Year <- factor(Movies$Year)
summary(Movies)
str(Movies)

install.packages("ggplot2")
# Asthetics+add color
ggplot(data=Movies, aes(x=CriticRating,y=Audience.Ratings, color=Genre, size= BudgetMillions))+
  geom_point()

# Creating an object amd using it  changing the graphs

P<-ggplot(data=Movies, aes(x=CriticRating,y=Audience.Ratings, color=Genre, size= BudgetMillions))
P + geom_line()

#Overriding Asthtics

P+ geom_point(aes(colour=BudgetMillions))

# Mapping vs setting
r<-ggplot(data=Movies, aes(x=CriticRating,y=Audience.Ratings, color=Genre, size= BudgetMillions))
r + geom_point()

# Histogram

H <- ggplot(data = Movies,aes(x=BudgetMillions))

# adding color + border

H + geom_histogram(binwidth=10,aes(fill=Genre),color="Black")

# using geo_smooth

u<-ggplot(data=Movies, aes(x=CriticRating,y=Audience.Ratings, color=Genre))

u+ geom_point()+geom_smooth(fill=NA)

u+ geom_boxplot()+ geom_jitter()


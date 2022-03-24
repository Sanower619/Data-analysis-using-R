getwd()
setwd("C:/Users/Dell/Desktop")
getwd()
rm(H,P,r,u)
df<-read.csv("IPL_deliveries.csv")
head(df)

df_warner<-df[(df$batsman=="DA Warner"),]
dim(df_warner)
rm(df_1)
head(df_warner)
df_warner <- df_warner[!(df_warner$dismissal_kind == ""), ]#to remove blank values in column
A <-sort(table(df_warner$dismissal_kind), decreasing = TRUE) 
A
dim(A)
str(A)
summary(A)
pie(A)
barplot(A)
df_warner2<-df[(df$batsman=="DA Warner"),]
dim(df_warner2)
df_six<-df_warner2[(df_warner2$batsman_runs==6),]
length(df_six)# A dataframe is a list of columns, hence the result we got is  incorrect.
head(df_six)
df_totalruns <-sort(table(df_warner2$batsman_runs), decreasing = TRUE)
head(df_totalruns)
nrow(df_six)# Instead of length we use nrow here to calculate the no of rows in list
ncol(df_six)
pie(df_totalruns)
Teams<-c(
  "Royal Challengers Bangalore"="RCB", 
  "Sunrisers Hyderabad"="SRH",
  "Rising Pune Supergiant"="RPS",
  "Mumbai Indians"="MI",
  "Kolkata Knight Riders"="KKR", 
  "Gujarat Lions"="GL",
  "Kings XI Punjab"="KXIP",
  "Delhi Daredevils"="DD",
  "Chennai Super Kings"="CSK",
  "Rajasthan Royals"="RR",
  "Deccan Chargers"="DC",
  "Kochi Tuskers Kerala"="KTK",
  "Pune Warriors"="PW",
  "Rising Pune Supergiants"="RPS"
)# Creating dictionary for renaming
df$batting_team <- stringr::str_replace_all(string = df$batting_team ,
                                     pattern= Teams) # renaming the team using Dictionary
df_runs<-aggregate(total_runs~match_id+inning+batting_team,df,sum)# sum of runs by team
head(df_runs2)
df_runs=df_runs[c("inning","batting_team","total_runs")]#droping matching id column
head(df_runs) 
First_innings<-df_runs[(df_runs$inning==1),]
head(First_innings)
Second_innings<-df_runs[(df_runs$inning==2),]
head(Second_innings)
boxplot(total_runs~batting_team,First_innings, xlab = "batting_team",
        ylab = "total_runs")
boxplot(total_runs~batting_team,Second_innings, xlab = "batting_team",
        ylab = "total_runs")


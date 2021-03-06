getwd()
setwd("C:\\Users\\rohit\\Desktop")


Gluc <- read.csv("sirpi_glucose_data.csv")
head(Gluc)
str(Gluc)
summary(Gluc)

library(ggplot2)
library(scales)
library(dplyr)

#1
GlucosevsTime <- ggplot(Gluc, aes(x=Time, y=Glucose)) + geom_line()
GlucosevsTime + geom_line(group = 1, size=1)                


#2
Oct <- Gluc[Gluc$date=="1 Oct",]

GlucosevsTime <- ggplot(Oct, aes(x=Time, y=Glucose)) + geom_line()
GlucosevsTime + geom_line(group = 1, size=1) + xlab("Time") + ggtitle("Glucose Levels in 1st October")     
     
     
#3
average <- aggregate(Gluc[,2], list(Gluc$date), mean)

colnames(average)[names(average) == "Group.1"] <- "Date"
colnames(average)[names(average) == "x"] <- "Average"

average[,"Average"] <- round(average[,"Average"], 0)

average

#4
iris <- read.csv("sirpi_iris.csv")
head(iris)

sepwidvsseplength <- ggplot(data=iris, aes(x=sepal_length, y=sepal_width, colour=species))
sepwidvsseplength + geom_point(size=2) + ggtitle("iris plot")

#5
crimedata <- read.csv("kaggle_crime_data_india-2001-2010.csv")
head(crimedata)


#......1
yearlycounts <- crimedata %>%
                group_by(year, cases_property_stolen) %>%
                summarise(count=n())

yearlycounts <- aggregate(yearlycounts$cases_property_stolen, by=list(year=yearlycounts$year), FUN=sum)

TotalCasesstolvsyear <- ggplot(data=yearlycounts, aes(x=year, y=x))
TotalCasesstolvsyear + geom_line(group = 1, size=2, colour="Red") + scale_x_continuous(breaks = round(seq(min(yearlycounts$year), max(yearlycounts$year), by = 1),1)) + ylab("Total Cases") + ggtitle("Year wise trend of Property Stolen Cases")



#.....2

yearlycounts2 <- crimedata %>%
  group_by(year, cases_property_recovered) %>%
  summarise(count=n())

yearlycounts2 <- aggregate(yearlycounts2$cases_property_recovered, by=list(year=yearlycounts2$year), FUN=sum)

TotalCasesrecvsyear <- ggplot(data=yearlycounts2, aes(x=year, y=x))
TotalCasesrecvsyear + geom_line(group = 1, size=2, colour="Blue") + scale_x_continuous(breaks = round(seq(min(yearlycounts2$year), max(yearlycounts2$year), by = 1),1)) + ylab("Total Cases") + ggtitle("Year wise trend of Property Recovered Cases")

#.....3

AP <- crimedata[crimedata$area_name=="Andhra Pradesh",]
KAR <- crimedata[crimedata$area_name=="Karnataka",]
PUN <- crimedata[crimedata$area_name=="Punjab",]
RAJ <- crimedata[crimedata$area_name=="Rajasthan",]

yearlycountsAP <- AP %>%
  group_by(year, cases_property_recovered) %>%
  summarise(count=n())

yearlycountsKAR <- KAR %>%
  group_by(year, cases_property_recovered) %>%
  summarise(count=n())

yearlycountsPUN <- PUN %>%
  group_by(year, cases_property_recovered) %>%
  summarise(count=n())

yearlycountsRAJ <- RAJ %>%
  group_by(year, cases_property_recovered) %>%
  summarise(count=n())

yearlycountsAP <- aggregate(yearlycountsAP$cases_property_recovered, by=list(year=yearlycountsAP$year), FUN=sum)
yearlycountsKAR <- aggregate(yearlycountsKAR$cases_property_recovered, by=list(year=yearlycountsKAR$year), FUN=sum)
yearlycountsPUN <- aggregate(yearlycountsPUN$cases_property_recovered, by=list(year=yearlycountsPUN$year), FUN=sum)
yearlycountsRAJ <- aggregate(yearlycountsRAJ$cases_property_recovered, by=list(year=yearlycountsRAJ$year), FUN=sum)

TotalCasesrecAP <- ggplot(data=yearlycountsAP, aes(x=year, y=x))
TotalCasesrecAP <- TotalCasesrecAP + geom_line(group = 1, size=2, colour="Blue") + scale_x_continuous(breaks = round(seq(min(yearlycounts2$year), max(yearlycounts2$year), by = 1),1)) + ylab("Total Cases") + coord_cartesian(ylim=c(0,40000)) + ggtitle("Andhra Pradesh")               

TotalCasesrecKAR <- ggplot(data=yearlycountsKAR, aes(x=year, y=x))
TotalCasesrecKAR <- TotalCasesrecKAR + geom_line(group = 1, size=2, colour="Blue") + scale_x_continuous(breaks = round(seq(min(yearlycounts2$year), max(yearlycounts2$year), by = 1),1)) + ylab("Total Cases") + coord_cartesian(ylim=c(0,40000)) + ggtitle("Karnataka") 

TotalCasesrecPUN <- ggplot(data=yearlycountsPUN, aes(x=year, y=x))
TotalCasesrecPUN <- TotalCasesrecPUN + geom_line(group = 1, size=2, colour="Blue") + scale_x_continuous(breaks = round(seq(min(yearlycounts2$year), max(yearlycounts2$year), by = 1),1)) + ylab("Total Cases") + coord_cartesian(ylim=c(0,40000)) + ggtitle("Punjab")

TotalCasesrecRAJ <- ggplot(data=yearlycountsRAJ, aes(x=year, y=x))
TotalCasesrecRAJ <- TotalCasesrecRAJ + geom_line(group = 1, size=2, colour="Blue") + scale_x_continuous(breaks = round(seq(min(yearlycounts2$year), max(yearlycounts2$year), by = 1),1)) + ylab("Total Cases") + coord_cartesian(ylim=c(0,40000)) + ggtitle("Rajasthan")

library(ggpubr)
Arrangedplot <- ggarrange(TotalCasesrecAP, TotalCasesrecKAR, TotalCasesrecPUN, TotalCasesrecRAJ,  ncol = 2, nrow = 2) + ggtitle("Year Wise Trend Property Recovering Cases")
Arrangedplot












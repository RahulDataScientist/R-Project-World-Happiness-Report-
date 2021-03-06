library (dplyr)
#Data Manipulation for Project
#Creating /Calling Database
db<-read.csv("world-happiness-data.csv")
View(db)
#Lets consider data does not have any error
db<-db[,-5]
distinct(db, Region)
#Lets create a new column continent for classification
db$continent<-NA
#Australia
db$continent[which(db$Region%in%c("Australia and New Zealand"))]<-"Australia"
#North America
db$continent[which(db$Region%in%c("North America and New Zealand"))]<-"North America"
#Europe
db$continent[which(db$Region%in%c("Western Europe","Central and Eastern Europe"))]<-"Europe"
#Africa
db$continent[which(db$Region%in%c("Sub-Saharan Africa","Middle East and Northern Africa"))]<-"Africa"
#Asia
db$continent[which(db$Region%in%c("Eastern Asia","Southern Asia","Southeastern Asia"))]<-"Asia"
#South America
db$continent[which(db$Region%in%c("Latin America and Caribbean"))]<-"South America"
#Lets create an average of all the numerical data continent wise
hp<-aggregate(db[,4:11],list(db$continent),mean)
View(hp)
#Data Visualisation part -1
#Data Visualisation for Happiness Report
install.packages("ggplot2")
library (ggplot2)
install.packages("corrgram")
library (corrgram)
install.packages("corrplot")
library (corrplot)
#Lets start with Basics
summary (db)
#Lets graph the mean data of all continents
ggplot(hp,aes(x=Group.1,y=Happiness.Score,fill=Group.1))+geom_bar(stat="identity")+ggtitle("Happiness score of Each Continent")+ylab("Happiness score")+xlab("Continents")
#Lets find out the correlation in variables
col<-sapply(db,is.numeric)
cor.data<-cor(db[,col])
corrplot (cor.data, method='square',type='upper')
corrplot (cor.data, method='number',type='upper')
#Lets create boxplots region wise
box<-ggplot(db,aes(x=Region,y=Happiness.Score, color=Region))
box+geom_boxplot()+geom_jitter(aes(color=Country),size=1.0)+ggtitle ("Happiness score for Region and Countries")+coord_flip()+theme (legend.position="none")
#Box plot for Continents
ggplot (db,aes(x=continent,y=Happiness.Score, color=continent))+geom_boxplot()+ggtitle ("Happiness score for Continents")
#Regression for all Continents

ggplot (db,aes(x=Health..Life.Expectancy.,y=Happiness.Score))+geom_point(aes(color=continent),size=3,alpha=0.8)+geom_smooth(aes(color=continent,fill=continent), method="lm",fullrange=T)+facet_wrap(~continent)+theme_bw()+ggtitle ("scatter plot for life Expectancy ")
#For Economy
ggplot (db,aes(x=Economy..GDP.per.Capita.,y=Happiness.Score))+geom_point(aes(color=continent),size=3,alpha=0.8)+geom_smooth(aes(color=continent,fill=continent), method="lm",fullrange=T)+facet_wrap(~continent)+theme_bw()+ggtitle ("scatter plot for Economy")
#For Freedom
ggplot (db,aes(x=Freedom,y=Happiness.Score))+geom_point(aes(color=continent),size=3,alpha=0.8)+geom_smooth(aes(color=continent,fill=continent), method="lm",fullrange=T)+facet_wrap(~continent)+theme_bw()+ggtitle ("scatter plot for Freedom")

#For Family

ggplot (db,aes(x=Family,y=Happiness.Score))+geom_point(aes(color=continent),size=3,alpha=0.8)+geom_smooth(aes(color=continent,fill=continent), method="lm",fullrange=T)+facet_wrap(~continent)+theme_bw()+ggtitle ("scatter plot for Family")

#For Truest in Government
ggplot (db,aes(x=Trust..Government.Corruption.,y=Happiness.Score))+geom_point(aes(color=continent),size=3,alpha=0.8)+geom_smooth(aes(color=continent,fill=continent), method="lm",fullrange=T)+facet_wrap(~continent)+theme_bw()+ggtitle ("scatter plot for Truest in Government")

#Plots were for the whole Continent
#plot for the most unhappiest places noticed in box plots
box+geom_boxplot()+geom_jitter(aes(color=Country),size=1.0)+ggtitle ("Happiness Score for Region and Countries")+coord_flip()+theme(legend.position="none")
#Data Visualisation part 2
#Sub Saharan Africa is the most unhappiest region
#Classify all of th data based on happiest neutral and less happy region
db$happinessmeter<-NA
db$happinessmeter[which(db$Region %in% c("Australia and New Zealand","Western Europe","North America"))]<-"Happiest"
db$happinessmeter[which(db$Region %in% c("Sub - Saharan Africa"))]<-"Least Happiest"
db$happinessmeter[which(db$Region %in% c("Southern Asia","Middle East and Northern Africa","Latin America and Caribbean","Eastern Asia","Central and Eastern Europe"))]<-"Neutral"
#Plot regression for all three regions
ggplot(db,aes(x=Health..Life.Expectancy.,y=Happiness.Score))+geom_point(aes(color=happinessmeter),size=3,alpha=0.8)+geom_smooth(aes(color=happinessmeter,fill=happinessmeter), method="lm", fullrange=T)+facet_wrap(~happinessmeter)+theme_bw()
#plot for the family
ggplot (db,aes(x=Family,y=Happiness.Score))+geom_point(aes(color=happinessmeter),size=3,alpha=0.8)+geom_smooth(aes(color=happinessmeter,fill=happinessmeter), method="lm", fullrange=T)+facet_wrap(~happinessmeter)+theme_bw()
#plot for Economy
ggplot (db,aes(x=Economy..GDP.per.Capita.,y=Happiness.Score))+geom_point(aes(color=happinessmeter),size=3,alpha=0.8)+geom_smooth(aes(color=happinessmeter,fill=happinessmeter), method="lm", fullrange=T)+facet_wrap(~happinessmeter)+theme_bw()

#plot for Freedom
ggplot (db,aes(x=Freedom,y=Happiness.Score))+geom_point(aes(color=happinessmeter),size=3,alpha=0.8)+geom_smooth(aes(color=happinessmeter,fill=happinessmeter), method="lm", fullrange=T)+facet_wrap(~happinessmeter)+theme_bw()

#plot for Generosity
ggplot (db,aes(x=Generosity,y=Happiness.Score))+geom_point(aes(color=happinessmeter),size=3,alpha=0.8)+geom_smooth(aes(color=happinessmeter,fill=happinessmeter), method="lm", fullrange=T)+facet_wrap(~happinessmeter)+theme_bw()

#plot for Dystopia.Residuals
ggplot (db,aes(x=Dystopia.Residual,y=Happiness.Score))+geom_point(aes(color=happinessmeter),size=3,alpha=0.8)+geom_smooth(aes(color=happinessmeter,fill=happinessmeter), method="lm", fullrange=T)+facet_wrap(~happinessmeter)+theme_bw()

#Plot the GDP and Health Expectancy on World Map
#we will install rworldmap package
installed.packages("rworldmap")
install.packages("rworldmap")
library (rworldmap)
install.packages("sp")
library(sp)
d<-data.frame(Country=db$Country, value=db$Economy..GDP.per.Capita.)
n<-joinCountryData2Map(d,joinCode="NAME",nameJoinColumn="Country")
mapCountryData(n,namecolumnaPlot="value",maptitle="world map for GDP 2015", colourPalette="terrain")
#Map for Health Expectancy
d<-data.frame(country=db$Country, value=db$Health..and.Life.Expectancy.)
n<-joinCountryData2Map (d, joincode="NAME", nameJoincolumn="Country")
mapCountryData (n, namecolumnaPlot="value", maptitle="world map for Health & Life Expectancy", colourPalette="terraia")


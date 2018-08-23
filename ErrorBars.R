library(Hmisc)
point.zero<-as.data.frame(0)
point.zero$MeanNucDiv<-0
colnames(point.zero)<-c("Time","MeanNucDiv")
colnames(Nucmean)<-c("Time","MeanNucDiv")
testing<-rbind(point.zero,testing2)
plot(testing, main = "Grow to 500, u=-7")
points(Fig1_100_500_neg8, col="red", pch=15)
testing2<-Fig1_2_500_neg8[,-c(3:5)]

#Calculating and aggregating Std.Dev and Std.Err
#####


output<-fread("Fig1_2_10000_neg8.txt")#Fread is best read.
stdev<-output[,9]
output<-output[,-c(1:6)]
output<-output[,-c(2:3)]

#output<-output[-c(1:999),]
#stderror<-stderror[-c(1:999),]


output$samplingtimes<-rep(c(50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1050,1100,1150,1200,1250,1300,1350,1400,1450,1500,1550,1600,1650,1700,1750,1800,1850,1900,1950,2000,2050,2100,2150,2200,2250,2300,2350,2400,2450,2500,2550,2600,2650,2700,2750,2800,2850,2900,2950,3000,3050,3100,4100,5100,6100,7100,8100,9100,10100,11100,12100,13100,14100,15100),each=1000)
stdev$samplingtimes<-rep(c(50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1050,1100,1150,1200,1250,1300,1350,1400,1450,1500,1550,1600,1650,1700,1750,1800,1850,1900,1950,2000,2050,2100,2150,2200,2250,2300,2350,2400,2450,2500,2550,2600,2650,2700,2750,2800,2850,2900,2950,3000,3050,3100,4100,5100,6100,7100,8100,9100,10100,11100,12100,13100,14100,15100),each=1000)
colnames(output)<-c("Nucleotide Diversity","Time")
colnames(stdev)<-c("StdDev","Time")

Nucmean<-aggregate(output$`Nucleotide Diversity` ~ output$Time, FUN=mean)
DevMean<-aggregate(stdev$StdDev ~ stdev$Time, FUN=mean)

colnames(Nucmean)<-c("Time","MeanNucDiv")
colnames(DevMean)<-c("Time","StdDev")
DevMean$StdErr<-(DevMean$StdDev/sqrt(1000))
Fig1_2_10k_neg8<-Nucmean
Fig1_2_10k_neg8$StdDev<-ErrMean$StdDev
Fig1_2_10k_neg8$StdErr<-ErrMean$StdErr





testing4<-as.data.frame(0.07639451-Fig1_100_5k_neg5$StdDev)
testing4$max<-0.07639451+Fig1_100_5k_neg5$StdDev

colnames(testing4)<-c("LogMin","LogMax")

testing4$LogMin<-log10(testing4$LogMin)
testing4$LogMax<-log10(testing4$LogMax)


testing3$log.err<-log(testing3)


plot(Fig1_100_500_neg5$Time,Fig1_100_500_neg5$MeanNucDiv)
error_arrows_up<-Fig1_100_500_neg5$MeanNucDiv+DevMean$StdErr
error_arrows_down<-Fig1_100_500_neg5$MeanNucDiv-DevMean$StdErr
errbar(Fig1_100_500_neg5$Time,Fig1_100_500_neg5$MeanNucDiv, yplus=error_arrows_up, yminus=error_arrows_down, col="red", pch=5, errbar.col="red")

#ggplot them error bars
ggplot(Fig1_100_500_neg5, aes(x=Time,y=MeanNucDiv))+
  geom_point()+
  geom_errorbar(aes(ymin=MeanNucDiv-error_arrows_down,ymax=MeanNucDiv+error_arrows_up), width=.1, position="dodge")+
  ggtitle("100_5k_neg5")  
  
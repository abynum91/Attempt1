NQ<-diff(Fig1_100_10k_neg6$MeanNucDiv)/diff(Fig1_100_10k_neg6$Time)
log.NQ <- log(NQ)
low <- lowess(log.NQ)
cutoff <- .25#wHow far apart the vertical lines are.
q <- quantile(low$y, cutoff,na.rm=TRUE) #Be careful here, logging 0 or other small numbers =NA
plot.ts(log.NQ)
abline(h=q)
x.lower <- Fig1_100_10k_neg6$Time[min(which(low$y > q))]#prob better way to do this cutoff
x.upper <- Fig1_100_10k_neg6$Time[max(which(low$y > q))]
plot(Fig1_100_10k_neg6$Time,Fig1_100_10k_neg6$MeanNucDiv, pch=15)

abline(v=c(x.lower, x.upper))


x1y1<-as.data.frame(min((Fig1_100_10k_neg6$LogMeanNucDiv)[Fig1_100_10k_neg6$LogTime>=x.lower]))
x2y2<-as.data.frame(min((Fig1_100_10k_neg6$LogMeanNucDiv)[Fig1_100_10k_neg6$LogTime>=x.upper])) #find the Y-values of the X values we plugged in
x1y1$xval<-x.lower
x2y2$xval<-x.upper
colnames(x1y1)<-c("Yval","Xval")
colnames(x2y2)<-c("Yval","Xval")
y_minus_y<-x1y1$Yval-x2y2$Yval#Calc slope
x_minus_x<-x1y1$Xval-x2y2$Xval
((slope_of_sig<-y_minus_y/x_minus_x))# This gives the slope of the segment we picked. Not sure what this slope means though? Nuc div increases at m per generation?
segments(x1y1$Xval,x1y1$Yval,x2y2$Xval,x2y2$Yval,col="red",lwd=4) #


NQ5<-diff(Fig1_2_10000_neg5$MeanNucDiv)/diff(Fig1_2_10000_neg5$Time)#4E-7 -> 1E-5
NQ6<-diff(Fig1_2_5000_neg5$MeanNucDiv)/diff(Fig1_2_5000_neg5$Time)
NQ7<-diff(Fig1_2_1000_neg5$MeanNucDiv)/diff(Fig1_2_1000_neg5$Time)
NQ8<-diff(Fig1_2_100_neg5$MeanNucDiv)/diff(Fig1_2_100_neg5$Time)#-5E-8 -> 5E-8
NQ9<-diff(Fig1_2_500_neg5$MeanNucDiv)/diff(Fig1_2_500_neg5$Time)




plot(x=log10(Fig1_100_10k_neg5$Time[2:74]), y=NQ5, ylim=c(0, 2E-5))
points(y=NQ6,x=log10(Fig1_100_10k_neg5$Time[2:74]),col="red")
points(y=NQ7,x=log10(Fig1_100_10k_neg5$Time[2:74]),col="blue")
points(y=NQ8,x=log10(Fig1_100_10k_neg5$Time[2:74]),col="green")
points(y=NQ9,x=log10(Fig1_100_10k_neg5$Time[2:74]),col="purple")
#####
plot(diff(Fig1_100_10k_neg6$LogMeanNucDiv))
Fig1_100_10k_neg6$LogMeanNucDiv[ which(abs(diff(Fig1_100_10k_neg6$LogMeanNucDiv))==max(abs(diff(Fig1_100_10k_neg6$LogMeanNucDiv))) )]
# [1] -7.429237
plot(Fig1_100_10k_neg6$LogMeanNucDiv)
abline( v = which(abs(diff(Fig1_100_10k_neg6$LogMeanNucDiv))==max(abs(diff(Fig1_100_10k_neg6$LogMeanNucDiv))) ) )
abline( h = Fig1_100_10k_neg6$LogMeanNucDiv[which(abs(diff(Fig1_100_10k_neg6$LogMeanNucDiv))==max(abs(diff(Fig1_100_10k_neg6$LogMeanNucDiv))) ) ] )
#Time point 62 (3100) -> 4100 has the largest increase/slope
  #Which kinda makes sense since we have 1000 generations of increase.
  #Need to add some sort of weight? Rolling mean?


#Potential fix?
plot(diff(Fig1_100_10k_neg6$LogMeanNucDiv)/diff(Fig1_100_10k_neg6$LogTime))#This plots the differences between every timepoint
#calc std deviations across all points or 
sandbox<-as.data.frame(diff(Fig1_100_10k_neg6$LogMeanNucDiv)/diff(Fig1_100_10k_neg6$LogTime))
sandbox$Index<-1:73
regtest<-lm(sandbox$`diff(Fig1_100_10k_neg6$LogMeanNucDiv)/diff(Fig1_100_10k_neg6$LogTime)`~sandbox$Index,data=sandbox)
plot(sandbox$Index,sandbox$`diff(Fig1_100_10k_neg6$LogMeanNucDiv)/diff(Fig1_100_10k_neg6$LogTime)`)
abline(regtest)
lm_eqn(regtest)
text(5,0, "y=0.67+0.0028x   R^2=.02")#Bad R2
#No longer sure what any of this means.
#The Y is the differences between LogY and LogX. X is just index. So since im using log, Nuc Div increases 0.0028 per log generation ~~ 1.002804
  #No, that doesn't make sense...
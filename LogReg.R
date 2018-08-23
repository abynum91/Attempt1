Fig1_100_5k_neg5$LogTime<-log(Fig1_100_5k_neg5$Time)
Fig1_100_5k_neg5$LogMeanNucDiv<-log(Fig1_100_5k_neg5$MeanNucDiv)
Fig1_100_5k_neg5$LogMeanNucDiv<-Fig1_100_5k_neg5$LogMeanNucDiv+6
plot(Fig1_100_5k_neg7$LogTime,Fig1_100_5k_neg7$MeanNucDiv)
log.reg<-glm((LogMeanNucDiv+0.0001) ~ LogTime, data=Fig1_100_5k_neg5, family="binomial")

log.reg2<-nls(LogMeanNucDiv ~ a+b*exp(c*LogTime-d)/(1+exp(c*LogTime-d)),data=Fig1_100_5k_neg5, start=c(a=-5.5,b=-1,c=1,d=7.5))
plot(Fig1_100_5k_neg5$LogTime,Fig1_100_5k_neg5$LogMeanNucDiv,main="Regression Breaks", xlab="LogTime",ylab="MeanNucDiv")

Newdata=data.frame(LogTime=x.seq)
y.seq<-predict(log.reg2,newdata=Newdata,ratio=x.seq,type="response")
lines(x.seq,y.seq,col="red")
summary(log.reg2)


nls(y~ a+b*exp(cx-d)/1+exp(cx-d)
      
      a= bottom asymptote (ie -6.0 for 100_5k_neg5))
      b= diff between top and bottom asymptote (top is -3, bot is -6, -4--6=3
      d= where we should be halfway from bottom top on the X axis (7.5 ish))
      c= put in 1, then try again with 2, 1.5 If we end up in the same place all 3 times then we gucci. What can go wrong is: it can find siimilar formulas
      
use the predict function to plot ok. 



plot(Fig1_100_500_neg7$LogTime,Fig1_100_500_neg7$MeanNucDiv)

fitcheck<-nls(MeanNucDiv ~ SSlogis(LogTime,Asym,xmid,scal) , data=Fig1_100_500_neg7)
summary(fitcheck)
x.seq<-seq(1.698970,4.178977,.01)
Newdata=data.frame(LogTime=x.seq)
y.seq<-predict(fitcheck,newdata=Newdata,ratio=x.seq,type="response")
lines(x.seq,y.seq,col="red")


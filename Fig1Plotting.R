library(Hmisc)  
  error_arrows_up<-Fig1_2_10000_neg8$MeanNucDiv+Fig1_2_10000_neg8$StdErr
  error_arrows_down<-Fig1_2_10000_neg8$MeanNucDiv-Fig1_2_10000_neg8$StdErr
  Fig1_2_10000_neg8$LogTime<-log10(Fig1_100_10000_neg8$Time)
errbar(Fig1_2_10000_neg8$LogTime,Fig1_2_10000_neg8$MeanNucDiv, yplus=error_arrows_up, yminus=error_arrows_down,main="test",xlab="Log Time", ylab="Mean Nucleotide Diversity",add=FALSE,col="black",errbar.col="black",ylim=c(0,0.00022))
  fitcheck<-nls(MeanNucDiv ~ SSlogis(LogTime,Asym,xmid,scal) , data=Fig1_2_10000_neg8)
  #summary(fitcheck) Only need to run the commented lines if you reset. the numbers from x.seq line are just the min/max of the time values (should all be the same)
  x.seq<-seq(1.698970,4.178977,.01)
  Newdata=data.frame(LogTime=x.seq) #Same as above
  y.seq<-predict(fitcheck,newdata=Newdata,ratio=x.seq,type="response")
  lines(x.seq,y.seq,col="black")  



  error_arrows_up<-Fig1_2_5k_neg8$MeanNucDiv+Fig1_2_5k_neg8$StdErr
  error_arrows_down<-Fig1_2_5k_neg8$MeanNucDiv-Fig1_2_5k_neg8$StdErr
  Fig1_2_5k_neg8$LogTime<-log10(Fig1_100_10000_neg8$Time)
errbar((Fig1_100_10000_neg8$LogTime),Fig1_2_5k_neg8$MeanNucDiv, yplus=error_arrows_up, yminus=error_arrows_down,xlab="Log Time", ylab="Mean Nucleotide Diversity",add=TRUE,col="red",errbar.col="red",ylim=c(0,0.1), pch=18)
  fitcheck<-nls(MeanNucDiv ~ SSlogis(LogTime,Asym,xmid,scal) , data=Fig1_2_5k_neg8)
  y.seq<-predict(fitcheck,newdata=Newdata,ratio=x.seq,type="response")
  lines(x.seq,y.seq,col="red")  


  error_arrows_up<-Fig1_2_1k_neg8$MeanNucDiv+Fig1_2_1k_neg8$StdErr
  error_arrows_down<-Fig1_2_1k_neg8$MeanNucDiv-Fig1_2_1k_neg8$StdErr
  Fig1_2_1k_neg8$LogTime<-log10(Fig1_100_10000_neg8$Time)
errbar((Fig1_100_10000_neg8$LogTime),Fig1_2_1k_neg8$MeanNucDiv, yplus=error_arrows_up, yminus=error_arrows_down,xlab="Log Time", ylab="Mean Nucleotide Diversity",add=TRUE,col="blue",errbar.col="blue",ylim=c(0,0.1), pch=17)
   fitcheck<-nls(MeanNucDiv ~ SSlogis(LogTime,Asym,xmid,scal) , data=Fig1_2_1k_neg8)
  y.seq<-predict(fitcheck,newdata=Newdata,ratio=x.seq,type="response")
  lines(x.seq,y.seq,col="blue")    

  error_arrows_up<-Fig1_2_500_neg8$MeanNucDiv+Fig1_2_500_neg8$StdErr
  error_arrows_down<-Fig1_2_500_neg8$MeanNucDiv-Fig1_2_500_neg8$StdErr
  Fig1_2_500_neg8$LogTime<-log10(Fig1_100_10000_neg8$Time)
errbar((Fig1_100_10000_neg8$LogTime),Fig1_2_500_neg8$MeanNucDiv, yplus=error_arrows_up, yminus=error_arrows_down,xlab="Log Time", ylab="Mean Nucleotide Diversity",add=TRUE,col="green",errbar.col="green",ylim=c(0,0.1), pch=15)
  fitcheck<-nls(MeanNucDiv ~ SSlogis(LogTime,Asym,xmid,scal) , data=Fig1_2_500_neg8)
  y.seq<-predict(fitcheck,newdata=Newdata,ratio=x.seq,type="response")
  lines(x.seq,y.seq,col="green")  
  
  error_arrows_up<-Fig1_2_100_neg8$MeanNucDiv+Fig1_2_100_neg8$StdErr
  error_arrows_down<-Fig1_2_100_neg8$MeanNucDiv-Fig1_2_100_neg8$StdErr
  Fig1_2_100_neg8$LogTime<-log10(Fig1_100_10000_neg8$Time)
  errbar((Fig1_100_10000_neg8$LogTime),Fig1_2_100_neg8$MeanNucDiv, yplus=error_arrows_up, yminus=error_arrows_down,xlab="Log Time", ylab="Mean Nucleotide Diversity",add=TRUE,col="gold",errbar.col="gold",ylim=c(0,0.1), pch=8)
  fitcheck<-nls(MeanNucDiv ~ SSlogis(LogTime,Asym,xmid,scal) , data=Fig1_2_100_neg8)
  y.seq<-predict(fitcheck,newdata=Newdata,ratio=x.seq,type="response")
  lines(x.seq,y.seq,col="gold")  
  
legend("topleft",c("10000","5000","1000","500","100"),pch=c(19,18,17,15,8),col=c("black","red","blue","green","gold"),title=expression(paste(mu,"=10^-8")))
title(main="Increase of Nucleotide Diversity from 2 Individuals")


#False for first run, True for everything after
#Purple = !5k pch=8
#red = !5k and pch=15
#Green = !1k pch=17
#prupple = !500 pch = 8


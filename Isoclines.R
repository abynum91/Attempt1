#Isocline pseudo:
# When Y = .1, get X for each points
#The below line looks through time points to find where the mean nuc div is greater than whatever we put (ie .1). The output is the specific date
min((Fig1_2_1000_neg4$Time)[Fig1_2_1000_neg4$MeanNucDiv>.1])

#Following lines make a list of the datasets (ie for a mut rate of neg4)
#Then creates a function that looks for  a mean nuc div of .1
#Then sends each dataframe through. Results of inf mean it never reaches. 

neg8_list<-list(Fig1_2_100_neg8,Fig1_2_500_neg8,Fig1_2_1000_neg8,Fig1_2_5000_neg8,Fig1_2_10000_neg8)

isocline_mk1<-function(dataframe,Ylimit){
  min((dataframe$Time)[dataframe$MeanNucDiv>Ylimit])
  
}

for (i in (c(0.00001,0.00002,0.00003,0.00004,0.00005))){
  final.size<-c(100,500,1000,5000,10000)
  
  #assign(paste0("isocline_neg5_nucdiv_", i),ldply(neg5_list,isocline_mk1,i),final.size)
  filename<-paste0("isocline_neg8_nucdiv_",i)
  final.df=data.frame(final.size,ldply(neg8_list,isocline_mk1,i))
  assign(filename,final.df)
}

plot(`isocline_neg5_nucdiv_1e-05`,ylim=c(0,15100),pch=19,main="Isoclines for 1E-8 Mutation Rate",xlab="Final Population Size",ylab="Time (in generations")
points(`isocline_neg5_nucdiv_2e-05`,pch=18,col="red")
points(`isocline_neg5_nucdiv_3e-05`,pch=17,col="blue")
points(`isocline_neg5_nucdiv_4e-05`,pch=15,col="green")
points(`isocline_neg5_nucdiv_5e-05`,pch=8,col="purple")
lines(`isocline_neg5_nucdiv_1e-05`,ylim=c(0,15100),pch=19,main="Isoclines for 1E-8 Mutation Rate",xlab="Final Population Size",ylab="Time (in generations")
lines(`isocline_neg5_nucdiv_2e-05`,pch=18,col="red")
lines(`isocline_neg5_nucdiv_3e-05`,pch=17,col="blue")
lines(`isocline_neg5_nucdiv_4e-05`,pch=15,col="green")
lines(`isocline_neg5_nucdiv_5e-05`,pch=8,col="purple")
legend("topright",c("0.01","0.02","0.03","0.04","0.06"),pch=c(19,18,17,15,8),col=c("black","red","blue","green","purple"),title="Mean Nucleotide Diversity")

#Next step;
#Range from nuc div of 0->.1 (or whatever) and step by .001 (or whatever). 
#Loop  it all
#Where I need help:
#1) making it loop?
  #for i in seq(0,0.01, 0.0001){
  #nvm its easy
  #Then we get a nice curve or line or whatever
#2) 
testlist<-vector("list",50)
for (i in (seq(0,5E-5,1E-6))){
  final.size<-c(100,500,1000,5000,10000)
  
  #assign(paste0("isocline_neg5_nucdiv_", i),ldply(neg5_list,isocline_mk1,i),final.size)
  filename<-paste0("isocline_neg8_nucdiv_",i)
  final.df=data.frame(final.size,ldply(neg8_list,isocline_mk1,i))
  assign(filename,final.df)
  #testlist[[1,2,3,4,etc]]<-
  }
#Next: Add a regression line? Is it worth it?
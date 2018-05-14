#setting my working directory
setwd("/Users/user/datasciencecoursera")

#using SQLDF package to help pull only required data
library(sqldf)
library(chron)

#creating data frame that keeps data for only Feb.1-Feb. 2 2007
DF2<-read.csv2.sql("./data/household_power_consumption.txt", 
                   sql = "select * from file where Date in('1/2/2007','2/2/2007')
                   ", eol = "\n")

#combining day and times into one chron variable
thetimes = chron(dates=DF2$Date,times=DF2$Time,
                 format=c("d/m/y","h:m:s"))

#creating chron variables that contain date and time for Thu-Sat.
#that will be used for the tick marks 
tick_marks<-c("01/02/07","02/02/07","03/02/07")
tick_marks2<-c("00:00:00","00:00:00","00:00:00")
ticks<-chron(dates = tick_marks,times = tick_marks2,format=c("d/m/y","h:m:s"))

#opening file device
png(filename = "plot2.png",width = 480, height = 480, bg = "white",  type = "quartz")

#plotting time vs Global active power without x-axis
plot(thetimes,DF2$Global_active_power,type="l",   
     xaxt = "n", xlab="", ylab = "Global Active Power (kW)")

#adding x-axis
axis(side = 1, at = ticks, labels = c("Thu", "Fri","Sat"), lwd.ticks=1)

#copying plot to file
dev.copy(png,file="plot2.png")

#closing device
dev.off()
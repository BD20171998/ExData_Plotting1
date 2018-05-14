#setting my working directory
setwd("/Users/user/datasciencecoursera")

#using "SQLDF" and "CHRON" libraries to help pull data
#and be able to work with chron variables
library(sqldf)
library(chron)

#creating data frame that keeps data for only Feb.1-Feb. 2 2007
DF2<-read.csv2.sql("./data/household_power_consumption.txt", 
                   sql = "select * from file where Date in('1/2/2007','2/2/2007')
                   ", eol = "\n")

#combining day and times into a chron variable
thetimes = chron(dates=DF2$Date,times=DF2$Time,
                 format=c("d/m/y","h:m:s"))

#creating chron variables that contain date and time for Thu-Sat.
#that will be used for the tick marks 
tick_marks<-c("01/02/07","02/02/07","03/02/07")
tick_marks2<-c("00:00:00","00:00:00","00:00:00")
ticks<-chron(dates = tick_marks,times = tick_marks2,format=c("d/m/y","h:m:s"))

#opening file device
png(filename = "plot4.png",width = 480, height = 480, bg = "white",  type = "quartz")

#adjusting margins and text sizes
par(mfcol=c(2,2))
par(mar=c(4,6,0.75,5))
par(cex=0.70)

#plot 1 
plot(thetimes,DF2$Global_active_power,type="l",   
     xaxt = "n", xlab="", ylab = "Global Active Power (kW)")
axis(side = 1, at = ticks, labels = c("Thu", "Fri","Sat"), lwd.ticks=1)

#plot 2
plot(thetimes,DF2$Sub_metering_1,type="l",   
     xaxt = "n", xlab="", ylab = "Energy sub metering",
     col="green")
lines(thetimes,DF2$Sub_metering_2,type="l",col="red")
lines(thetimes,DF2$Sub_metering_3,type="l",col="blue")
axis(side = 1, at = ticks, labels = c("Thu", "Fri","Sat"), lwd.ticks=1)
legend("topright",bty="n",col=c("green","red","blue"), pch="-",legend= c("Sub metering 1","Sub metering 2","Sub metering 3"))

#plot 3
plot(thetimes,DF2$Voltage,type="l",   
     xaxt = "n",xlab="Datetime", ylab = "Voltage")
axis(side = 1, at = ticks,  labels = c("Thu", "Fri","Sat"), lwd.ticks=1)

#plot 4
plot(thetimes,DF2$Global_reactive_power,type="l",   
     xaxt = "n", xlab="Datetime", ylab = "Global Reactive Power")
axis(side = 1, at = ticks, labels = c("Thu", "Fri","Sat"), lwd.ticks=1)

#copy image to file
dev.copy(png,file="plot4.png")

#close file device
dev.off()
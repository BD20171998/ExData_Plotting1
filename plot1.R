#setting my working directory
setwd("/Users/user/datasciencecoursera")

#using SQLDF package to help pull only required data
library(sqldf)

#creating data frame that keeps data for only Feb.1-Feb. 2 2007
DF2<-read.csv2.sql("./data/household_power_consumption.txt", 
             sql = "select * from file where Date in('1/2/2007','2/2/2007')
             ", eol = "\n")

#opening file device
png(filename = "plot1.png",width = 480, height = 480, bg = "white",  type = "quartz")

#creating histogram plot
hist(DF2$Global_active_power,col = "red", main="Global Active Power", xlab = "Global Active Power (kW)")

#copying plot to file
dev.copy(png,file="plot1.png")

#closing device
dev.off()
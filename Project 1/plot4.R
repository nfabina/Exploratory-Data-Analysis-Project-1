setwd("C:/Users/manif/Desktop/Coursera/exdata%2Fdata%2Fhousehold_power_consumption")
data<- read.csv("household_power_consumption.txt", header = T, sep = ';', na.strings = "?", nrows = 2075259, check.names = F, stringsAsFactors = F, comment.char = "", quote = '\"')
data$Date <- as.Date(data$Date, "%d/%m/%Y")
filter <- subset(data, subset = (Date >= "2007-2-1" & Date <= "2007-2-2"))
rm(data)
dateTime <- paste(as.Date(filter$Date), filter$Time)
dateTime <- setNames(dateTime, "DateTime")
filter <- cbind(dateTime, filter)
filter$dateTime <- as.POSIXct(dateTime)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(filter, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  par(cex = 0.75)
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
         legend=c(legend = "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
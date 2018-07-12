library(dplyr)
rawData <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")
DateTime <- strptime(paste(rawData$Date, rawData$Time), format="%Y-%m-%d %H:%M:%S")
rawData$DateTime <- as.POSIXct(DateTime)

ourData <- rawData  %>% select(Date:DateTime) %>% filter(Date > "2007-01-31" & Date < "2007-02-03")
rm("rawData")
ourData$Sub_metering_1 <- as.numeric(as.character(ourData$Sub_metering_1))
ourData$Sub_metering_2 <- as.numeric(as.character(ourData$Sub_metering_2))
ourData$Sub_metering_3 <- as.numeric(as.character(ourData$Sub_metering_3))




png(file="plot3.png",width=480,height=480)
with(ourData, {
  plot(Sub_metering_1~DateTime, type = "l", ylab = "Energy Sub Metering", xlab = "")
  lines(Sub_metering_2~DateTime, col = "red")
  lines(Sub_metering_3~DateTime, col = "blue")
})

legend("topright", col = c("black", "red","blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

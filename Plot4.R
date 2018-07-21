library(dplyr)
rawData <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")
DateTime <- strptime(paste(rawData$Date, rawData$Time), format="%Y-%m-%d %H:%M:%S")
rawData$DateTime <- as.POSIXct(DateTime)

ourData <- rawData  %>% select(Date:DateTime) %>% filter(Date == "2007-02-01" | Date == "2007-02-02")
rm("rawData")
ourData$Sub_metering_1 <- as.numeric(as.character(ourData$Sub_metering_1))
ourData$Sub_metering_2 <- as.numeric(as.character(ourData$Sub_metering_2))
ourData$Sub_metering_3 <- as.numeric(as.character(ourData$Sub_metering_3))
ourData$Global_active_power <- as.numeric(as.character(ourData$Global_active_power))
ourData$Voltage <- as.numeric(as.character(ourData$Voltage))
ourData$Global_reactive_power <- as.numeric(as.character(ourData$Global_reactive_power))



png(file = "plot4.png", width = 480,height = 480)
par(mfrow = c(2, 2), mar=c(5, 4, 2, 1), oma= c(0, 0, 2, 0))
with(ourData, {
  plot(Global_active_power~DateTime,
       ylab = "Global Active Power", xlab = "", type = "l")
  plot(Voltage~DateTime,
       ylab = "Voltage", xlab = "Datetime", type = "l")
  plot(Sub_metering_1~DateTime, type = "l",
       ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2~DateTime, type = "l",
        col = "red")
  lines(Sub_metering_3~DateTime, type = "l",
        col = "blue")
  legend("topright", col = c("black","red", "blue"),lty = 1,lwd = 2, bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime,type="l",
       ylab = "Global_reactive_power", xlab = "Datetime")
})

dev.off()
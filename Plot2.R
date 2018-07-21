library(dplyr)
rawData <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")
DateTime <- strptime(paste(rawData$Date, rawData$Time), format="%Y-%m-%d %H:%M:%S")
rawData$DateTime <- as.POSIXct(DateTime)

ourData <- rawData  %>% select(Date:DateTime) %>% filter(Date == "2007-02-01" | Date == "2007-02-02")
rm("rawData")
ourData$Global_active_power <- as.numeric(as.character(ourData$Global_active_power))

x <- ourData$DateTime
y <- ourData$Global_active_power

png(file="plot2.png",width=480,height=480)
plot(x, y, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

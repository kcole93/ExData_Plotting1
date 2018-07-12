library(dplyr)

rawData <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")
DateTime <- strptime(paste(rawData$Date, rawData$Time), format="%Y-%m-%d %H:%M:%S")
rawData$DateTime <- as.POSIXct(DateTime)

ourData <- rawData  %>% select(Date:DateTime) %>% filter(Date > "2007-01-31" & Date < "2007-02-03")
rm("rawData")
ourData$Global_active_power <- as.numeric(as.character(ourData$Global_active_power))



hist(ourData$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "Plot1.png", width = 480, height = 480)
dev.off()

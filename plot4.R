## Getting full dataset
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?",  quote='\"')


## Subsetting the data
SetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
#View(SetData)
#write.table(SetData, "SubSet.txt")
SetData$Date <- as.Date(SetData$Date, format="%d/%m/%Y") #converting dates


#convert & combining date and time columns
datetime <- paste(as.Date(SetData$Date), SetData$Time)
SetData$Datetime <- as.POSIXct(datetime)

globalActivePower <- as.numeric(SetData$Global_active_power)


png("plot4.png", width=480, height=480)
par(bg="white", ps=12,mfcol=c(2,2))

#graph 1 : top left
plot(SetData$Datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power")
#graph 2 : bottom left
with(SetData, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

#graph 3 top right
plot(SetData$Datetime, SetData$Voltage,  type="l", ylab="Voltage ", xlab="datetime")

#graph 4 : bottom right
plot(SetData$Datetime, SetData$Global_reactive_power, type="l", ylab="Global_reactive_power",xlab="datetime")

dev.off()

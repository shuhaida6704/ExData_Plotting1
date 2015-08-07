## Getting full dataset

data <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?",  quote='\"')


## Subsetting the data
SetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
SetData$Date <- as.Date(SetData$Date, format="%d/%m/%Y") #converting dates


#convert & combining date and time columns
datetime <- paste(as.Date(SetData$Date), SetData$Time)
SetData$Datetime <- as.POSIXct(datetime)

globalActivePower <- as.numeric(SetData$Global_active_power)
png("plot2.png", width=480, height=480)
plot(SetData$Datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

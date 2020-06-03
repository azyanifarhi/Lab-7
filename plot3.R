dt<- read.delim("C:/Users/user/Documents/Data/household_power_consumption 2.txt", header = TRUE, sep = ";", dec = ".",
                na.strings="?", colClass = c('character', 'character', 'numeric', 'numeric','numeric', 'numeric',
                                             'numeric', 'numeric', 'numeric'))

#formatting the date
dt$Date <- as.Date(dt$Date, "%d/%m/%Y")

#select data 
dt <- subset(dt, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
dt <- dt[complete.cases(dt),]

#Converting dates
dateTime <- paste(dt$Date, dt$Time)
dt$dateTime <- as.POSIXct(dateTime)

#plot the graph with legends
with(dt, {
  plot(Sub_metering_1 ~ dateTime, type="l", ylab = "Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ dateTime, col='Red')
  lines(Sub_metering_3 ~ dateTime, col='Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
                           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.75)

#Output histogram to PNG
dev.copy(png, file="plot3.png", height = 480, width = 480)
dev.off()


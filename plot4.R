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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dt, {
  plot(Global_active_power~dateTime, type="l", ylab="Global Active Power", xlab="")
  plot(Voltage ~ dateTime, type="l", ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1 ~ dateTime, type = "l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ dateTime, col = 'Red')
  lines(Sub_metering_3 ~ dateTime,col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.75)
  plot(Global_reactive_power~dateTime, type="l", ylab="Global_Rective_Power",xlab="datetime")
})

#Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


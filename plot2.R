dt<- read.delim("C:/Users/user/Documents/Data/household_power_consumption 2.txt", header = TRUE, sep = ";", dec = ".",
                na.strings="?", colClass = c('character', 'character', 'numeric', 'numeric',
                                             'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))

#formatting the date
dt$Date <- as.Date(dt$Date, "%d/%m/%Y")

#select data 
dt <- subset(dt, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
dt <- dt[complete.cases(dt),]

#Converting dates
dateTime <- paste(dt$Date, dt$Time)
dt$dateTime <- as.POSIXct(dateTime)

#output histogram to PNG
plot(dt$Global_active_power~dt$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height = 480, width = 480)
dev.off()



mywd=getwd()
myfl<-"household_power_consumption.txt"
#Assuming the data file is in your working directory
myfl <-paste(mywd,'/',myfl, sep='')
pwr <- read.table(myfl, sep=";", header=T, colClasses =  c("character", "character","character","character","character","character","character","character","numeric"))

#converting to numeric
pwr$Sub_metering_2 <- as.numeric(pwr$Sub_metering_2)
pwr$Sub_metering_1 <- as.numeric(pwr$Sub_metering_1)
pwr$Global_intensity <- as.numeric(pwr$Global_intensity)
pwr$Voltage <- as.numeric(pwr$Voltage)
pwr$Global_reactive_power <- as.numeric(pwr$Global_reactive_power)
pwr$Global_active_power <- as.numeric(pwr$Global_active_power)

#filter for the dates we need
pwr <- subset(pwr, as.Date(Date, format="%d/%m/%Y")=="2007-02-01" | as.Date(Date, format="%d/%m/%Y")== "2007-02-02")

# Now merge Date and Time into a new variable of type POSIXlt -> DateTime
datim<-paste(as.character(pwr$Date),',',as.character(pwr$Time), sep='')
datim<-strptime( datim, format="%d/%m/%Y,%H:%M:%S" )
pwr$datim <- datim

#plotting
par(mfrow = c(2, 2))
plot(pwr$datim, pwr$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
plot(pwr$datim, pwr$Voltage ,  xlab="datetime", ylab="Voltage", type="l")
plot(pwr$datim, pwr$Sub_metering_1 ,  xlab="", ylab="Energy Sub metering", type="l")
points(pwr$datim, pwr$Sub_metering_2 , type="l", col="red")
points(pwr$datim, pwr$Sub_metering_3 , type="l", col="blue")
legend("topright", lwd = 1, col = c("black", "blue", "red"), cex=0.6, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(pwr$datim, pwr$Global_reactive_power ,  xlab="datetime", ylab="Global Reactive Power", type="l")
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

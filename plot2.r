
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
plot(pwr$datim, pwr$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

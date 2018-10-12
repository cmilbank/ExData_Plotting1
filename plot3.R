#Download and read file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
power <- read.table(unzip(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)

#Subset data to 2/1/2007 and 2/2/2007

power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

#Update variable formats

power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Global_reactive_power <- as.numeric(as.character(power$Global_reactive_power))

#Format date variable and create weekday

power$datenew <- as.Date(power$Date, "%d/%m/%Y")
power$datetime <- as.POSIXct(paste(power$datenew, power$Time))
power$weekday <- weekdays(power$datetime)

#Open graphics device and create graph

png("plot3.png", width = 480, height = 480)

plot(power$datetime, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close graphics device

dev.off()
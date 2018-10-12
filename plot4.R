#Download and read file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
power <- read.table(unzip(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)

#Subset data to 2/1/2007 and 2/2/2007

power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

#Update variable formats

power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Global_reactive_power <- as.numeric(as.character(power$Global_reactive_power))

#Format date variable and create weekday

power$datenew <- as.Date(power$Date, "%d/%m/%Y")
power$datetime <- as.POSIXct(paste(power$datenew, power$Time))
power$weekday <- weekdays(power$datetime)

#Open graphics device and create graph

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
plot(power$datetime, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(power$datetime, power$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(power$datetime, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .75)
plot(power$datetime, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#Close graphics device

dev.off()
#Download and read file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
power <- read.table(unzip(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)

#Subset data to 2/1/2007 and 2/2/2007

power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

#Update variable formats

power$Global_active_power <- as.numeric(as.character(power$Global_active_power))

#Format date variable and create weekday

power$datenew <- as.Date(power$Date, "%d/%m/%Y")
power$datetime <- as.POSIXct(paste(power$datenew, power$Time))
power$weekday <- weekdays(power$datetime)

#Open graphics device and create graph

png("plot2.png", width = 480, height = 480)

plot(power$datetime, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#Close graphics device

dev.off()
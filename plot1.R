#Download and read file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
power <- read.table(unzip(temp, "household_power_consumption.txt"), sep = ";", header = TRUE)

#Subset data to 2/1/2007 and 2/2/2007

power <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

#Update variable formats

power$Global_active_power <- as.numeric(as.character(power$Global_active_power))

#Open graphics device and create graph

png("plot1.png", width = 480, height = 480)

hist(as.numeric(power$Global_active_power), col = "red", xlab = "Global Active Power
     (kilowatts)", ylab = "Frequency", main = "Global Active Power")

#Close graphics device

dev.off()
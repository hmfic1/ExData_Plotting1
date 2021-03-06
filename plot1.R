##    Exploratory Data Analysis - Week 1 - plot1.R

library(lubridate)

##    To start off clean, delete any previous files and directories

if(file.exists("plot1.png")) {
  file.remove("plot1.png")
}
if(file.exists("household_power_consumption.txt")) {
  file.remove("household_power_consumption.txt")
}

if(file.exists("PowerConsumption.zip")) {
  file.remove("PowerConsumption.zip")
}

##    download and unzip data files

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "PowerConsumption.zip")
unzip("PowerConsumption.zip")

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = "character")
dTP <- subset(data, Date == "2/2/2007" | Date == "1/2/2007")
rm(data)
dTP[dTP == "?" ] = NA

dTP$Global_active_power <- as.numeric(dTP$Global_active_power)
dTP$Global_reactive_power <- as.numeric(dTP$Global_reactive_power)
dTP$Voltage <- as.numeric(dTP$Voltage)
dTP$Global_intensity <- as.numeric(dTP$Global_intensity)
dTP$Sub_metering_1 <- as.numeric(dTP$Sub_metering_1)
dTP$Sub_metering_2 <- as.numeric(dTP$Sub_metering_2)
dTP$Sub_metering_3 <- as.numeric(dTP$Sub_metering_3)

x <- paste(dTP$Date, dTP$Time)
y <- dmy_hms(x)

png(filename = "plot1.png", width = 480, height = 480, units = "px")

par(mfrow = c(1, 1))
hist(dTP$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()


##    Exploratory Data Analysis - Week 1 - plot4.R

library(lubridate)

##    remove this before saving final version
setwd("~/School/R Programming/Coursera - Data Scientist/4 - Exploratory Data Analysis/Week 1/Project Data")

##    To start off clean, delete any previous files and directories

if(file.exists("plot4.png")) {
  file.remove("plot4.png")
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

##    change device

png(filename = "plot4.png", width = 480, height = 480, units = "px")

##    set cols, rows, margin and outside margin

par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(2, 1 , 2, 0))

##     first plot

plot(y, dTP$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
lines(y, dTP$Global_active_power, type = "l")

##     second plot

plot(y, dTP$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(y, dTP$Sub_metering_1, type = "l", col = "black")
lines(y, dTP$Sub_metering_2, type = "l", col = "red")
lines(y, dTP$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1), bty = "n")

##     third plot

plot(y, dTP$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(y, dTP$Voltage, type = "l")

##     fourth plot

plot(y, dTP$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(y, dTP$Global_reactive_power, type = "l")

dev.off()

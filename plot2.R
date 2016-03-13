##    Exploratory Data Analysis - Week 1 - plot2.R

library(lubridate)

##    remove this before saving final version
setwd("~/School/R Programming/Coursera - Data Scientist/4 - Exploratory Data Analysis/Week 1/Project Data")

##    To start off clean, delete any previous files and directories

if(file.exists("plot2.png")) {
  file.remove("plot2.png")
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

png(filename = "plot2.png", width = 480, height = 480, units = "px")

par(mfrow = c(1, 1))
plot(y, dTP$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(y, dTP$Global_active_power, type = "l")

dev.off()

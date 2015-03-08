## This code is for Plot 4 of project 1 
## for the Coursera course "Exploratory Data Analysis"
## Date: March 8, 201
## Author: Carl Steyn

## The code reads the data, dose some data cleaning and then saves a PNG file
## which replicates a given plot as indicated in the forked repo
## The file is stored as plot4.png

## The code first checks if the file exists in your working directory.
## If it does not exist in the working directory - 
## it downloads it into the working directory.
if(!file.exists("household_power_consumption.txt")) {
        fileurl <- 
"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileurl, 
                      destfile="household_power_consumption.zip", 
                      method="curl")
        unzip("household_power_consumption.zip")
}

## Read into R
alldata <- read.table("household_power_consumption.txt", 
                      sep=";", 
                      header=T, 
                      colClasses=c(rep("character", 2), rep("numeric", 7)), 
                      na.strings="?")

## Change the "Date" variable formate
alldata$Date <- as.Date(alldata$Date, format="%d/%m/%Y")

## Subset the data and removes "alldata" from the workspace
subdata <- alldata[alldata$Date=="2007-02-01" | alldata$Date=="2007-02-02", ]
rm(alldata)

## Create "DateTime" variable. and reformate to date
subdata$DateTime <- paste(subdata$Date, subdata$Time)
subdata$DateTime <- strptime(subdata$DateTime, format ="%Y-%m-%d %H:%M:%S")

## Start a PNG device and plots the  4 graphs seperately
png("plot4.png", width=480, height=480)
## set rows and columns
par(mfrow=c(2,2))
par(bg = "aliceblue")

## First plot is the Global_active_power over time
plot(subdata$DateTime, subdata$Global_active_power, 
     xlab = "", 
     ylab = "Global Active Power",
     type = "l")

## Second plot (first row second column) is the Voltage over time
plot(subdata$DateTime, subdata$Voltage, type="l",
     xlab="datetime", ylab="Voltage", lwd=1)

## The third plot (second row first column) is the sub_metering plot from plot3
plot(subdata$DateTime, subdata$Sub_metering_1, type="n", lwd=1, 
     ylim=c(0, max(c(subdata$Sub_metering_1, 
                     subdata$Sub_metering_2, 
                     subdata$Sub_metering_3))),
     xlab="", ylab="Energy sub metering")

lines(subdata$DateTime, subdata$Sub_metering_1, col="black")
lines(subdata$DateTime, subdata$Sub_metering_2, col="red")
lines(subdata$DateTime, subdata$Sub_metering_3, col="blue")

legend("topright", lwd=1, 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## The last plot is the Global_reactive_power over time
plot(subdata$DateTime, subdata$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power", lwd=1)

dev.off()

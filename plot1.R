## This code is for Plot 1 of project 1 
## for the Coursera course "Exploratory Data Analysis"
## Date: March 8, 201
## Author: Carl Steyn

## The code reads the data, dose some data cleaning and then saves a PNG file
## which replicates a given plot as indicated in the forked repo
## The file is stored as plot1.png

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

## Start a PNG device and plots the histogram of global_active_power
png("plot1.png", width=480, height=480)
par(bg = "aliceblue")
hist(subdata$Global_active_power, 
     breaks=12, 
     col="red1", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")
dev.off()

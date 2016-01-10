# plot2.R
# Created: 1/9/2016
# -----------------------------------------------------------------------------
#  Purpose: For completion of Coursera Class
#           Exploratory Data Analysis
#  Objective:
#   1) read in 20MB file household_power_consumption.txt
#   2) Create line chart of Global Active Power (kilowatts) vs. time
#      png File: Width of 480px and Height 480px.
# -----------------------------------------------------------------------------
# Input File: household_power_consumption.txt
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#                 It corresponds to the kitchen, containing mainly a dishwasher, an oven and a 
#                 microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#                 It corresponds to the laundry room, containing a washing-machine, a tumble-drier, 
#                 a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#                 It corresponds to an electric water-heater and an air-conditioner.
# -----------------------------------------------------------------------------
# Additional Notes:
#  - The dataset has 2,075,259 rows and 9 columns.
#  - We will only be using data from the dates 2007-02-01 and 2007-02-02.
#  - missing values are coded as ?

# Read Input File
library(data.table)
inFile <- "household_power_consumption.txt"
DT<-fread(inFile, sep=";", na.strings = "?")

#add datetime column
DT$DATETIME<-as.POSIXct(paste(DT$Date, DT$Time), format="%d/%m/%Y %H:%M:%S")

# Convert Date Column to Date Type only if sorting is desired
DT$Date<-as.Date(DT$Date, "%d/%m/%Y")

DT<-DT[DT$Date %in% c(as.Date("2007-02-01", format = "%Y-%m-%d"),as.Date("2007-02-02", format = "%Y-%m-%d")),]

#plot
png("plot2.png")
plot(DT$DATETIME,DT$Global_active_power, type="n", ylab = "Global Active Power (kilowatts)",xlab ="")
lines(DT$DATETIME,DT$Global_active_power)
dev.off()

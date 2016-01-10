# plot4.R
# Created: 1/9/2016
# -----------------------------------------------------------------------------
#  Purpose: For completion of Coursera Class
#           Exploratory Data Analysis
#  Objective:
#   1) read in 20MB file household_power_consumption.txt
#   2) Create multi-plot view
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
png("plot4.png")
par(mfcol=c(2,2))
# First plot

plot(DT$DATETIME,DT$Global_active_power, type="n", ylab = "Global Active Power (kilowatts)",xlab ="")
lines(DT$DATETIME,DT$Global_active_power)

# second plot
plot(DT$DATETIME,DT$Sub_metering_1, type="n", ylab = "Energy sub metering",xlab ="")
lines(DT$DATETIME,DT$Sub_metering_1)
lines(DT$DATETIME,DT$Sub_metering_2, col="red")
lines(DT$DATETIME,DT$Sub_metering_3, col="blue")
legend("topright",bty="n", lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))

#third plot
plot(DT$DATETIME,DT$Voltage,xlab="datetime",ylab="Voltage",type="n")
lines(DT$DATETIME,DT$Voltage)

#fourth plot
plot(DT$DATETIME,DT$Global_reactive_power,type="n",ylab="Global_reactive_power",xlab="datetime")
lines(DT$DATETIME,DT$Global_reactive_power)

dev.off()


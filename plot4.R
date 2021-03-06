library(data.table)

## Convert the dates needed for subsetting into R Date/Time class
datesToRead <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"), units = "mins")
rowsToRead <- as.numeric(datesToRead)

## Read the data for the dates provided 
householdDT <- fread(input = "household_power_consumption.txt", sep = ";", 
                     skip = "1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))

## Set the column names for the datatable created above (householdDT)
setnames(householdDT, make.names(colnames(fread("household_power_consumption.txt", 
                                                sep = ";", nrows = 1, header = T))))

## Format the date/time to match the days on the x-axis
dateTimeXAxisTest <- strptime(paste(householdDT$Date, householdDT$Time), 
                              format = "%d/%m/%Y %H:%M:%S")

## send the plot to a png gaphic device
png("./plot4.png", width = 480, height = 480)

## Split the device into a 2x2 matric to plot the 4 graphs
par(mfrow = c(2, 2))

## Plot the graphs, add colors and legends where needed
plot(dateTimeXAxisTest <- strptime(paste(householdDT$Date, householdDT$Time), 
                                   format = "%d/%m/%Y %H:%M:%S"), 
     householdDT$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
##########################################################################
plot(dateTimeXAxisTest <- strptime(paste(householdDT$Date, householdDT$Time), 
                                   format = "%d/%m/%Y %H:%M:%S"), 
     householdDT$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
##########################################################################
plot(dateTimeXAxisTest <- strptime(x = paste(householdDT$Date, householdDT$Time), 
                                   format = "%d/%m/%Y %H:%M:%S"), 
     householdDT$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
##########################################################################
lines(dateTimeXAxisTest <- strptime(x = paste(householdDT$Date, householdDT$Time), 
                                    format = "%d/%m/%Y %H:%M:%S"), 
      householdDT$Sub_metering_2, col = "red")
##########################################################################
lines(dateTimeXAxisTest <- strptime(x = paste(householdDT$Date, householdDT$Time), 
                                    format = "%d/%m/%Y %H:%M:%S"), 
      householdDT$Sub_metering_3, col = "blue")
##########################################################################
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")
##########################################################################
plot(dateTimeXAxisTest <- strptime(x = paste(householdDT$Date, householdDT$Time), 
                                   format = "%d/%m/%Y %H:%M:%S"), 
     householdDT$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
##########################################################################

## Shutdown the graphic device
dev.off()

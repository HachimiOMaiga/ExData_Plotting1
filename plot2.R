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
png("./plot2.png", width = 480, height = 480)

## Plot the graph
plot(dateTimeXAxisTest <- strptime(paste(householdDT$Date, householdDT$Time), 
                                   format = "%d/%m/%Y %H:%M:%S"), 
     householdDT$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

## Shutdown the graphic device
dev.off()
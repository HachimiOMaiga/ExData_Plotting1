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

## send the histogram to a png gaphic device
png("./plot1.png", width = 480, height = 480, units = "px")

## Plot histogram 
hist(householdDT$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

## Close the graphic device
dev.off()
# downloading the data
# fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
# download.file(fileUrl, destfile = 'epc.zip')
# unzip('epc.zip', exdir = 'epc' )

# loading the data into R
table <- read.table('epc/household_power_consumption.txt', header = TRUE,  sep = ';' ,na.strings = c("?",""), stringsAsFactors = FALSE)


# converting Date and Time variables to Date/Time classes
table$Date <- as.Date(table$Date, '%d/%m/%Y') 

table$timetemp <- paste(table$Date, table$Time)
table$Time <- strptime(table$timetemp, format = "%Y-%m-%d %H:%M:%S")

# subsetting to specified dates
table <- subset(table, Date >=  as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
rownames(table) = NULL

table <- subset(table, select = - timetemp)

# making plots
png(filename = 'plot4.png')
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))

# plot 1.1
with(table, plot(Time, Global_active_power, type = 'l',xlab = '', ylab = 'Global Active Power'))

# plot 1.2
with(table, plot(Time, Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage'))

# plot 2.1
with(table, plot(Time, Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering'))
lines(table$Time, table$Sub_metering_1, type = 'l', col = 'black')
lines(table$Time, table$Sub_metering_2, type = 'l', col = 'red')
lines(table$Time, table$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', lty = c(1,1,1), col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), bty = 'n')

# plot 2.2

with(table, plot(Time, Global_reactive_power, type = 'l', xlab = 'datetime'))

dev.off()
# Days of week are in German.
# 'Do' stands for 'Donnerstag'=='Thursday'
# 'Fr' <- 'Freitag'=='Friday'
# 'Sa' <- 'Samstag'=='Saturday'





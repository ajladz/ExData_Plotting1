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

# making a plot
png(filename = 'plot2.png')
with(table, plot(Time, Global_active_power, type = 'l',xlab = '', ylab = 'Global Active Power (kilowatts)'))
dev.off()


# Days of week are in German.
# 'Do' stands for 'Donnerstag'=='Thursday'
# 'Fr' <- 'Freitag'=='Friday'
# 'Sa' <- 'Samstag'=='Saturday'



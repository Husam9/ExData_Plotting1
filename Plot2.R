#Download and process the data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
}

data_downloaded <- read.table(file, header=T, sep=";")
data_downloaded$Date <- as.Date(data_downloaded$Date, format="%d/%m/%Y")
new_df <- data_downloaded[(data_downloaded$Date=="2007-02-01") | (data_downloaded$Date=="2007-02-02"),]
new_df$Global_active_power <- as.numeric(as.character(new_df$Global_active_power))
new_df$Global_reactive_power <- as.numeric(as.character(new_df$Global_reactive_power))
new_df$Voltage <- as.numeric(as.character(new_df$Voltage))
new_df <- transform(new_df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
new_df$Sub_metering_1 <- as.numeric(as.character(new_df$Sub_metering_1))
new_df$Sub_metering_2 <- as.numeric(as.character(new_df$Sub_metering_2))
new_df$Sub_metering_3 <- as.numeric(as.character(new_df$Sub_metering_3))


# My_Plot 2
plot2 <- function() {
    plot(new_df$timestamp,new_df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    dev.copy(png, file="plot2.png", width=480, height=480)
    dev.off()
    cat("plot2.png has been saved in", getwd())
}
plot2()
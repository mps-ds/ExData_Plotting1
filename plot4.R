library(lubridate)

# Read Data
readData <- function() {
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipPath <- "household_power_consumption.zip"
    if (!file.exists(zipPath)) {download.file(fileUrl, destfile = zipPath)}
    
    # Unzip file to "household_power_consumption.txt", overwriting if it already exists
    unzip(zipPath, overwrite = TRUE)
    dataPath <- "household_power_consumption.txt"
    
    # Read data into data.frame
    data <- read.table(dataPath, sep=";", header = TRUE, as.is = TRUE, na.strings = "?")
    
    # Subset data to 2007-02-01 and 2007-02-02
    data <- subset(data,Date %in% c("1/2/2007","2/2/2007"))
    data$DateTime <- dmy_hms(paste(data$Date, data$Time))
    data$Date <- dmy(data$Date)
    
    data
}
data <- readData()

# Open PNG device
png("plot4.png", width = 480, height = 480)

# Plot 4 plots in 2x2 grid across the rows
par(mfrow=c(2,2))

# Global Active Power Time Series
plot(data$DateTime,data$Global_active_power, type = "l",
     xlab="", ylab = "Global Active Power (kilowatts)")

# Voltage Time Series
plot(data$DateTime,data$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Sub metering plot
plot(data$DateTime,data$Sub_metering_1, ylab="Energy sub metering", xlab = "", type = "n")
lines(data$DateTime, data$Sub_metering_1, col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty=1, bty="n")

# Global Reactive Power Time Series
plot(data$DateTime,data$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

# Close PNG device
dev.off()
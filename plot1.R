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

# Use png device
png("plot1.png", width = 480, height = 480)

# Create histogram
hist(data$Global_active_power, ylim = c(0, 1200), col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

# Close device
dev.off()

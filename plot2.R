

library(tidyverse)
library(lubridate)
getwd()

## Reference: http://blog.yhat.com/static/pdf/R_date_cheat_sheet.pdf
## Reference: http://rstudio-pubs-static.s3.amazonaws.com/7953_4e3efd5b9415444ca065b1167862c349.html


power_data_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(power_data_URL,destfile="./Data/consumption.zip",method="curl")

unzip(zipfile="./Data/consumption.zip", exdir = "./Data")

consumption_data <- read.table("./Data/household_power_consumption.txt", sep = ";", header = TRUE)
head(consumption_data)


# Convert the dates to a readable format
consumption_data$Date <- dmy(consumption_data$Date)

consumption_data_converted <- consumption_data
consumption_data_converted$Global_active_power <- as.numeric(as.character(consumption_data_converted$Global_active_power))


# Subset the data
subset_data <- subset(consumption_data, Date == "2007-02-01" | Date == "2007-02-02")

# work with a converted data set
converted_data <- subset_data
converted_data$Global_active_power <- as.numeric(as.character(converted_data$Global_active_power))
converted_data$Sub_metering_1 <- as.numeric(as.character(converted_data$Sub_metering_1))
converted_data$Sub_metering_2 <- as.numeric(as.character(converted_data$Sub_metering_2))
converted_data$Sub_metering_3 <- as.numeric(as.character(converted_data$Sub_metering_3))
converted_data$Voltage <- as.numeric(as.character(converted_data$Voltage))
converted_data$Global_reactive_power <- as.numeric(as.character(converted_data$Global_reactive_power))



#Plot 2 - Create the line chart
converted_data$date_time = ymd_hms(paste(converted_data$Date, converted_data$Time))
plot(converted_data$date_time, converted_data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()

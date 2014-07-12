# TO MAKE PLOT3, DO THE FOLLOWING:
# 1. Put the file "household_power_consumption.txt" in your working directory.
# 2. Source this script.
# 3. Run the function makeplot3() at the R command line.

makeplot3 <- function() {

#=====The following steps are used in all four of my plotting scripts.========
	#Read in the data file as a data frame.  Find complete cases.
	alldata <- read.csv2("household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)
	alldata <- alldata[complete.cases(alldata), ]

	#Format the Date column as a date (YYYY-MM-DD).
	alldata$Date <- as.Date(alldata$Date, "%d/%m/%Y")

	#Make a new data frame with data from the two days of interest in February 2007.
	Feb07data <- alldata[(alldata$Date == "2007-02-01" | alldata$Date == "2007-02-02"), ]

	#Make a new vector that combines the Date and Time columns.  
	#Format the vector as POSIXlt.
	DateTime <- strptime(paste(Feb07data[, 1], Feb07data[, 2]), format = "%Y-%m-%d %H:%M:%S")

	#Column-bind the new DateTime vector to the February 2007 data frame as the 1st column.
	#Note: the data frame is now a global variable and can be accessed from the command line
	#after running this script.
	Feb07data <<- cbind(DateTime, Feb07data)

#=====The following steps are specific to this plotting script.========

	#Construct the plot.

	with(Feb07data, {
		plot(DateTime, as.numeric(Sub_metering_1), xlab = "", ylab = "Energy sub metering", type = "l", col = "black")	
		lines(DateTime, as.numeric(Sub_metering_2), col = "red")
		lines(DateTime, as.numeric(Sub_metering_3), col = "blue")
	})

	legend("topright", col = c("black", "red", "blue"), lty = "solid", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

	#Save the plot as a PNG file.
	dev.copy(png, file = "plot3.png")
	dev.off()
}


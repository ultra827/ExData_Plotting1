library(sqldf)
#set up getting and cleaning data as a function
readData <- function(){
  
  #read the table in the file
  powerData <- read.csv.sql("household_power_consumption.txt", sql="SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep=";")
  
  #read in data convert date and time columns
  powerData$Date <- strptime(paste(powerData$Date,powerData$Time), "%d/%m/%Y %H:%M:%S")
  
  return(powerData)
}

#read data in readData()
outputData <- readData()

#open png graphics device
png(filename = "plot2.png",width = 480, height = 480, units = "px")


#draw the graph
plot(outputData$Date,outputData$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")
# type = "n" builds plots without points
# xaxt = NULL suppresses x axis
# xlab = "" removes the label from the x axis
# otherwise, the axis is the name of the x variable, which is date_time

#draw the line to express the contents
lines(outputData$Date, outputData$Global_active_power, type="S")

dev.off()
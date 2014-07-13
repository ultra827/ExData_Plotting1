library(sqldf)
#set up getting and cleaning data as a function
readData <- function(){
  
  #read the table in the file
  powerData <- read.csv.sql("household_power_consumption.txt", sql="SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'", sep=";")
  
  #read in data convert date and time columns
  powerData$Date <- strptime(paste(powerData$Date,powerData$Time), "%d/%m/%Y %H:%M:%S")
  
  return(powerData)
}


outputData <- readData()

#save png graphics device
png(filename = "plot4.png",width = 480, height = 480, units = "px")

#arrange four plots in the one file
par(mfrow=c(2,2))

#draw the graph1 (Date - Global_active_power)
plot(outputData$Date,outputData$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")
# type = "n" builds plots without points
# xaxt = NULL suppresses x axis
# xlab = "" removes the label from the x axis
# otherwise, the axis is the name of the x variable, which is date_time
lines(outputData$Date, outputData$Global_active_power, type="S")


#draw graphic2 (Date - Voltage)
plot(outputData$Date,outputData$Voltage,xaxt=NULL,xlab="datetime",ylab="Voltage",type="n")
#draw lines of Sub_metering_1
lines(outputData$Date,outputData$Voltage,type="s",col="black")

#draw graphic3 (Date - Sub_metering1,2,3)
plot(outputData$Date,outputData$Sub_metering_1,xaxt=NULL,xlab="",ylab="Energy sub metering",type="n")
#draw lines of Sub_metering_1
lines(outputData$Date,outputData$Sub_metering_1,type="s",col="black")
#draw a line of Sub_metering_2
lines(outputData$Date,outputData$Sub_metering_2,type="s",col="red")
#draw a line of Sub_metering_3
lines(outputData$Date,outputData$Sub_metering_3,type="s",col="blue")
#make the explanation box of graphics
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

#draw graphic4 (Date - Global_reactive_power)
plot(outputData$Date,outputData$Global_reactive_power,xaxt=NULL,xlab="datetime",ylab="Global_reactive_power",type="n")
#draw lines of Sub_metering_1
lines(outputData$Date,outputData$Global_reactive_power,type="s",col="black")



dev.off()

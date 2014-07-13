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
png(filename = "plot3.png",width = 480, height = 480, units = "px")


#draw graphics
plot(outputData$Date,outputData$Sub_metering_1,xaxt=NULL,xlab="",ylab="Energy sub metering",type="n")

#draw lines of Sub_metering_1
lines(outputData$Date,outputData$Sub_metering_1,type="s",col="black")
#draw a line of Sub_metering_2
lines(outputData$Date,outputData$Sub_metering_2,type="s",col="red")
#draw a line of Sub_metering_3
lines(outputData$Date,outputData$Sub_metering_3,type="s",col="blue")

#make the explanation box of graphics
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

dev.off()
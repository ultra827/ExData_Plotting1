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

#save the png file 
png(filename = "plot1.png",width = 480, height = 480, units = "px")

#draw the graph 
hist(outputData$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (killowats)",ylab="Frequency",col="red",xlim=c(0,6),ylim=c(0,1200))

dev.off()
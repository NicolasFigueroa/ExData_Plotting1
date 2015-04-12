# Download file if not ixist

if(!file.exists("dataset.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "dataset.zip")
}

#Unzip file
if(!file.exists("household_power_consumption.txt")){
  unzip("dataset.zip")
}


#Read file
datasetElectricPowerConsumption <- read.table(file="household_power_consumption.txt", 
                                              header=TRUE, sep=";", 
                                              as.is=TRUE, 
                                              na.strings="?", 
                                              colClasses=c("character", 
                                                           "character", 
                                                           "numeric", 
                                                           "numeric", 
                                                           "numeric", 
                                                           "numeric", 
                                                           "numeric", 
                                                           "numeric", 
                                                           "numeric"))


#Add new column with date and time in necessary format
datasetElectricPowerConsumption$DateTime=paste(datasetElectricPowerConsumption$Date, datasetElectricPowerConsumption$Time)
datasetElectricPowerConsumption$DateTime=strptime(datasetElectricPowerConsumption$DateTime, "%d/%m/%Y %H:%M:%S")

#Formatting the Date column
datasetElectricPowerConsumption$Date=strptime(datasetElectricPowerConsumption$Date, "%d/%m/%Y")

#Extract the subset 
subsetElectricPowerConsumption<-subset(datasetElectricPowerConsumption,
                                       datasetElectricPowerConsumption$Date== "2007-02-01" | 
                                         datasetElectricPowerConsumption$Date== "2007-02-02" )


#Config the multi
par(mfcol=c(2,2))

#Create all graphic and save in file
plot(subsetElectricPowerConsumption$DateTime, 
     subsetElectricPowerConsumption$Global_active_power, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")

plot(subsetElectricPowerConsumption$DateTime, 
     subsetElectricPowerConsumption$Sub_metering_1, 
     type="l", 
     ylab="Energy sub metering", 
     xlab="")

lines(subsetElectricPowerConsumption$DateTime, 
      subsetElectricPowerConsumption$Sub_metering_2, 
      col="red")

lines(subsetElectricPowerConsumption$DateTime, 
      subsetElectricPowerConsumption$Sub_metering_3, 
      col="blue")

legend("topright", 
       col=c("black", "blue", "red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=1, 
       box.lty=0, 
       pt.cex = 1, 
       cex=0.7)

plot(subsetElectricPowerConsumption$DateTime, 
     subsetElectricPowerConsumption$Voltage, 
     type="l", 
     ylab="Voltage", 
     xlab="datetime")
plot(subsetElectricPowerConsumption$DateTime, 
     subsetElectricPowerConsumption$Global_reactive_power, 
     type="l", 
     ylab="Global_reactive_power", 
     xlab="datetime")


dev.copy(png, file="plot4.png", width = 480, height = 480, bg = "transparent")
dev.off()
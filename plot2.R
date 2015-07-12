# Download file if not exist...


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


#Create the plot and save in file
plot(subsetElectricPowerConsumption$DateTime, subsetElectricPowerConsumption$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", width = 480, height = 480, bg = "transparent")
dev.off()







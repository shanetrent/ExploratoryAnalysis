#Installing required libraries and packages.

install.packages(data.table)
library(data.table)
library(dplyr)

#Reading data into my table.

mydata<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

#Looking at data to verify.

dim(mydata)
head(mydata)
names(mydata)

#TUrning Dates into usable variables.

mydata$DateTime <- paste(mydata$Date, mydata$Time)
mydata$DateTime <- strptime(mydata$DateTime, "%d/%m/%Y %H:%M:%S")
begindate <- which(mydata$DateTime == strptime("2007-02-01","%Y-%m-%d"))
enddate <- which(mydata$DateTime == strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

#combining both begining and end dates to narrow rows of data.

mydata2 <- mydata[begindate:enddate,]

#1st Plot and saving to file.

hist(as.numeric(as.character(mydata2$Global_active_power)), main="Global Active Power",xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png, 'Plot1.png')
dev.off()

#2nd Plot and saving to file.

plot(mydata2$DateTime, as.numeric(as.character(mydata2$Global_active_power)), type='l',ylab="Global Active Power (Kilowatts)", xlab="")
dev.copy(png, 'Plot2.png')
dev.off()

#3rd Plot and saving to file.

plot(mydata2$DateTime, as.numeric(as.character(mydata2$Sub_metering_1)),type='l', ylab ="Energy sub metering", xlab="")
lines(mydata2$DateTime, as.numeric(as.character(mydata2$Sub_metering_2)),type='l', col='red')
lines(mydata2$DateTime, mydata2$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
dev.copy(png, 'Plot3.png')
dev.off()

#4th Plot and saving to file.

par(mfcol=c(2,2))

plot(mydata2$DateTime, as.numeric(as.character(mydata2$Global_active_power)),type='l',ylab="Global Active Power", xlab="")

plot(mydata2$DateTime, as.numeric(as.character(mydata2$Sub_metering_1)),type='l', xlab="",ylab ="Energy sub metering")
lines(mydata2$DateTime, as.numeric(as.character(mydata2$Sub_metering_2)),type='l', col='red')
lines(mydata2$DateTime, mydata2$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))

plot(mydata2$DateTime, as.numeric(as.character(mydata2$Voltage)),type='l', ylab="Voltage",xlab="datetime")

plot(mydata2$DateTime, as.numeric(as.character(mydata2$Global_reactive_power)),type='l', ylab="Global_reactive_power",xlab="datetime")
dev.copy(png, 'Plot4.png')
dev.off()
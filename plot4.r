# plot4.R
source("hpc_data_fnc.R")
hpc_data = NULL
hpc_data <- hpc_data_fnc()

head(hpc_data)

par(mfrow=c(2,2),mar=c(4,4,2,1))

op <- par(cex = 0.5)
plot(hpc_data$Time, hpc_data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

plot(hpc_data$Time, hpc_data$Voltage, type="l",
     xlab="datetime", ylab="Voltage")
plot(hpc_data$Time, hpc_data$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(hpc_data$Time, hpc_data$Sub_metering_2, col="red")
lines(hpc_data$Time, hpc_data$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
       box.lwd=0)
plot(hpc_data$Time, hpc_data$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(hpc_data$Time, hpc_data$Global_reactive_power)

# generate file plot4.png graph in default directory
dev.copy(png, file="plot4.png", width=480, height=480,units="px")
# switch of device
dev.off()


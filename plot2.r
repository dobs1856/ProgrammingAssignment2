# plot2.R
source("hpc_data_fnc.R")
hpc_data = NULL
hpc_data <- hpc_data_fnc()
head(hpc_data)

plot(hpc_data$Time, hpc_data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# generate file plot2.png graph in default directory
dev.copy(png, file="plot2.png", width=480, height=480,units="px")
# switch of device
dev.off()

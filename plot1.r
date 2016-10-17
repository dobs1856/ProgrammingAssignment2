# plot1.R
source("hpc_data_fnc.R")
hpc_data = NULL
hpc_data <- hpc_data_fnc()

head(hpc_data)

hist(hpc_data$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="red",breaks = 50)  

dev.copy(png, file="plot1.png", width=480, height=480,units="px")
dev.off()
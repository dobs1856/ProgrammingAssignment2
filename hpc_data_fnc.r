hpc_data_fnc <- function() {
  hpc_set <- read.table("household_power_consumption.txt", header=T, sep=";",na="?") 
  # convert date and time variables to Date/Time class
  hpc_set$Time <- strptime(paste(hpc_set$Date, hpc_set$Time), "%d/%m/%Y %H:%M:%S")
  hpc_set$Date <- as.Date(hpc_set$Date, "%d/%m/%Y")
  # Extract data only for 2007-02-01 and 2007-02-02
  hpc_subset <- subset(hpc_set, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
  
  rm(hpc_set)
  
  return(hpc_subset)
  
}

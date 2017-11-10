require(tidyverse)

d <- read.csv(file = 'household_power_consumption.txt', sep = ';')

#filter only dates that are between 2007-02-01 and 2007-02-02
d <- d %>% filter(Date %in% c('1/2/2007', '2/2/2007'))

d[d =='?'] <- NA

#Transform column 3 to 9 into numeric.
d[,3:9] <- apply(d[,3:9], 2, as.numeric)

#now transform time series data into appropriate forms
d$date2 <- as.Date(d$Date, format = '%d/%m/%Y')
date_time <- paste0(as.character(d$Date), ' ', as.character(d$Time))
d$datetime <- strptime(date_time, '%d/%m/%Y %H:%M:%S')

p <- hist(d$Global_active_power, 
     col = 'red',
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power' )


dev.copy(png, 'plot1.png', width = 800, height = 600)
dev.off()





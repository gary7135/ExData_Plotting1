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

plot(x = d$datetime, 
     y = d$Sub_metering_1, 
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)',
     col = 'black')
par(new = T)
lines(x = d$datetime, 
      y = d$Sub_metering_2, 
      col = 'red')
par(new = T)
lines(x = d$datetime, 
      y = d$Sub_metering_3, 
      col = 'blue')

legend( 'topright', 
        legend = c('Sub_meeting_1','Sub_meeting_2', 'Sub_meeting_3'),
        col = c('black', 'red', 'blue'),
        lty = 1, 
        cex = .8)
par(new = F)

dev.copy(png, 'plot3.png', width = 800, height = 600)
dev.off()


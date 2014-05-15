if(!file.exists("course_project_1")){
        dir.create("course_project_1")
}

url= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./course_project_1/data.zip", method="curl")
dateDownloaded<- date()

#unzip file
a=unzip("./course_project_1/data.zip")

#read file into R and assign to object "data"
data=read.csv(a[1], sep=";", colClasses="character")

#convert variable named "Date" to date type
data$Date=strptime(data$Date, format="%d/%m/%Y")

#Subset only data between 2007-02-01 and 2007-02-02
data2=data[data$Date%in% c("2007-02-01","2007-02-02"),]

#Combine variables "Date" and "Time" into one variable "datetime" and convert to date type
data2$Datetime=paste(data2$Date, data2$Time, sep=" ")
data2$Datetime=strptime(data2$Datetime, format="%Y-%m-%d %H:%M:%S")

#Convert column 3-9 to numeric class
for (i in (3:9)){ data2[,i]=as.numeric(data2[,i])}

#1st Plot
hist(data2$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file="./course_project_1/plot1.png", width=480, height=480)
dev.off()
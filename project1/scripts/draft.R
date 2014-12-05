setwd('~/2014/Coursera/ExploratoryDataAnalysis')

# creates a temp file
temp <- tempfile()
# downloads the zip file into the temp file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method='curl')
# gets the list of files that are in the zip
files<-unzip(temp, list=T)
# unzips the file into the temp dir
unzip(temp, files$Name[1], overwrite=T, exdir=tempdir())
# unlinks the temp file
unlink(temp)
# creates another tempfile
temp <- tempfile()
filename<-paste(tempdir(), files$Name[1], sep='/')
# gets the header from the original file and sends to the temp file
system(paste("head -1", filename, " > ", temp))
# greps data from 1/2/2007 and 2/2/2007 only and appends to the temp file 
system(paste("grep '^[12]/2/2007'", filename, " >> ", temp))
# reads the file
df<-read.csv(temp, sep=';', header=T)

# loads the first file
#data <- read.table(unz(temp, files$Name[1]), sep=';', header=T)



lines2007<-grep('^../../2007',readLines(unz('project1/data/exdatadatahousehold_power_consumption.zip', 'household_power_consumption.txt')), value=T)

# gives a lengthy warning
dt<-fread('project1/data/household_power_consumption.txt', sep=';', verbose=T)
dt<-fread('project1/data/household_power_consumption.txt', sep=';', na.strings=c('?'), verbose=T)




par(mfrow=c(1,1))
# plot 1 draft
df<-read.csv('project1/data/household_power_consumption.txt', sep=';', header=T)
df<-df[grepl('^[12]/[2]/2007', df$Date),]
class(df$Global_active_power)
df$Global_active_power<-as.numeric(as.character(df$Global_active_power))
class(df$Global_active_power)
hist(df$Global_active_power, col='red')


# plot 2 draft

strptime('01/02/2007 10:00:00',format='%d/%m/%Y %H:%M:%S',tz='')
[1] "2007-02-01 10:00:00 BRST"
d<-strptime('01/02/2007 10:00:00',format='%d/%m/%Y %H:%M:%S',tz='')
d
[1] "2007-02-01 10:00:00 BRST"
year(d)
[1] 2007
weekdays(d)
[1] "Thursday"
df$date_time<-paste(df$Date, df$Time)
> View(df)
> df$date_time<-strptime(df$date_time, '%d/%m/%Y %H:%M:%S')
> View(df)
> df$weekdays<-weekdays(df$date_time)
# plot 2 draft - falta margem, tamanho e labels
plot(df$date_time, df$Global_active_power, xlab='', ylab='', axes=F, lty=1, type='l')
axis(2, at=c(0,2, 4, 6))
axis(1, at=c(as.numeric(df$date_time[1]), as.numeric(df$date_time[1441]), as.numeric(df$date_time[2880])), labels<-c('thu', 'fri', 'sat'))

# plot 3 - draft
plot(df$date_time, df$Sub_metering_1, xlab='', ylab='', axes=F, lty=1, type='l', col='black')
lines(x=df$date_time, df$Sub_metering_2, col='red')
lines(x=df$date_time, df$Sub_metering_3, col='blue')
axis(2, at=c(0,10,20,30))
axis(1, at=c(as.numeric(df$date_time[1]), as.numeric(df$date_time[1441]), as.numeric(df$date_time[2880])), labels<-c('thu', 'fri', 'sat'))


# plot 4 - draft
par(mfrow=c(2,2))

plot(df$date_time, df$Global_active_power, xlab='', ylab='', axes=F, lty=1, type='l')
axis(2, at=c(0,2, 4, 6))
axis(1, at=c(as.numeric(df$date_time[1]), as.numeric(df$date_time[1441]), as.numeric(df$date_time[2880])), labels<-c('thu', 'fri', 'sat'))

# draft - check labels and ticks
df$Voltage<-as.numeric(as.character(df$Voltage))
plot(df$date_time, df$Voltage, type='l', ylab='Voltage', xlab='datetime', axes=F)
axis(1, at=c(as.numeric(df$date_time[1]), as.numeric(df$date_time[1441]), as.numeric(df$date_time[2880])), labels<-c('thu', 'fri', 'sat'))
axis(2, at=c(234,238,242, 246))

plot(df$date_time, df$Sub_metering_1, xlab='', ylab='', axes=F, lty=1, type='l', col='black')
lines(x=df$date_time, df$Sub_metering_2, col='red')
lines(x=df$date_time, df$Sub_metering_3, col='blue')
axis(2, at=c(0,10,20,30))
axis(1, at=c(as.numeric(df$date_time[1]), as.numeric(df$date_time[1441]), as.numeric(df$date_time[2880])), labels<-c('thu', 'fri', 'sat'))

df$Global_reactive_power<-as.numeric(as.character(df$Global_reactive_power))
plot(df$date_time, df$Global_reactive_power, type='l', ylab='Global_reactive_power', xlab='datetime')

plot(df$date_time, df$Sub_metering_1, xlab='', ylab='', type='l', col='black')
library(data.table)

# change it if needed.
setwd('~/2014/Coursera/ExploratoryDataAnalysis/project1')

filename<-NULL

# checks if the file is already available 
# that is just to avoid downloading the file multiple times in the different scripts.
if(file.exists(paste(getwd(), 'data', 'household_power_consumption.txt', sep='/'))){
  info<-file.info(paste(getwd(), 'data', 'household_power_consumption.txt', sep='/'))
  # checks if the file size is correct
  if(info$size == 132960755)
    filename<-paste(getwd(), 'data', 'household_power_consumption.txt', sep='/')
}

if (is.null(filename)){
  # creates a temp file
  temp <- tempfile()
  # downloads the zip file into the temp file
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method='curl')
  # gets the list of files that are in the zip
  files<-unzip(temp, list=T)
  # unzips the file into the temp dir
  unzip(temp, files$Name[1], overwrite=T, exdir='data')
  # constructs the filename 
  filename<-paste(getwd(), 'data', files$Name[1], sep='/')
  # unlinks the temp file
  unlink(temp)
}

## first idea was to use grep on OS level
# gets the header from the original file and sends to the temp file overwriting the original contents
#system(paste("head -1", filename, " > ", temp))
# greps data from 1/2/2007 and 2/2/2007 only and appends to the temp file 
#system(paste("grep '^[12]/2/2007'", filename, " >> ", temp))
# reads the file
#df<-read.csv(temp, sep=';', header=T)

# reads the file using fread using skip to skip all rows up to 1/2/2007.
# Then it reads the exact number of rows needed: 2 days of 24h of 60 minutes
df<-fread(filename, sep=';', skip='1/2/2007', nrows=2*24*60)
# gets the header from the original file
header<-readLines(filename, n=1)
# splits it by ;
header<-unlist(strsplit(header, ';'))
# gets the variable names assigned by fread
colnames<-colnames(df)
# renames the variables
for (i in 1:length(colnames)){
  setnames(df, colnames[i], header[i])
}

# plot 2
par(mfrow=c(1,1))
# creates a new variable with the date time
## data.frame way 
#df$date_time<-strptime(paste(df$Date, df$Time), '%d/%m/%Y %H:%M:%S')
# this is just creating a new character column instead of POSIXlt column as the one above for df. 
# I couldnt figure out how to do that in data.table
df[,date_time:=paste(Date, Time)]
# creates a directory called images if it doesnt exist
if(!file.exists('images')){ dir.create('images')}
# opens the device for png
png('images/plot2.png', width=480, height=480, units='px')
# calls the function to create the plot
## data.frame way 
#plot(df$date_time, df$Global_active_power, xlab='', ylab='Global Active Power (kilowatts)', type='l')
plot(as.POSIXlt(df[,date_time],'%d/%m/%Y %H:%M:%S', tz='BRST'), df[,Global_active_power], xlab='', ylab='Global Active Power (kilowatts)', type='l')
# closes the device
dev.off()

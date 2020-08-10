### 1. Data preparation

# 1.1 - Ensure plotting data is present
if (!file.exists('exdata_data_NEI_data.zip')) {
        download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip','exdata_data_NEI_data.zip')
}
if (file.exists('exdata_data_NEI_data.zip')) {
        unzip('exdata_data_NEI_data.zip')
}
# 1.2 Reading NEI and SCC files
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
        NEI <- readRDS("~/Roque/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("~/Roque/Source_Classification_Code.rds")
}

### 2. Answering the question 1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# 2.1. Creating a new variable with the plot1 data
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

# 2.2. Generating plot1.png
png('plot1.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()

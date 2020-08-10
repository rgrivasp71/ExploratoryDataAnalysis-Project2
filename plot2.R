### 1 - Data preparation

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
### 2. Answering the question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# 2.1. Creating new variables with the plot2 data
subsetNEI  <- NEI[NEI$fips=="24510", ]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

# 2.2. Generating plot2.png
png('plot2.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.off()

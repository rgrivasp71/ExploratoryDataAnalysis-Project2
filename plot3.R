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

### 2. Answering the question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# 24510 is Baltimore, see plot2.R

# 2.1. Creating new variables with the plot3 data
subsetNEI  <- NEI[NEI$fips=="24510", ]
aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)

# 2.2. Generating plot3.png
##loading library ggplot2
if(!require(ggplot2)){
        install.packages("ggplot2")
        library(ggplot2)
}
png("plot3.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(g)
dev.off()
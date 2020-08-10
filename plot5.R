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

### 2. Answering the question 5:
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# 24510 is Baltimore, see plot2.R
# Searching for ON-ROAD type in NEI
# Don't actually know it this is the intention, but searching for 'motor' in SCC only gave a subset (non-cars)

# 2.1. Creating new variables with the plot5 data
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

# 2.2. Generating plot5.png
##loading library ggplot2
if(!require(ggplot2)){
        install.packages("ggplot2")
        library(ggplot2)
}
png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()

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
# 1.3 merge the two data sets 
if(!exists("NEISCC")){
        NEISCC <- merge(NEI, SCC, by="SCC")
}
### 2. Answering the question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# 24510 is Baltimore, see plot2.R, 06037 is LA CA
# Searching for ON-ROAD type in NEI
# Don't actually know it this is the intention, but searching for 'motor' in SCC only gave a subset (non-cars)

# 2.1. Creating new variables with the plot6 data
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

# 2.2. Generating plot6.png
##loading library ggplot2
if(!require(ggplot2)){
        install.packages("ggplot2")
        library(ggplot2)
}
png("plot6.png", width=1040, height=480)
g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
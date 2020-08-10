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
# merge the two data sets 
if(!exists("NEISCC")){
        NEISCC <- merge(NEI, SCC, by="SCC")
}

### 2. Answering the question 4:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# 2.1 fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

# 2.1. Creating new variables with the plot4 data
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

# 2.2. Generating plot4.png
##loading library ggplot2
if(!require(ggplot2)){
        install.packages("ggplot2")
        library(ggplot2)
}
png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()

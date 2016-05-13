NEI <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/Source_Classification_Code.rds")

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(ggplot2)
coalMatches  <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE)
coalMatches <- NEI[coalMatches, ]
coalMatches <- split(coalMatches, f = coalMatches$year)
pollution_data_frame <- data.frame(year=character(), pollution=numeric())
for(year in names(coalMatches)){
  pollution_data_frame <- rbind(pollution_data_frame, data.frame(year=year, pollution=sum(coalMatches[[year]]$Emissions)))
}
pollution_data_frame
g <- ggplot(pollution_data_frame, aes(year, pollution))
g <- g + geom_bar(stat="identity") + labs(title="Coal Pollution Over The Years")
g
dev.copy(png, "/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/plot4.png")
dev.off()

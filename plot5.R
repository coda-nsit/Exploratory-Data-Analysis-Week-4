NEI <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/Source_Classification_Code.rds")

summer <- function(data_frame){
  sum(data_frame$Emissions)
}

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(ggplot2)
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles <- SCC[vehicles,]$SCC
vehicles <- NEI[NEI$SCC %in% vehicles,]
vehicles <- vehicles[vehicles$fips=="24510",]
vehicles <- split(vehicles, vehicles$year)
df <- data.frame(year=character(), pollution_value=numeric())
for(year in names(vehicles)){
  df <- rbind(df, data.frame(year=year, pollution_value=sum(vehicles[[year]]$Emissions)))
}
df
ggplot(df, aes(year, pollution_value)) + geom_bar(stat = "identity") + labs(title="Motor Vehicle Pollution", x="Year", y="Pollution Value")

dev.copy(png, "/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/plot5.png")
dev.off()

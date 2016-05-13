NEI <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)
NEI_Baltimore <- NEI[NEI$fips=="24510", ]
pollution_year <- split(NEI, NEI$year)
pollution_year_type <- lapply(pollution_year, split, NEI_Baltimore$type)
year_type_data_frame <- data.frame(year=character(), type=character(), pollution_value=numeric())
for(year in names(pollution_year_type)){
  for(type in names(pollution_year_type[[year]])){
    year_type_data_frame <- rbind(year_type_data_frame, data.frame(year=year, type=type, pollution_value=sum(pollution_year_type[[year]][[type]]$Emissions)))
  }
}
year_type_data_frame
g <- qplot(year, pollution_value, data=year_type_data_frame, facets = .~type, geom = "density")
g <- g + labs(x="Year", y="Pollution Value", title="Pollution Types In Years")
g
dev.copy(png, "/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/plot3.png")
dev.off()

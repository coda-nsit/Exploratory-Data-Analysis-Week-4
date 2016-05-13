NEI <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
factored_NEI <- split(NEI, f=NEI$year)
total_pollutant <- data.frame(year=character(), pollutant=numeric())
for(years in names(factored_NEI)){
  total_pollutant <- rbind(total_pollutant, data.frame(year=years, pollutant=sum(factored_NEI[[years]]$Emissions)))
}
total_pollutant
plot(total_pollutant$year, total_pollutant$pollutant, type="n")
title(main = "Pollution levels")
points(total_pollutant)
lines(total_pollutant$year, total_pollutant$pollutant)

dev.copy(png, "/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/plot1.png")
dev.off()

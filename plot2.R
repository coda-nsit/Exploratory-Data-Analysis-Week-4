NEI <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
baltimore <- NEI[NEI$fips=="24510", ]
baltimore <- split(baltimore, baltimore$year)
total_pollutant <- data.frame(year=character(), pollutant=numeric())
for(years in names(baltimore)){
  total_pollutant <- rbind(total_pollutant, data.frame(year=years, pollutant=sum(baltimore[[years]]$Emissions)))
}
total_pollutant
plot(total_pollutant$year, total_pollutant$pollutant, type="n")
title(main = "Pollution levels in Baltimore City")
points(total_pollutant)
lines(total_pollutant$year, total_pollutant$pollutant)

dev.copy(png, "/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/plot2.png")
dev.off()

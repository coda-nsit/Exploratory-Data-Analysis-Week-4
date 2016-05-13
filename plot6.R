NEI <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/exdata-data-NEI_data/Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles <- SCC[vehicles,]$SCC
vehicles <- NEI[NEI$SCC %in% vehicles,]
vehicles_baltimore <- vehicles[vehicles$fips=="24510",]
vehicles_LA <- vehicles[vehicles$fips=="06037",]
vehicles_baltimore <- split(vehicles_baltimore, vehicles_baltimore$year)
vehicles_LA <- split(vehicles_LA, vehicles_LA$year)

df_baltimore <- data.frame(year=character(), pollution_value=numeric())
df_LA <- data.frame(year=character(), pollution_value=numeric())
for(year in names(vehicles_baltimore)){
  df_baltimore <- rbind(df_baltimore, data.frame(year=year, pollution_value=sum(vehicles_baltimore[[year]]$Emissions)))
}
df_baltimore
for(year in names(vehicles_LA)){
  df_LA <- rbind(df_LA, data.frame(year=year, pollution_value=sum(vehicles_LA[[year]]$Emissions)))
}
df_LA
#ggplot(df_baltimore, aes(year, pollution_value, color="red")) + geom_point() + labs(title="Motor Vehicle Pollution", x="Year", y="Pollution Value") + geom_line()
#ggplot(df_LA, aes(year, pollution_value, color="black")) + geom_point() + labs(title="Motor Vehicle Pollution", x="Year", y="Pollution Value") + geom_line()
#combined_baltimore_LA <- rbind(df_baltimore, df_LA)
#ggplot(combined_baltimore_LA, aes(year, pollution_value, color="red")) + geom_line() + labs(title="Motor Vehicle Pollution", x="Year", y="Pollution Value")
#qplot(df_baltimore$year, df_baltimore$pollution_value, data=df_baltimore, geom = )
plot(df_baltimore$year, df_baltimore$pollution_value, type="n", ylim=range(df_baltimore$pollution_value, df_LA$pollution_value))
par(new = TRUE)
plot(df_LA$year, df_LA$pollution_value, type="n" , ylim=range(df_baltimore$pollution_value, df_LA$pollution_value), xlab="Years", ylab="Pollution Value", main="Comparison Of Baltimore and LA")
points(df_baltimore, pch=7, col="black")
lines(df_baltimore, lty=3, col="black")
points(df_LA, pch=1, col="yellow")
lines(df_LA, lty=1, col="yellow")
legend("right", col=c("black", "yellow"), legend=c("Balimore", "LA"), pch = c(7, 1))

dev.copy(png, "/home/coda/Documents/Data Science/4. Exploratory Data Analysis/Week 4/Assignments/plot6.png")
dev.off()

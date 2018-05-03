options("scipen"=999)

# Importing data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Selecting only emissions for Baltimore City
NEI_data <- NEI[NEI$fips=="24510", ]

# Agreggating data to NEI_plot
NEI_plot <- data.frame(year = unique(NEI_data$year),
                              emission = tapply(NEI_data$Emissions,
                                              list(NEI_data$year),
                                              FUN=sum))
#Plotting
png("plot02.png", width=480, height=480)

plot(NEI_plot,
     type = "b",
     col = "red",
     pch = 16,
     main = "Total emission PM2.5 (tons) in\nBaltimore City, Maryland",
     xlab = "Year",
     ylab = "Emission PM2.5 (tons)")

dev.off()

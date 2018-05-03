options("scipen"=999)
# Importing data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Agreggating data to NEI_plot
NEI_plot <- data.frame(year = unique(NEI$year),
                              emission = tapply(NEI$Emissions,
                                              list(NEI$year),
                                              FUN=sum))

# Plotting
png("plot01.png", width=480, height=480)

plot(NEI_plot,
     type = "b",
     col = "red",
     pch = 16,
     main = "Total emissions from PM2.5\nin the United States",
     xlab = "Year",
     ylab = "Emission PM2.5 (tons)")

dev.off()
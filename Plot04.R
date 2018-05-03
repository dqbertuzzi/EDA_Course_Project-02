options("scipen"=100)
#--- (4)
setwd("C:/Users/BertDa01/Desktop/New folder")

# Importing data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Selecting only emissions from coal combustion-related sources
SCC_coal_sel <- grep("coal", SCC$EI.Sector, ignore.case = T)
SCC_coal <- SCC[SCC_coal_sel, ]

# Assigning to the dataset NEI_data only observations from coal combustion-related sources
NEI_data <- NEI[NEI$SCC %in% SCC_coal$SCC, ]

# Agreggating data to NEI_plot
library(dplyr)
NEI_plot <- NEI_data %>%
   group_by(year) %>%
   summarise(Emissions = sum(Emissions))

# Plotting
library(ggplot2)

png("plot04.png", width=480, height=480)

ggplot(NEI_plot, aes(x=year, y=Emissions)) +
   geom_line(size=1, col="red") +
   geom_point(size=3) +
   ggtitle("Emissions PM2.5 (tons) from coal combustion-related sources changed from 1999-2008 across the United States") +
   labs(x="Year",
        y="PM2.5 (tons) Total Emission") +
   ylim(300000, 590000) +
   scale_x_discrete(limits = c(1999, 2002, 2005, 2008))

dev.off()
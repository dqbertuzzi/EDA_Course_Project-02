library(ggplot2)
library(dplyr)

# Importing data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Selecting only emissions for Baltimore City
NEI_data <- NEI[NEI$fips=="24510", ]

# Agreggating data to NEI_plot
NEI_plot <- NEI_data %>%
  group_by(year, type) %>%
  summarise(Emissions = sum(Emissions))

# Plotting
png("plot03.png", width=480, height=480)

ggplot(data=NEI_plot, aes(x=year, y=Emissions)) +
  geom_line(size=1, col="red") +
  geom_point(size=2) +
  facet_wrap(~ type) +
  ggtitle("Total emissions of PM2.5 per Year indicated\nby Type of Source in Baltimore City") +
  labs(y = "Emission PM2.5 (tons)",
       x = "Year") +
  scale_x_discrete(limits = c(1999, 2002, 2005, 2008))

dev.off()

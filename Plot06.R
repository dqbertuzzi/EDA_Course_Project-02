#--- (6)

setwd("")

# Importing data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Selecting only motor vehicle sources
SCC_motor_vehicles_sel <- subset(SCC,EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"
                                 | EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"
                                 | EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles"
                                 | EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"
                                 | EI.Sector == "Mobile - Aircraft"
                                 | EI.Sector == "Mobile - Commercial Marine Vessels"
                                 | EI.Sector == "Mobile - Locomotives")

# Assigning to the dataset NEI_plot observations from Baltimore and Los Angeles County that have emissions from motor vehicle sources\nNEI_data <- NEI[NEI$SCC %in% SCC_motor_vehicles_sel$SCC, ]
NEI_data <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]

library(dplyr)
NEI_plot <- NEI_data %>%
   group_by(year, fips) %>%
   summarise(Emissions = sum(Emissions))

# Plotting
library(ggplot2)

png("plot06.png", width=480, height=480)

ggplot(NEI_plot, aes(x=year, y=Emissions, fill=fips)) +
   geom_bar(position="dodge", stat="identity") +
   ggtitle("Comparison of emissions PM2.5 (tons) from motor vehicle sources changed from 1999-2008 in Baltimore City and Los Angeles County") +
   labs(x="Year",
        y="PM2.5 (tons) Total Emission",
        fill="Caption") +
   ylim(0, 50000) +
   scale_x_discrete(limits = c(1999, 2002, 2005, 2008)) +
   scale_fill_discrete(labels=c("Los Angeles County", "Baltimore City"))

dev.off()

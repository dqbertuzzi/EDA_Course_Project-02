
#--- (5)

# Importing data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Selecting only motor vehicle sources
unique(SCC$EI.Sector)

SCC_motor_vehicles_sel <- subset(SCC,EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"
                                 | EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"
                                 | EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles"
                                 | EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"
                                 | EI.Sector == "Mobile - Aircraft"
                                 | EI.Sector == "Mobile - Commercial Marine Vessels"
                                 | EI.Sector == "Mobile - Locomotives")

# Assigning to the dataset NEI_plot only observations from Baltimore that have emissions from motor vehicle sources
NEI_data <- NEI[NEI$SCC %in% SCC_motor_vehicles_sel$SCC & NEI$fips == "24510", ]

# Agreggating data to NEI_plot
library(dplyr)
NEI_plot <- NEI_data %>%
   group_by(year) %>%
   summarise(Emissions = sum(Emissions))

# Plotting
library(ggplot2)

png("plot05.png", width=480, height=480)

ggplot(NEI_plot, aes(x=year, y=Emissions)) +
   geom_line(size=0.8, col="red") +
   geom_point(size=3) +
   ggtitle("Emissions PM2.5 (tons) from motor vehicle sources\nchanged from 1999-2008 in Baltimore City") +
   labs(x="Year",
        y="PM2.5 (tons) Total Emission") +
   ylim(250, 850) +
   scale_x_discrete(limits = c(1999, 2002, 2005, 2008))

dev.off()

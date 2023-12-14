library(tidyr)
library(tidyverse)

## set the working directory
setwd("C:/Users/ellam/OneDrive/Documents/exeter/Programming for Social Data Science/Assessments/summative2/csv")

#read and subset
read_and_subset <- function(file_name, columns) {
  dataset <- read.csv(file_name)
  subset(dataset, select = columns)
}

# Use the function to read and subset datasets
hhpub <- read_and_subset("hhpub.csv", c('HOUSEID', 'TRAVDAY', 'HHSIZE', 'HHSTATE'))
trippub <- read_and_subset("trippub.csv", c('HOUSEID', 'TRPMILES', 'R_AGE'))

#merge datasets
ds1 <- merge(hhpub,trippub, by="HOUSEID",all.x=T)

#drop other days of week
ds2 <- ds1 %>% 
  filter(TRAVDAY == 1)

#filtering age
ds3 <- ds2 %>%
  filter(R_AGE >= 18)

#omit NA values
ds4 <- na.omit(ds3)



# Average distance travelled by household
average_trip_distance <- ds4 %>%
  group_by(HOUSEID) %>%               # Group the data by household
  summarize(
    total_miles = sum(TRPMILES),    # Sum the trip miles for each group
    num_journeys = n(),                # Count the number of journeys for each group
    avg_distance = total_miles / num_journeys  # Calculate the average distance
  )

#join avg distance to ds
ds5 <- ds4 %>%
  left_join(average_trip_distance, by = "HOUSEID")

##Using loops
#new df results
results <- data.frame(State = character(), Correlation = numeric(), stringsAsFactors = FALSE)

#
# Loop through each state
for (state in unique(ds5$HHSTATE)) {
  # Subset data for the state
  state_data <- subset(ds5, HHSTATE == state)
  
  # Compute correlation
  corr <- cor(state_data$HHSIZE, state_data$avg_distance)
  
  # Store the result
  results <- rbind(results, data.frame(State = state, Correlation = corr))
}

#ggplot
library(ggplot2)

#plot
correlation_plot1 <- ggplot(results, aes(x = State, y = Correlation)) +
  geom_point() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        plot.title = element_text(hjust = 0.5)) +
  xlab("State Code") +
  ylab("Correlation Coefficient") +
  ggtitle("Correlation between Household Size and\nDistance Travelled, by State")

correlation_plot1

# Save the plot
ggsave("correlationplot1new.png", plot = correlation_plot1, width = 10, height = 6, units = "in")


##dplyr method

library(dplyr)

# Compute correlation coefficients
correlation_ds <- ds5 %>%
  group_by(HHSTATE) %>%
  summarize(Correlation = cor(HHSIZE, avg_distance, use = "complete.obs"))
  

# Plotting the results
correlation_plot2 <- ggplot(correlation_ds, aes(x = HHSTATE, y = Correlation)) +
  geom_point() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        plot.title = element_text(hjust = 0.5)) +
  xlab("State Code") +
  ylab("Correlation Coefficient") +
  ggtitle("Correlation between Household Size and\nDistance Travelled, by State")

correlation_plot2

# Save the plot
ggsave("correlationplot2new.png", plot = correlation_plot2, width = 10, height = 6, units = "in")

library(mongolite)
library(ggplot2)
library(dplyr)

# Establish a connection to the MongoDB server
mongo_url <- "mongodb://localhost:27017"
database_name <- "titanicDB"  
collection_name <- "titanic"  
mongo <- mongo(collection = collection_name, db = database_name, url = mongo_url)

# Fetch the data
titanic <- mongo$find('{}')
# print(titanic)
View(titanic)

# Check for missing values
sum(is.na(titanic))

# Remove rows with missing values
titanic <- na.omit(titanic)

# Check if missing values have been removed
sum(is.na(titanic))

# Set up factors.
titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Survived <- as.factor(titanic$Survived)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)

#
# What was the survival rate? 
#
dev.new()
ggplot(titanic, aes(x = Survived)) + 
  geom_bar()

prop.table(table(titanic$Survived))

dev.new()
ggplot(titanic, aes(x = Survived)) + 
  theme_bw() +
  geom_bar() +
  labs(y = "Passenger Count",
       title = "Titanic Survival Rates")


#
# What was the survival rate by gender? 
#
dev.new()
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  theme_bw() +
  geom_bar() +
  labs(y = "Passenger Count",
       title = "Titanic Survival Rates by Gender")


#
# What was the survival rate by class of ticket? 
#
dev.new()
ggplot(titanic, aes(x = Pclass, fill = Survived)) + 
  theme_bw() +
  geom_bar() +
  labs(y = "Passenger Count",
       title = "Titanic Survival Rates by Pclass")


#
# What was the survival rate by class of ticket
# and gender?
#
dev.new()
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  theme_bw() +
  facet_wrap(~ Pclass) +
  geom_bar() +
  labs(y = "Passenger Count",
       title = "Titanic Survival Rates by Pclass and Gender")

#
# What is the distribution of passenger ages?
#
dev.new()
# Convert the 'Age' column to numeric
titanic$Age <- as.numeric(as.character(titanic$Age))
str(titanic$Age)

ggplot(titanic, aes(x = Age)) +
  theme_bw() +
  geom_histogram(binwidth = 5) +
  labs(y = "Passenger Count",
       x = "Age (binwidth = 5)",
       title = "Titanic Age Distribution")

#
# What are the survival rates by age?
#
dev.new()
ggplot(titanic, aes(x = Age, fill = Survived)) +
  theme_bw() +
  geom_histogram(binwidth = 5) +
  labs(y = "Passenger Count",
       x = "Age (binwidth = 5)",
       title = "Titanic Survival Rates by Age")

dev.new()
ggplot(titanic, aes(x = Survived, y = Age)) +
  theme_bw() +
  geom_boxplot() +
  labs(y = "Age",
       x = "Survived",
       title = "Titanic Survival Rates by Age")


#
# What is the survival rates by age when segmented
# by gender and class of ticket?
#
# histograms
dev.new()
ggplot(titanic, aes(x = Age, fill = Survived)) +
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  geom_histogram(binwidth = 5) +
  labs(y = "Age",
       x = "Survived",
       title = "Titanic Survival Rates by Age, Pclass and Gender")

# Scatter Plot - Age vs. Fare
dev.new()
titanic$Fare <- as.numeric(as.character(titanic$Fare))
# Calculate the average fare
avg_fare <- mean(titanic$Fare, na.rm = TRUE)

# Create a new data frame with the average fare
avg_data <- data.frame(Age = unique(titanic$Age), Average_Fare = avg_fare)

# Create a scatter plot with the average fare on the y-axis
ggplot(titanic, aes(x = Age, y = Fare, color = Survived)) +
  geom_point() +
  geom_hline(yintercept = avg_fare, linetype = "dashed", color = "red") +  
  labs(x = "Age", y = "Fare", title = "Scatter Plot of Age vs. Fare with Average Fare Line")

# Count plot for 'Embarked' using ggplot2
dev.new()
unique(titanic$Embarked)
ggplot(titanic, aes(x = Embarked)) +
  geom_bar() +
  labs(x = "Embarked", y = "Count", title = "Count Plot of Embarked")

# Calculate the average age for each passenger class
avg_age_by_class <- titanic %>%
  group_by(Pclass) %>%
  summarise(Average_Age = mean(Age, na.rm = TRUE))

# Create a bar plot to visualize the average age by passenger class
dev.new()
ggplot(avg_age_by_class, aes(x = Pclass, y = Average_Age, fill = as.factor(Pclass))) +
  geom_bar(stat = "identity") +
  labs(x = "Passenger Class", y = "Average Age", title = "Average Age by Passenger Class") +
  theme_minimal()

mongo$disconnect()

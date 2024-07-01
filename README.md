# Titanic DataVisualization
This R script connects to a MongoDB server to fetch Titanic data, cleans it, and visualizes survival rates by gender, passenger class, and age distribution using `ggplot2`. It also includes plots of age vs. fare and average age by passenger class.

# Titanic Data Analysis with R

This repository contains an R script for analyzing the Titanic dataset using MongoDB, `ggplot2`, and `dplyr`. The script fetches data from a MongoDB collection, cleans it, and performs various visualizations to explore the survival rates and demographics of the Titanic passengers.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Data Analysis](#data-analysis)

## Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/titanic-data-analysis.git
    cd titanic-data-analysis
    ```

2. **Install required R packages**:
    ```R
    install.packages(c("mongolite", "ggplot2", "dplyr"))
    ```

3. **Set up MongoDB**:
    - Ensure MongoDB is installed and running on your local machine.
    - Import the Titanic dataset into a MongoDB collection named `titanic` in the `titanicDB` database.

## Usage

1. **Run the R script**:
    Open the `titanic_analysis.R` file in your R environment (e.g., RStudio) and execute the script.

2. **Script overview**:
    - Connects to a MongoDB server and fetches the Titanic data.
    - Cleans the data by removing rows with missing values.
    - Sets up factors for categorical variables.
    - Generates various plots to analyze survival rates and passenger demographics.

## Data Analysis

The script performs the following analyses:

- **Overall survival rate**: Bar plot and proportion table.
- **Survival rate by gender**: Bar plot segmented by gender.
- **Survival rate by ticket class**: Bar plot segmented by passenger class.
- **Survival rate by ticket class and gender**: Faceted bar plot.
- **Age distribution**: Histogram of passenger ages.
- **Survival rates by age**: Histogram and boxplot segmented by survival status.
- **Survival rates by age, gender, and ticket class**: Faceted histogram.
- **Scatter plot of age vs. fare**: Includes average fare line.
- **Count plot for 'Embarked'**: Bar plot of embarkation points.
- **Average age by passenger class**: Bar plot of average ages.

These materials make use of the data from Kaggle's [Titanic: Machine Learning from Disaster](https://www.kaggle.com/c/titanic) competition.

library(ggplot2)
# 1. Compute the covariance matrix & Compute the correlation matrix of the pairs
selected_cols <- c("Critic_Score", "User_Score", "NA_Sales", "JP_Sales", "Global_Sales")
subset_data <- Videogame_Sales_2016_Processed[selected_cols]

cor_matrix <- cor(subset_data)

print("Covariance Matrix:")
print(cov_matrix)

print("Correlation Matrix:")
print(cor_matrix)
# 2a. Scatter plot for Critic_Score vs. Critic_Count

plot(Videogame_Sales_2016_Processed$Critic_Score, Videogame_Sales_2016_Processed$Critic_Count,
     xlab = "Critic_Count", ylab = "Critic_Score", pch = 19,cex = 0.5,
     main = "Scatter Plot: Critic_Score vs. Critic_Count")

# 2b. Scatter plot for User_Score vs. Global_Sales with larger points
plot(Videogame_Sales_2016_Processed$User_Score, Videogame_Sales_2016_Processed$Global_Sales,
     xlab = "User_Score", ylab = "Global_Sales", pch = 19, cex = 0.5,
     main = "Scatter Plot: User_Score vs. Global_Sales")

#3. Histogram for User_Count (low, med, high) and platform
low_threshold <- 100
medium_threshold <- 1000
high_threshold <- 10665

low_target_data <- Videogame_Sales_2016_Processed[Videogame_Sales_2016_Processed$User_Count <= low_threshold, ]
medium_target_data <- Videogame_Sales_2016_Processed[Videogame_Sales_2016_Processed$User_Count > low_threshold & Videogame_Sales_2016_Processed$User_Count <= medium_threshold, ]
high_target_data <- Videogame_Sales_2016_Processed[Videogame_Sales_2016_Processed$User_Count > medium_threshold, ]

hist(low_target_data$User_Count, main = "Low Target User_Count Histogram", xlab = "User_Count")
hist(medium_target_data$User_Count, main = "Medium Target User_Count Histogram", xlab = "User_Count")
hist(high_target_data$User_Count, main = "High Target User_Count Histogram", xlab = "User_Count")

platform_counts <- table(Videogame_Sales_2016_Processed$Platform)
platform_df <- as.data.frame(platform_counts)

# Rename the columns for clarity (assuming the table has appropriate column names)
colnames(platform_df) <- c("Platform", "Frequency")

# Create a histogram
hist(platform_df$Frequency,
      main = "Histogram of Platform Frequencies",
      xlab = "Frequency",
      ylab = "Count")

#4. Box plot for User_Score / Critic_Score 

# Create separate data frames for each GS_category
low_category_data <- Videogame_Sales_2016_Processed[Videogame_Sales_2016_Processed$GS_Category == "low", ]
medium_category_data <- Videogame_Sales_2016_Processed[Videogame_Sales_2016_Processed$GS_Category == "medium", ]
high_category_data <- Videogame_Sales_2016_Processed[Videogame_Sales_2016_Processed$GS_Category == "high", ]

# Create box plots for User_Score and Critic_Score by GS_category
par(mfrow=c(2, 2))  # Set up a 2x2 grid for the plots

# Box plot for User_Score by GS_category
boxplot(User_Score ~ GS_Category, data = low_category_data, main = "User_Score by GS_category (Low)")
boxplot(User_Score ~ GS_Category, data = medium_category_data, main = "User_Score by GS_category (Medium)")
boxplot(User_Score ~ GS_Category, data = high_category_data, main = "User_Score by GS_category (High)")
boxplot(User_Score ~ GS_Category, data = Videogame_Sales_2016_Processed, main = "User_Score by GS_category")

# Box plot for Critic_Score by GS_category
boxplot(Critic_Score ~ GS_Category, data = low_category_data, main = "Critic_Score by GS_category (Low)")
boxplot(Critic_Score ~ GS_Category, data = medium_category_data, main = "Critic_Score by GS_category (Medium)")
boxplot(Critic_Score ~ GS_Category, data = high_category_data, main = "Critic_Score by GS_category (High)")
boxplot(Critic_Score ~ GS_Category, data = Videogame_Sales_2016_Processed, main = "Critic_Score by GS_category")

# Reset the layout to the default
par(mfrow=c(1, 1))

#5 supervised scatter plots

# Critic Score vs. NA Sales
ggplot(data = Videogame_Sales_2016_Processed, aes(x = Critic_Score, y = NA_Sales, color = GS_Category)) +
  geom_point() +
  labs(x = "Critic Score", y = "NA Sales", title = "Scatter Plot: Critic Score vs. NA Sales by GS_category") +
  scale_x_continuous(breaks = seq(0, 100, by = 10), limits = c(0, 100)) +  # Customize x-axis
  scale_y_continuous(breaks = seq(0, 16, by = 0.5), limits = c(0, 16))    # Customize y-axis

# NA Sales vs. User Score
ggplot(data = Videogame_Sales_2016_Processed, aes(x = User_Score, y = NA_Sales, color = GS_Category)) +
  geom_point() +
  labs(x = "User Score", y = "NA Sales", title = "Scatter Plot: NA Sales vs. User Score by GS_Category")

# Critic Score vs. User Score
ggplot(data = Videogame_Sales_2016_Processed, aes(x = Critic_Score, y = User_Score, color = GS_Category)) +
  geom_point() +
  labs(x = "Critic Score", y = "User Score", title = "Scatter Plot: Critic Score vs. User Score by GS_category")

#6 density plots 

# Create a density plot for Critic Score by GS_category
ggplot(data = Videogame_Sales_2016_Processed, aes(x = Critic_Score, fill = GS_Category)) +
  geom_density(alpha = 0.5) +
  labs(x = "Critic Score", y = "Density") +
  ggtitle("Density Plot: Critic Score by GS_category") +
  scale_fill_manual(values = c("low" = "red", "medium" = "green", "high" = "blue")) +
  theme_minimal()

# Create a density plot for User Score by GS_category
ggplot(data = Videogame_Sales_2016_Processed, aes(x = User_Score, fill = GS_Category)) +
  geom_density(alpha = 0.5) +
  labs(x = "User Score", y = "Density") +
  ggtitle("Density Plot: User Score by GS_category") +
  scale_fill_manual(values = c("low" = "red", "medium" = "green", "high" = "blue")) +
  theme_minimal()

#7

# Create a table of frequency counts for associations between genres and GS_Category
genre_gs_frequency <- table(Videogame_Sales_2016_Processed$Genre, Videogame_Sales_2016_Processed$GS_Category)

# Convert the table to a data frame for better presentation
genre_gs_frequency_df <- as.data.frame(genre_gs_frequency)

# Rename the columns for clarity
colnames(genre_gs_frequency_df) <- c("Genre", "GS_Category", "Frequency")

# Print the frequency table
print(genre_gs_frequency_df)

# Get unique GS_Category values
unique_categories <- unique(genre_gs_frequency_df$GS_Category)

# Create a separate histogram for each GS_Category
for (category in unique_categories) {
  category_data <- genre_gs_frequency_df[genre_gs_frequency_df$GS_Category == category, ]
  
  # Set the title for the histogram
  plot_title <- paste("Histogram of Global Sales by Genre (GS_Category:", category, ")")
  
  # Create the histogram
  hist(category_data$Frequency, main = plot_title, xlab = "Global Sales", ylab = "Frequency", col = "blue", border = "black")
  
  # Pause to allow viewing each histogram before moving to the next
  Sys.sleep(2)
}
#8 dataset for z-scores

# Create Z-scored attributes
Videogame_Sales_2016_Processed$Year_Z <- scale(Videogame_Sales_2016_Processed$Year_of_Release)
Videogame_Sales_2016_Processed$Critic_Score_Z <- scale(Videogame_Sales_2016_Processed$Critic_Score)
Videogame_Sales_2016_Processed$Critic_Count_Z <- scale(Videogame_Sales_2016_Processed$Critic_Count)
Videogame_Sales_2016_Processed$User_Score_Z <- scale(Videogame_Sales_2016_Processed$User_Score)
Videogame_Sales_2016_Processed$User_Count_Z <- scale(Videogame_Sales_2016_Processed$User_Count)

# Fit a linear regression model
lm_model <- lm(Global_Sales ~ Year_Z + Critic_Score_Z + Critic_Count_Z + User_Score_Z + User_Count_Z, data = Videogame_Sales_2016_Processed)

# Print the summary of the linear regression model
summary(lm_model)

# Assuming you have already fitted the linear model as "lm_model"

# Step 1: Get the R-squared value
r_squared <- summary(lm_model)$r.squared
cat("R-squared (R2) value of the linear model:", round(r_squared, 4), "\n")

# Step 2: Get the coefficients
coefficients <- coef(lm_model)
cat("Coefficients of the regression function:\n")
print(coefficients)


#9

# Load the necessary libraries
library(rpart)

# Split the dataset into training and testing sets (e.g., 80% training, 20% testing)
set.seed(123)  # Set seed for reproducibility
sample_index <- sample(1:nrow(Videogame_Sales_2016_Processed), 0.8 * nrow(Videogame_Sales_2016_Processed))
train_data <- Videogame_Sales_2016_Processed[sample_index, ]
test_data <- Videogame_Sales_2016_Processed[-sample_index, ]

# Define the formulas for the decision trees
formula1 <- GS_Category ~ NA_Sales + Critic_Score + Critic_Count + User_Count + User_Score
formula2 <- GS_Category ~ JP_Sales + Critic_Score + Critic_Count + User_Count + User_Score
formula3 <- GS_Category ~ EU_Sales + Critic_Score + Critic_Count + User_Count + User_Score

# Function to calculate accuracy
calculate_accuracy <- function(tree, data) {
  predictions <- predict(tree, data, type = "class")
  accuracy <- sum(predictions == data$GS_Category) / nrow(data)
  return(accuracy)
}

# Build and evaluate decision trees for each formula
tree1 <- rpart(formula1, data = train_data, control = rpart.control(cp = 0.02, maxdepth = 20))
tree2 <- rpart(formula2, data = train_data, control = rpart.control(cp = 0.02, maxdepth = 20))
tree3 <- rpart(formula3, data = train_data, control = rpart.control(cp = 0.02, maxdepth = 20))

# Calculate training and testing accuracies for each tree
train_accuracy1 <- calculate_accuracy(tree1, train_data)
test_accuracy1 <- calculate_accuracy(tree1, test_data)

train_accuracy2 <- calculate_accuracy(tree2, train_data)
test_accuracy2 <- calculate_accuracy(tree2, test_data)

train_accuracy3 <- calculate_accuracy(tree3, train_data)
test_accuracy3 <- calculate_accuracy(tree3, test_data)

# Print the accuracies
cat("Decision Tree 1:\n")
cat("Training Accuracy:", train_accuracy1, "\n")
cat("Testing Accuracy:", test_accuracy1, "\n\n")

cat("Decision Tree 2:\n")
cat("Training Accuracy:", train_accuracy2, "\n")
cat("Testing Accuracy:", test_accuracy2, "\n\n")

cat("Decision Tree 3:\n")
cat("Training Accuracy:", train_accuracy3, "\n")
cat("Testing Accuracy:", test_accuracy3, "\n")

plot(tree1)
text(tree1, use.n = TRUE, all = TRUE, cex = 0.8)

plot(tree2)
text(tree2, use.n = TRUE, all = TRUE, cex = 0.8)

plot(tree3)
text(tree3, use.n = TRUE, all = TRUE, cex = 0.8)











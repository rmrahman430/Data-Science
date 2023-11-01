#1A. ) 
# Load the necessary library
library(rpart)

# Split the data into training and testing sets (70% training, 30% testing)
set.seed(123)  # for reproducibility
splitIndex <- sample(1:nrow(loan_approval_processed), 0.7 * nrow(loan_approval_processed))
train_data <- loan_approval_processed[splitIndex, ]
test_data <- loan_approval_processed[-splitIndex, ]

# Create a list to store models
models <- list()

# Train Decision Tree models with different maximum depths
max_depths <- c(3, 7, 11, 15)

for (depth in max_depths) {
  # Create a Decision Tree model with the specified max depth
  model <- rpart(
    loan_status ~ .,  # Use 'loan_status' as the target variable
    data = train_data, 
    method = "class",  # for classification
    control = rpart.control(maxdepth = depth)
  )
  
  # Store the model in the list
  models[[as.character(depth)]] <- model
}

# Generate Decision Tree visualizations using plot() and text()
for (depth in max_depths) {
  model <- models[[as.character(depth)]]
  
  # Create a plot without axes
  plot(model, uniform = TRUE, branch = 0.5, cex = 0.8)
  
  # Add text labels to the plot
  text(model, use.n = TRUE, all = TRUE, cex = 0.6)
  
  # Print the depth as a title
  title(main = paste("Decision Tree (Max Depth:", depth, ")"))
}

# Calculate precision and recall for different models on the test data
for (depth in max_depths) {
  model <- models[[as.character(depth)]]
  predictions <- predict(model, newdata = test_data, type = "class")
  accuracy <- sum(predictions == test_data$loan_status) / length(predictions)
  
  # Create a confusion matrix
  confusion_matrix <- table(predictions, test_data$loan_status)
  
  # Calculate precision and recall
  true_positives <- confusion_matrix[2, 2]
  false_positives <- confusion_matrix[1, 2]
  false_negatives <- confusion_matrix[2, 1]
  
  precision <- true_positives / (true_positives + false_positives)
  recall <- true_positives / (true_positives + false_negatives)
  
  cat("Max Depth:", depth, "Accuracy:", accuracy, "Precision:", precision, "Recall:", recall, "\n")
}

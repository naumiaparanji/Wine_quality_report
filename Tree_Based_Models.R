# Loading the required packages for the models
library(tree)
library(randomForest)

# Read dataset and display summary statistics
dataset <- read.csv("winequality-red.csv")
summary(dataset)

# Splitting data into train and test sets
set.seed(1)
sample <- sample(nrow(dataset), nrow(dataset) * 0.80)
train <- dataset[sample,]
test <- dataset[-sample,]

# Function to calculate R^2
calc_r_squared <- function(actual, predicted) {
  ssr <- sum((actual - predicted)^2)  # Sum of squared residuals
  tss <- sum((actual - mean(actual))^2)  # Total sum of squares
  return(1 - (ssr / tss))  # R^2 formula
}

# Function to calculate MSE
calc_mse <- function(actual, predicted) {
  return(mean((actual - predicted)^2))  # Mean Squared Error formula
}

# Build a decision tree
tree <- tree(quality ~ ., data = train)
summary(tree)

# Plot the decision tree
plot(tree)
text(tree, pretty = 1)

# Predict and calculate R^2 & MSE for the decision tree
prediction.original <- predict(tree, test)
r_squared <- calc_r_squared(test$quality, prediction.original)
mse.original <- calc_mse(test$quality, prediction.original)

# Print results for original tree
print(paste("R^2 (Original Tree):", r_squared))
print(paste("MSE (Original Tree):", mse.original))

# Build a pruned tree
cv <- cv.tree(tree, FUN = prune.tree)
plot(cv$size, cv$dev, type = "b")

tree.pruned <- prune.tree(tree, best = 7)
summary(tree.pruned)

# Plot the pruned tree
plot(tree.pruned)
text(tree.pruned)

# Predict and calculate R^2 & MSE for the pruned tree
prediction.pruned <- predict(tree.pruned, test)
r_squared <- calc_r_squared(test$quality, prediction.pruned)
mse.pruned <- calc_mse(test$quality, prediction.pruned)

# Print results for pruned tree
print(paste("R^2 (Pruned Tree):", r_squared))
print(paste("MSE (Pruned Tree):", mse.pruned))

# Build a Bagged tree model (using the random forest function with mtry = number of predictors)
bagged.model <- randomForest(quality ~ ., data = train, mtry = ncol(dataset) - 1, importance = TRUE)

# Display Bagged model details and plot
print(bagged.model)
plot(bagged.model)

# Print importance of features for Bagged model
print(importance(bagged.model))

# Predict and calculate R^2 & MSE for the Bagged model
prediction.bagged.model <- predict(bagged.model, test)
r_squared <- calc_r_squared(test$quality, prediction.bagged.model)
mse.bagged.model <- calc_mse(test$quality, prediction.bagged.model)

# Print results for Bagged model
print(paste("R^2 (Bagged Model):", r_squared))
print(paste("MSE (Bagged Model):", mse.bagged.model))

# Build a random forest model
set.seed(1)
random.forest <- randomForest(
  quality ~ .,
  data = train,
  ntree = 500,
  mtry = 3,
  importance = TRUE 
)

# Plotting the importance of variables in the random forest
varImpPlot(random.forest)

# Predict and calculate R^2 & MSE for the random forest model
prediction.random.forest <- predict(random.forest, test)
r_squared <- calc_r_squared(test$quality, prediction.random.forest)
mse.random.forest <- calc_mse(test$quality, prediction.random.forest)

# Print results for random forest
print(paste("R^2 (Random Forest):", r_squared))
print(paste("MSE (Random Forest):", mse.random.forest))

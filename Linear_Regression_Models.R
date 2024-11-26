#-----------------------------------------------------------------------

#Install any necessary packages
install.packages()

# Read dataset and display summary statistics, adjust the path accordingly
winedata <- read.csv("/winequality-red.csv")
View(winedata)

#-----------------------------------------------------------------------

#Base model construction with all predictor variables included
wine_model <- lm(quality ~ ., data=winedata)
summary(wine_model)

# Code to plot p-value vs predictor variables to understand significance
# Step 1: Extract coefficients summary
coef_summary <- summary(wine_model)$coefficients
# Step 2: Create a data frame with variables and their p-values
p_values <- data.frame(
    Variable = rownames(coef_summary),
    P_Value = coef_summary[, "Pr(>|t|)"]
)
# Step 3: Exclude intercept for cleaner visualization
p_values <- p_values[p_values$Variable != "(Intercept)", ]
# Step 4: Remove rows with missing p-values (if any)
p_values <- p_values[!is.na(p_values$P_Value), ]
# Step 5: Add a column to highlight statistically significant variables
p_values$Significant <- ifelse(p_values$P_Value < 0.05, "Significant", "Not Significant")
# Step 6: Sort variables for easier debugging (optional)
p_values <- p_values[order(p_values$P_Value), ]
# Step 7: Create the plot
library(ggplot2)
ggplot(p_values, aes(x = reorder(Variable, P_Value), y = -log10(P_Value), fill = Significant)) +
    geom_bar(stat = "identity") +
    scale_fill_manual(values = c("Significant" = "red", "Not Significant" = "steelblue")) +
    geom_text(aes(label = ifelse(P_Value < 0.01, sprintf("%.2e", P_Value), "")), hjust = -0.2) +
    labs(
        title = "P-Values of Variables in the Model",
        x = "Variables",
        y = "-log10(P-Value)"
    ) +
    theme_minimal() +
    coord_flip()

# Calculate MSE for the base model
residuals2 <- wine_model$residuals
mse2 <- mean(residuals2^2)
print(mse2)

#-----------------------------------------------------------------------

# Pruned model construction
refined_model <- lm(quality ~ volatile.acidity + chlorides + free.sulfur.dioxide + total.sulfur.dioxide + pH + sulphates + alcohol, data = winedata)
summary(refined_model)

# Get the necessary LINE plots
par(mfrow = c(2, 2))
plot(refined_model)

# Calculate MSE for the refined model
residuals <- refined_model$residuals
mse <- mean(residuals^2)
print(mse)

#-----------------------------------------------------------------------
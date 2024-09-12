########################################################(Group 14 )########################################

# Load necessary libraries
library(dplyr)
library(ggplot2)
library(corrplot)

# Load the data
load('PRISON.RData')

# Convert the loaded data to a dataframe
data_df <- as.data.frame(data)

###################################################( Data Exploration and Visualization)####################

# Histogram of crime rate (criv)
ggplot(data_df, aes(x = criv)) +
  geom_histogram(fill = "skyblue", color = "black") +
  ggtitle("Distribution of Crime Rate (criv)")

# Time series plot of crime rate (criv) over years
ggplot(data_df, aes(x = year, y = criv)) +
  geom_line() +
  ggtitle("Crime Rate (criv) Over Time") +
  xlab("Year") +
  ylab("Crime Rate")

# Scatter plot: Crime rate (criv) vs. Unemployment rate (unem)
ggplot(data_df, aes(x = unem, y = criv)) +
  geom_point(color = "blue") +
  ggtitle("Crime Rate vs. Unemployment Rate") +
  xlab("Unemployment Rate") +
  ylab("Crime Rate")

# Selecting necessary variables for correlation matrix
selected_vars <- c("criv", "crip", "unem", "black", "metro", 
                   "ag0_14", "ag15_17", "ag18_24", "ag25_34",
                   "incpc", "polpc", "pris", "final1", "final2", "govelec", "year")

# Subsetting the data to include only selected variables
selected_data <- data_df[, selected_vars]

# Correlation heatmap
correlation_matrix <- cor(selected_data)
corrplot(correlation_matrix, method = "color", type = "upper", order = "hclust", 
         tl_col = "black", tl_srt = 45, addCoef.col = "black", 
         title = "Correlation Matrix")


####################################################### (Crime Rate Determination Model)####################


# Load necessary libraries
library(car)    # for vif() function
library(MASS)   # for stepAIC() function

# Define the dependent variable
dependent_variable <- "criv"  # You can change this to "crip" if interested in property crimes

# Define all potential independent variables
potential_independent_vars <- c("pris", "state" , "year" , "black", "unem", "incpc", "polpc", "govelec", "metro")

##### Stepwise Model Selection Based on AIC #####

# Prepare the formula
formula_str <- paste(dependent_variable, "~", paste(potential_independent_vars, collapse = " + "))
full_formula <- as.formula(formula_str)

# Fit initial model
initial_model <- lm(full_formula, data = data)

# Stepwise model selection based on AIC
stepwise_model <- stepAIC(initial_model, direction = "both")
summary(stepwise_model)

##### Multicollinearity Check #####

# Check for multicollinearity
vif_results <- vif(stepwise_model)
print(vif_results)  # Print VIF results

# Filter variables with VIF less than 5 (or another threshold you choose)
selected_vars <- names(vif_results[vif_results < 5])

##### Final Model Selection #####

# Final model with selected variables
final_formula_str <- paste(dependent_variable, "~", paste(selected_vars, collapse = " + "))
final_model <- lm(as.formula(final_formula_str), data = data)
summary(final_model)

##### Log-Transformed Variables #####

# Adding log-transformed variables
data$log_pris = log(data$pris + 1)
data$log_incpc = log(data$incpc + 1)
data$log_polpc = log(data$polpc + 1)

# Update the formula to include log-transformed variables
updated_formula_str <- "criv ~ log_pris + state + year + black + unem + log_incpc + log_polpc + metro"
updated_model <- lm(as.formula(updated_formula_str), data = data)
summary(updated_model)

##### Interaction Term #####

# Adding an interaction term between 'metro' and 'log_pris'
interaction_formula_str <- "criv ~ log_pris * metro + state + year + black + unem + log_incpc + log_polpc"
interaction_model <- lm(as.formula(interaction_formula_str), data = data)
summary(interaction_model)

##### Quadratic Term #####

# Adding a quadratic term for 'log_pris'
polynomial_formula_str <- "criv ~ log_pris + I(log_pris^2) + state + year + black + unem + log_incpc + log_polpc + metro"
polynomial_model <- lm(as.formula(polynomial_formula_str), data = data)
summary(polynomial_model)

##### Check VIF for the New Model #####

library(car)  # make sure 'car' library is loaded for vif()
vif_results <- vif(interaction_model, type = 'predictor')  # replace 'interaction_model' with your chosen model
print(vif_results)


##### Final Model Selection Based on the Above Explorations #####

# Final model selection based on the above explorations
final_model1 <- interaction_model  # or whichever model you find best
summary(final_model)

############################################################################################################################

# Load necessary libraries
library(plm)

# Convert the loaded data to a pdata.frame for panel data analysis
pdata_df <- pdata.frame(data, index = c("state", "year"))

##### Fixed Effects Model #####

# Fixed Effects Model
fixed_effects_model <- plm(criv ~ unem + polpc + incpc + metro + pris, data = pdata_df, model = "within")
summary(fixed_effects_model)

##### Random Effects Model #####

# Random Effects Model
random_effects_model <- plm(criv ~ unem + polpc + incpc + metro + pris, data = pdata_df, model = "random")
summary(random_effects_model)

##### Conduct Hausman Test #####

# Conduct Hausman Test
hausman_test <- phtest(fixed_effects_model, random_effects_model)
print(hausman_test)

# Breusch-Pagan LM test for heteroscedasticity
bptest(random_effects_model)

##########################################################################

rm(list = ls())
# Load necessary libraries
library(dplyr)
library(ggplot2)
library(corrplot)
library(haven)

# Load the data
load('PRISON.RData')

# Convert the loaded data to a dataframe
data_df <- as.data.frame(data)

model1 <- lm(gcriv ~ gpris + gpolpc + gincpc + cunem + cblack + cmetro + cag0_14 + cag15_17 + cag18_24 + cag25_34 + y81 + y82 + y83 + y84 + y85 + y86 + y87 + y88 + y89 + y90 + y91 + y92 + y93, data = data_df)
summary(model1)
##########################################################################
model2 <- lm(gpris ~ final1 + final2 + gincpc + gpolpc + cag0_14 +
               cag15_17 + cag18_24 + cag25_34 + cunem + cblack + 
               cmetro + y81 + y82 + y83 + y84 + y85 + y86 + y87 +
               y88 + y89 + y90 + y91 + y92 + y93, data = data_df)
summary(model2)
#########################################################################
model_2sls <- ivreg(gcriv ~ gpris + gincpc + gpolpc + cag0_14 + cag15_17 +
                      cag18_24 + cag25_34 + cunem + cblack + cmetro + y81 +
                      y82 + y83 + y84 + y85 + y86 + y87 + y88 + y89 + y90 + 
                      y91 + y92 + y93 | 
                      final1 + final2 + gincpc + gpolpc + cag0_14 +
                      cag15_17 + cag18_24 + cag25_34 + cunem + cblack + 
                      cmetro + y81 + y82 + y83 + y84 + y85 + y86 + y87 +
                      y88 + y89 + y90 + y91 + y92 + y93, data = data_df)
summary(model_2sls)
#######################################################################
# Calculate robust standard errors
robust_se <- vcovHC(model_2sls, type = "HC1")  # HC1 is one commonly used type of robust SE

# View the coefficients with robust standard errors
coeftest(model_2sls, robust_se)
#######################################################################

data <- data_df %>%  mutate(diff_final1 = final1 - lag(final1),  # Difference from the previous row for final1    
                            diff_final2 = final2 - lag(final2))   # Difference from the previous row for final2
head(data)

model3 <- lm(gpris ~ diff_final1 + diff_final2 + gincpc + gpolpc + cag0_14 +
               cag15_17 + cag18_24 + cag25_34 + cunem + cblack + 
               cmetro + y81 + y82 + y83 + y84 + y85 + y86 + y87 +
               y88 + y89 + y90 + y91 + y92 + y93, data = data)
summary(model3)


################################################################################################################################


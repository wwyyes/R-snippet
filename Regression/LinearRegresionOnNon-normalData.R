# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 
# ?glm
# glm(formula, 
#    family = gaussian, # One of the following strings, indicating the link function for the general linear model: c("binomial", "gaussian", "Gamma", "inverse.gaussian", "poisson")
#    data, weights, subset,
#    na.action, start = NULL, etastart, mustart, offset,
#    control = list(...), model = TRUE, method = "glm.fit",
#    x = FALSE, y = TRUE, singular.ok = TRUE, contrasts = NULL, ...)

# We can use standard regression with lm()when your dependent variable is Normally distributed (more or less).
# When your dependent variable does not follow a nice bell-shaped Normal distribution, you need to use the Generalized Linear Model (GLM). 
# the GLM is a more general class of linear models that change the distribution of your dependent variable. 
# In other words, it allows you to use the linear model even when your dependent variable isn’t a normal bell-shape. 
# Here are 4 of the most common distributions you can can model with glm()
# - "binomial": Binary logistic regression, useful when the response is either 0 or 1.
# - "gaussian": Standard linear regression. Using this family will give you the same result as lm()
# - "Gamma": Gamma regression, useful for highly positively skewed data
# - "inverse.guassian": Inverse-Gaussian regression, useful when the dv is strictly positive and skewed to the right.
# - "poisson": Poisson regression, useful for count data. For example, How many parrots has a pirate owned over his/her lifetime?“

# ---------------- Logistic regression with glm(family = "binomial") -------------------- #
# The most common non-normal regression analysis is logistic regression, where your dependent variable is just 0 and 1.
# To do a logistic regression analysis with glm(), use the family = 'binomial'


# Code 
# Create a binary variable indicating whether or not
#   a diamond's value is greater than 190
diamonds$value.g190 <- diamonds$value > 190

# Conduct a logistic regression on the new binary variable
diamond.glm <- glm(formula = value.g190 ~ weight + clarity + color,
                   data = diamonds,
                   family = binomial)

# Print coefficients from logistic regression
summary(diamond.glm)$coefficients
##             Estimate Std. Error z value  Pr(>|z|)
## (Intercept) -18.8009     3.4634  -5.428 5.686e-08
## weight        1.1251     0.1968   5.716 1.088e-08
## clarity       9.2910     1.9629   4.733 2.209e-06
## color        -0.3836     0.2481  -1.547 1.220e-01

# Add logistic fitted values back to dataframe as
#  new column pred.g190
diamonds$pred.g190 <- diamond.glm$fitted.values

# Look at the first few rows (of the named columns)
head(diamonds[c("weight", "clarity", "color", "value", "pred.g190")])
##   weight clarity color value pred.g190
## 1   9.35    0.88     4 182.5   0.16252
## 2  11.10    1.05     5 191.2   0.82130
## 3   8.65    0.85     6 175.7   0.03008
## 4  10.43    1.15     5 195.2   0.84559
## 5  10.62    0.92     5 181.6   0.44455
## 6  12.35    0.44     4 182.9   0.08688


# Predict the 'probability' that the 3 new diamonds 
#  will have a value greater than 190

predict(object = diamond.glm,
        newdata = diamonds.new)
##       1       2       3 
##  4.8605 -3.5265 -0.3898
# Note!! These are logit-transformed probabilities, need use the inverse logit function to transform them into probabilities

# Get logit predictions of new diamonds
logit.predictions <- predict(object = diamond.glm,
                             newdata = diamonds.new
                             )

# Apply inverse logit to transform to probabilities
#  (See Equation in the margin)
prob.predictions <- 1 / (1 + exp(-logit.predictions))

# Print final predictions!
prob.predictions
##       1       2       3 
## 0.99231 0.02857 0.40376

# -------------------- Adding a regression line to a plot --------------------- #
# Scatterplot of diamond weight and value
plot(x = diamonds$weight,
     y = diamonds$value,
     xlab = "Weight",
     ylab = "Value",
     main = "Adding a regression line with abline()"
     )

# Calculate regression model
diamonds.lm <- lm(formula = value ~ weight,
                  data = diamonds)

# Add regression line
abline(diamonds.lm,
       col = "red", lwd = 2)

# ------------------ Transforming skewed variables prior to standard regression ---------------------- #
# For example: The distribution of movie revenus is highly skewed
hist(movies$revenue.all, 
     main = "Movie revenue\nBefore log-transformation")

  
# If you have a highly skewed variable that you want to include in a regression analysis, you can do one of two things. 
# Option1 : use the general linear model glm() with an appropriate family (like family = "gamma")

# Option2 : do a standard regression analysis with lm(), but before doing so, transforming the variable into something less skewed. For highly skewed data, the most common transformation is a log-transformation

# Create a new log-transformed version of movie revenue
movies$revenue.all.log <- log(movies$revenue.all)

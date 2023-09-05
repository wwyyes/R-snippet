# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 

# -----------  Linear regression with lm() -------------------- #

# Data: 

library(yarrr)
head(diamonds)
##   weight clarity color value value.lm weight.c clarity.c value.g190
## 1    9.3    0.88     4   182      186    -0.55     -0.12      FALSE
## 2   11.1    1.05     5   191      193     1.20      0.05       TRUE
## 3    8.7    0.85     6   176      183    -1.25     -0.15      FALSE
## 4   10.4    1.15     5   195      194     0.53      0.15       TRUE
## 5   10.6    0.92     5   182      189     0.72     -0.08      FALSE
## 6   12.3    0.44     4   183      183     2.45     -0.56      FALSE
##   pred.g190
## 1     0.163
## 2     0.821
## 3     0.030
## 4     0.846
## 5     0.445
## 6     0.087



# Goal: 
# is to come up with a linear model we can use to estimate the value of each diamond (DV = value) as a linear combination of three independent variables: its weight, clarity, and color. 
# The linear model will estimate each diamond’s value using the following equation:

#    βInt + βweight × weight + βclarity × clarity + βcolor × color

# where βweightis the increase in value for each increase of 1 in weight, βclarity is the increase in value for each increase of 1 in clarity (etc.). 
# Finally, βInt is the baseline value of a diamond with a value of 0 in all independent variables.



# Code:

# Create a linear model of diamond values
#   DV = value, IVs = weight, clarity, color

diamonds.lm <- lm(formula = value ~ weight + clarity + color,
                  data = diamonds)


# Print summary statistics from diamond model
summary(diamonds.lm)
## 
## Call:
## lm(formula = value ~ weight + clarity + color, data = diamonds)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -10.405  -3.547  -0.113   3.255  11.046 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  148.335      3.625   40.92   <2e-16 ***
## weight         2.189      0.200   10.95   <2e-16 ***
## clarity       21.692      2.143   10.12   <2e-16 ***
## color         -0.455      0.365   -1.25     0.21    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 4.7 on 146 degrees of freedom
## Multiple R-squared:  0.637,  Adjusted R-squared:  0.63 
## F-statistic: 85.5 on 3 and 146 DF,  p-value: <2e-16


# The coefficients in the diamond model
diamonds.lm$coefficients
## (Intercept)      weight     clarity       color 
##    148.3354      2.1894     21.6922     -0.4549


# Coefficient statistics in the diamond model - access the entire statistical summary table of the coefficients
summary(diamonds.lm)$coefficients
##             Estimate Std. Error t value  Pr(>|t|)
## (Intercept) 148.3354     3.6253  40.917 7.009e-82
## weight        2.1894     0.2000  10.948 9.706e-21
## clarity      21.6922     2.1429  10.123 1.411e-18
## color        -0.4549     0.3646  -1.248 2.141e-01


# Add the fitted values as a new column in the dataframe
diamonds$value.lm <- diamonds.lm$fitted.values

# Show the result
head(diamonds)
##   weight clarity color value value.lm weight.c clarity.c value.g190
## 1   9.35    0.88     4 182.5    186.1  -0.5511   -0.1196      FALSE
## 2  11.10    1.05     5 191.2    193.1   1.1989    0.0504       TRUE
## 3   8.65    0.85     6 175.7    183.0  -1.2511   -0.1496      FALSE
## 4  10.43    1.15     5 195.2    193.8   0.5289    0.1504       TRUE
## 5  10.62    0.92     5 181.6    189.3   0.7189   -0.0796      FALSE
## 6  12.35    0.44     4 182.9    183.1   2.4489   -0.5596      FALSE
##   pred.g190
## 1   0.16252
## 2   0.82130
## 3   0.03008
## 4   0.84559
## 5   0.44455
## 6   0.08688


# Plot the relationship between true diamond values
#   and linear model fitted values

plot(x = diamonds$value,                          # True values on x-axis
     y = diamonds.lm$fitted.values,               # fitted values on y-axis
     xlab = "True Values",
     ylab = "Model Fitted Values",
     main = "Regression fits of diamond values")

abline(b = 1, a = 0)                             # Values should fall around this line!


# Using predict() to predict new data from a model
# Once you have created a regression model with lm(), you can use it to easily predict results from new datasets using the predict() function.
# Create a dataframe of new diamond data
diamonds.new <- data.frame(weight = c(12, 6, 5),
                           clarity = c(1.3, 1, 1.5),
                           color = c(5, 2, 3))

# Predict the value of the new diamonds using
#  the diamonds.lm regression model
predict(object = diamonds.lm,     # The regression model
        newdata = diamonds.new)   # dataframe of new data
##     1     2     3 
## 200.5 182.3 190.5




# ------------ Add interactions in the model ------------------- #
# To include interaction terms in a regression model, just put an asterix (*) between the independent variables. 
# For example, to create a regression model on the diamonds data with an interaction term between weight and clarity, we’d use the formula formula = value ~ weight * clarity
# !!! Center variables before computing interactions

# Create centered versions of weight and clarity
diamonds$weight.c <- diamonds$weight - mean(diamonds$weight)
diamonds$clarity.c <- diamonds$clarity - mean(diamonds$clarity)

# Create a regression model with interactions of centered variables
diamonds.int.lm <- lm(formula = value ~ weight.c * clarity.c,
                      data = diamonds)

# Print summary
summary(diamonds.int.lm)$coefficients
##                    Estimate Std. Error t value   Pr(>|t|)
## (Intercept)         189.402     0.3831  494.39 2.908e-237
## weight.c              2.223     0.1988   11.18  2.322e-21
## clarity.c            22.248     2.1338   10.43  2.272e-19
## weight.c:clarity.c    1.245     1.0551    1.18  2.401e-01




# ----------- Getting an ANOVA from a regression model with aov() --------------- #
# Once you’ve created a regression object with lm() or glm(), you can summarize the results in an ANOVA table with aov()
# Create ANOVA object from regression
diamonds.aov <- aov(diamonds.lm)

# Print summary results
summary(diamonds.aov)
##              Df Sum Sq Mean Sq F value Pr(>F)    
## weight        1   3218    3218  147.40 <2e-16 ***
## clarity       1   2347    2347  107.53 <2e-16 ***
## color         1     34      34    1.56   0.21    
## Residuals   146   3187      22                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


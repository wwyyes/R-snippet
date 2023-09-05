# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 
# A good model needs to fit data well, but also needs to avoid overfitting. That means it needs to be parsimonious. 
# If you are choosing between a very simple model with 1 IV, and a very complex model with, say, 10 IVs, the very complex model needs to provide a much better fit to the data in order to justify its increased complexity. 
# If it can’t, then the more simpler model should be preferred.

# How:
# To compare the fits of two models, you can use the anova() function with the regression objects as two separate arguments. 
# The anova() function will take the model objects as arguments, and return an ANOVA testing whether the more complex model is significantly better at capturing the data than the simpler model. 
# If the resulting p-value is sufficiently low (usually less than 0.05), we conclude that the more complex model is significantly better than the simpler model, and thus favor the more complex model. 
# If the p-value is not sufficiently low (usually greater than 0.05), we should favor the simpler model.

# Example:


# Create three regression models that each predict a diamond’s value. 
# The models will differ in their complexity – that is, the number of independent variables they use. 
# diamonds.mod1 will be the simplest model with just one IV (weight); 
# diamonds.mod2 will include 2 IVs (weight and clarity);
# diamonds.mod3 will include three IVs (weight, clarity, and color).

# model 1: 1 IV (only weight)
 diamonds.mod1 <- lm(value ~ weight, data = diamonds)

 # Model 2: 2 IVs (weight AND clarity)
 diamonds.mod2 <- lm(value ~ weight + clarity, data = diamonds)

 # Model 3: 3 IVs (weight AND clarity AND color)
 diamonds.mod3 <- lm(value ~ weight + clarity + color, data = diamonds)


# use the anova() function to compare these models and see which one provides the best parsimonious fit of the data
# Compare model 1 to model 2
anova(diamonds.mod1, diamonds.mod2)
## Analysis of Variance Table
## 
## Model 1: value ~ weight
## Model 2: value ~ weight + clarity
##   Res.Df  RSS Df Sum of Sq   F Pr(>F)    
## 1    148 5569                            
## 2    147 3221  1      2347 107 <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# the result shows a Df of 1 (indicating that the more complex model has one additional parameter), and a very small p-value (< .001). 
# This means that adding the clarity IV to the model did lead to a significantly improved fit over the model 1

# Compare model 2 to model 3
anova(diamonds.mod2, diamonds.mod3)
## Analysis of Variance Table
## 
## Model 1: value ~ weight + clarity
## Model 2: value ~ weight + clarity + color
##   Res.Df  RSS Df Sum of Sq    F Pr(>F)
## 1    147 3221                         
## 2    146 3187  1        34 1.56   0.21
# The result shows a non-significant result (p = 0.21). Thus, we should reject model 3 and stick with model 2 with only 2 IVs.

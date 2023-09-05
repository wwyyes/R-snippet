# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 

# -------------------- No interaction between independent variables ------------------------------ #
# conduct a two-way ANOVA with both cleaner and type as independent variables. To do this, we’ll set formula = time ~ cleaner + type

# Step 1: Create ANOVA object with aov()
cleaner.type.aov <- aov(formula = time ~ cleaner + type,
                        data = poopdeck)


# Step 2: Get ANOVA table with summary()
summary(cleaner.type.aov)
##              Df Sum Sq Mean Sq F value Pr(>F)    
## cleaner       2   6057    3028    6.94  0.001 ** 
## type          1  81620   81620  187.18 <2e-16 ***
## Residuals   596 259891     436                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# It looks like we found significant effects of both independent variables.


# Step 3: Conduct post-hoc tests
TukeyHSD(cleaner.type.aov)
##   Tukey multiple comparisons of means
##     95% family-wise confidence level
## 
## Fit: aov(formula = time ~ cleaner + type, data = poopdeck)
## 
## $cleaner
##      diff   lwr  upr p adj
## b-a -0.42  -5.3  4.5  0.98
## c-a -6.94 -11.8 -2.0  0.00
## c-b -6.52 -11.4 -1.6  0.01
## 
## $type
##              diff lwr upr p adj
## shark-parrot   23  20  27     0
# The only non-significant group difference we found is between cleaner b and cleaner a. All other comparisons were significant.


# Step 4: Look at regression coefficients
cleaner.type.lm <- lm(formula = time ~ cleaner + type,
                      data = poopdeck)

summary(cleaner.type.lm)
## 
## Call:
## lm(formula = time ~ cleaner + type, data = poopdeck)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -59.74 -13.79  -0.68  13.58  83.58 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    54.36       1.71   31.88  < 2e-16 ***
## cleanerb       -0.42       2.09   -0.20  0.84067    
## cleanerc       -6.94       2.09   -3.32  0.00094 ***
## typeshark      23.33       1.71   13.68  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 21 on 596 degrees of freedom
## Multiple R-squared:  0.252,  Adjusted R-squared:  0.248 
## F-statistic:   67 on 3 and 596 DF,  p-value: <2e-16
# Now we need to interpret the results in respect to two default values (here, cleaner = a and type = parrot). 
# The intercept means that the average time for cleaner a on parrot poop was 54.36 minutes. 
# Additionally, the average time to clean shark poop was 23.33 minutes slower than when cleaning parrot poop.




# -------------------- Interaction between independent variables ------------------------------ #
# Interactions between variables test whether or not the effect of one variable depends on another variable. 
# For example: Does the effect of cleaners depend on the type of poop they are used to clean? 
# To include interaction terms in an ANOVA, just use an asterix (*) instead of the plus (+) between the terms in your formula. 
# Note that when you include an interaction term in a regression object, R will automatically include the main effects as well

# Step 1: Create ANOVA object with interactions
cleaner.type.int.aov <- aov(formula = time ~ cleaner * type,
                          data = poopdeck)


# Step 2: Look at summary table
summary(cleaner.type.int.aov)
##               Df Sum Sq Mean Sq F value  Pr(>F)    
## cleaner        2   6057    3028    7.82 0.00044 ***
## type           1  81620   81620  210.86 < 2e-16 ***
## cleaner:type   2  29968   14984   38.71 < 2e-16 ***
## Residuals    594 229923     387                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


# Step 4: Calculate regression coefficients
cleaner.type.int.lm <- lm(formula = time ~ cleaner * type,
                          data = poopdeck)

summary(cleaner.type.int.lm)
## 
## Call:
## lm(formula = time ~ cleaner * type, data = poopdeck)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -54.28 -12.83  -0.08  12.29  74.87 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)           45.76       1.97   23.26  < 2e-16 ***
## cleanerb               8.06       2.78    2.90  0.00391 ** 
## cleanerc              10.37       2.78    3.73  0.00021 ***
## typeshark             40.52       2.78   14.56  < 2e-16 ***
## cleanerb:typeshark   -16.96       3.93   -4.31  1.9e-05 ***
## cleanerc:typeshark   -34.62       3.93   -8.80  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 20 on 594 degrees of freedom
## Multiple R-squared:  0.338,  Adjusted R-squared:  0.333 
## F-statistic: 60.8 on 5 and 594 DF,  p-value: <2e-16
# To interpret this table, we first need to know what the default values are. 
# We can tell this from the coefficients that are ‘missing’ from the table. 
# Because I don’t see terms for cleanera or typeparrot, this means that cleaner = "a" and type = "parrot" are the defaults. 

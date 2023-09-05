# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 
# You conduct an ANOVA when you are testing the effect of one or more nominal (aka factor) independent variable(s) on a numerical dependent variable. 
# A nominal (factor) variable is one that contains a finite number of categories with no inherent order. 
# Gender, profession, and experimental conditions are good examples of factors. 

# If you only include one independent variable, this is called a One-way ANOVA. 
# - e.g.: Is there a difference between the different cleaners on cleaning time (ignoring poop type)?
#    One way ANOVA: time ~ cleaner
# - e.g.: Is there a difference between the different poop types on cleaning time (ignoring which cleaner is used)
#    One-way ANOVA: time ~ type

# If you include two independent variables, this is called a Two-way ANOVA. 
# -e.g.: Is there a unique effect of the cleaner or poop types on cleaning time?
#    Two-way ANOVA: time ~ cleaner + type
# -e.g.: Does the effect of cleaner depend on the poop type?
#    Two-way ANOVA with interaction term: time ~ cleaner * type


# If you include three independent variables it is called a Menage a trois `NOVA.

# -------------------------- Definition of ANOVA ------------------- #
# ANOVA stands for “Analysis of variance.”
# ANOVA actually uses variances to determine whether or not there are ‘real’ differences in the means of groups. 
# Specifically, it looks at how variable data are WITHIN groups and compares that to the variability of data BETWEEN groups.
# If the between-group variance is large compared to the within group variance, the ANOVA will conclude that the groups do differ in their means. 
# If the between-group variance is small compared to the within group variance, the ANOVA will conclude that the groups are all the same. 


# -------------------------- Simplest ANOVA ------------------------ #
# Starting point: For this book, we’ll cover just one type of ANOVAs called full-factorial, between-subjects ANOVAs. 
# These are the simplest types of ANOVAs which are used to analyze a standard experimental design.

# -------------------------- Code for One-way ANOVA ---------------- #
# Step 1: aov object with time as DV and cleaner as IV
cleaner.aov <- aov(formula = time ~ cleaner,
                   data = poopdeck)


# Step 2: Look at the summary of the anova object
summary(cleaner.aov)
##              Df Sum Sq Mean Sq F value Pr(>F)   
## cleaner       2   6057    3028    5.29 0.0053 **
## Residuals   597 341511     572                  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


# The main result from our table is that we have a significant effect of cleaner on cleaning time (F(2, 597) = 5.29, p = 0.005. 
# However, the ANOVA table does not tell us which levels of the independent variable differ. 
# In other words, we don’t know which cleaner is better than which. To answer this, we need to conduct a post-hoc test.


# Step 3: Conduct post-hoc tests
TukeyHSD(cleaner.aov)
##   Tukey multiple comparisons of means
##     95% family-wise confidence level
## 
## Fit: aov(formula = time ~ cleaner, data = poopdeck)
## 
## $cleaner
##      diff lwr  upr p adj
## b-a -0.42  -6  5.2  0.98
## c-a -6.94 -13 -1.3  0.01
## c-b -6.52 -12 -0.9  0.02

# This table shows us pair-wise differences between each group pair. 
# The diff column shows us the mean differences between groups (which thankfully are identical to what we found in the summary of the regression object before), a confidence interval for the difference, and a p-value testing the null hypothesis that the group differences are not different.


# Step 4: Create a regression object
cleaner.lm <- lm(formula = time ~ cleaner,
                 data = poopdeck)

# Show summary
summary(cleaner.lm)
## 
## Call:
## lm(formula = time ~ cleaner, data = poopdeck)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -63.02 -16.60  -1.05  16.92  71.92 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    66.02       1.69   39.04   <2e-16 ***
## cleanerb       -0.42       2.39   -0.18   0.8607    
## cleanerc       -6.94       2.39   -2.90   0.0038 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 24 on 597 degrees of freedom
## Multiple R-squared:  0.0174, Adjusted R-squared:  0.0141 
## F-statistic: 5.29 on 2 and 597 DF,  p-value: 0.00526

# The regression table does not give us tests for each variable like the ANOVA table does. 
# Instead, it tells us how different each level of an independent variable is from a default value. 
# You can tell which value of an independent variable is the default variable just by seeing which value is missing from the table.

# The intercept in the table tells us the mean of the default value. 
# In this case, the mean time of cleaner a was 66.02. 
# The coefficients for the other levels tell us that cleaner b is, on average 0.42 minutes faster than cleaner a, and cleaner c is on average 6.94 minutes faster than cleaner a.

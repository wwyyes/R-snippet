# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 
# Depends on how to calculate variability, there are three types of ANOVAs, Type1, 2, and 3. 
# These types differ in how they calculate variability (speicifically the sums of squares). 
# If your data is relatively balanced, meaning that there are relatively equal numbers of observations in each group, then all three types will give you the same answer. 
# However, if your data are unbalanced, meaning that some groups of data have many more observations than others, then you need to use Type II (2) or Type III (3).

# The standard aov() function in base-R uses Type I sums of squares. 
# Therefore, it is only appropriate when your data are balanced. If your data are unbalanced, you should conduct an ANOVA with Type II or Type III sums of squares. 
# To do this, you can use the Anova() function in the car package. 
# The Anova() function has an argument called type that allows you to specify the type of ANOVA you want to calculate.

# First, I’ll create a regression object with lm(). 
# As you’ll see, the Anova() function requires you to enter a regression object as the main argument, and not a formula and dataset. 
# That is, you need to first create a regression object from the data with lm() (or glm()), and then enter that object into the Anova() function. 
# You can also do the same thing with the standard aov() function`.


# Step 1: Calculate regression object with lm()
time.lm <- lm(formula = time ~ type + cleaner,
              data = poopdeck)


# Step 2: perform ANOVA
# Type I ANOVA - aov()
time.I.aov <- aov(time.lm)

# Type II ANOVA - Anova(type = 2)
time.II.aov <- car::Anova(time.lm, type = 2)

# Type III ANOVA - Anova(type = 3)
time.III.aov <- car::Anova(time.lm, type = 3)



# For more detail on the different types, check out https://mcfromnz.wordpress.com/2011/03/02/anova-type-iiiiii-ss-explained/.

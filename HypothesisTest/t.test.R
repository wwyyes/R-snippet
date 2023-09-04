# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 


# T.test -----------
# ?t.test
# t.test(x, y = NULL,
#       alternative = c("two.sided", "less", "greater"),
#       mu = 0, paired = FALSE, var.equal = FALSE,
#       conf.level = 0.95, ...)


# 1 sample t-test
## Are pirate ages different than 30 on average?
t.test(x = pirates$age, 
       mu = 30)

# 2 sample t-test
# Do females and males have different numbers of  tattoos?

sex.ttest <- t.test(formula = tattoos ~ sex,
                    data = pirates, 
                    subset = sex %in% c("male", "female")
                   )

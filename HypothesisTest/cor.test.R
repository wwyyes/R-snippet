# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 
# cor.test
#?cor.test
# cor.test(x, y,
#         alternative = c("two.sided", "less", "greater"), # grearer -> positive association; less -> negative association
#         method = c("pearson", "kendall", "spearman"),
#         exact = NULL, conf.level = 0.95, continuity = FALSE, ...)

# example:
# Correlation Test
#   Correlating two variables x and y

# Method 1: Formula notation
##  Use if x and y are in a dataframe
cor.test(formula = ~ x + y,
         data = df)

# Method 2: Vector notation
## Use if x and y are separate vectors
cor.test(x = x,
         y = y)


# Is there a correlation between age and 
#  number parrots ONLY for female pirates?

cor.test(formula = ~ age + parrots,
         data = pirates,
         subset = sex == "female")

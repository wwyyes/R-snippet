# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 
# Chi-square test
#?chisq.test
# chisq.test(x, y = NULL, correct = TRUE,
           p = rep(1/length(x), length(x)), rescale.p = FALSE,
           simulate.p.value = FALSE, B = 2000)
# Example
## 1-sample Chi-square test
# If you conduct a 1-sample chi-square test, you are testing if there is a difference in the number of members of each category in the vector. 
# Or in other words, are all category memberships equally prevalent? Here’s the general form of a one-sample chi-square test:

# General form of a one-sample chi-square test
chisq.test(x = table(x))

# Frequency table of pirate colleges
table(pirates$college)
## 
##  CCCC JSSFP 
##   658   342

## 2-sample Chi-square test
# Is there a relationship between a pirate's
# college and whether or not they wear an eyepatch?

colpatch.cstest <- chisq.test(x = table(pirates$college,
                                        pirates$eyepatch))

colpatch.cstest
## 
##  Pearson's Chi-squared test with Yates' continuity correction
## 
## data:  table(pirates$college, pirates$eyepatch)
## X-squared = 0, df = 1, p-value = 1

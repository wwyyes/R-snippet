# This note is based on YaRrr! The Pirate’s Guide to R (https://bookdown.org/ndphillips/YaRrr/); 
# If you are conducting an analyses where you’re repeating measurements over one or more third variables, like giving the same participant different tests, you should do a mixed-effects regression analysis. 
# To do this, you should use the lmer function in the lme4 package. 
# e.g.: in the poopdeck data, they have repeated measurements for days. 
# That is, on each day, they had 6 measurements. 
# Now, it’s possible that the overall cleaning times differed depending on the day. 
# We can account for this by including random intercepts for day by adding the (1|day) term to the formula specification. 
# For more tips on mixed-effects analyses, check out this great tutorial by Bodo Winter at http://www.bodowinter.com/tutorial/bw_LME_tutorial2.pdf.



library(lme4)

# Calculate a mixed-effects regression on time with
#  Two fixed factors (cleaner and type)
#  And one repeated measure (day)

my.mod <- lmer(formula = time ~ cleaner + type + (1|day),
                data = poopdeck)

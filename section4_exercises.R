install.packages("tidyverse")
install.packages(c("nycflights13", "gapminder", "Lahman"))
library(tidyverse)
library(ggplot2) #Run this to use ggplot2 functions (such as ggplot!)

# Why does this not work?
my_variable <- 10
my_varıable

# Checking the funny-looking character:
ı <-1
i

# Original code:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

fliter(mpg, cyl = 8)
filter(diamond, carat > 3)

# "Tweaked" code:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

# Alt + Shift + K produces a terminal window.
# Can also be accessed by Tools > Terminal > New terminal

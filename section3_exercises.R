setwd("~/src/RLearning")

install.packages("tidyverse")
install.packages(c("nycflights13", "gapminder", "Lahman"))
library(tidyverse)
library(ggplot2) #Run this to use ggplot2 functions (such as ggplot!)

# Exercises related to Chapter 3 (https://r4ds.had.co.nz/data-visualisation.html)
# Look at the data set:
ggplot2::mpg

# Make a basic plot:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#In the abstract, we use the following template to create a graph:
# ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# Exercises 3.2.4
#-----------
ggplot(data = mpg)
nrow(mpg)
ncol(mpg)
?mpg

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))
#-----------

# Colour points in the scatterplot by class variable value. This allows us to note that the 2 seater 
# class observations do not follow the same pattern as other classes of vehicles.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# Extra: I thought colour was useful. Class by colour & size below!
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class, colour = class))

# More examples:

# Transparency
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Shape of observation on scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# We can also manually edit plots (e.g. making all observations blue):
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Exercises 3.3.1
#-----------
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# Some experiments:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = "Hello World!"))

?mpg

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = year))


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class, colour = class))

?geom_point

# Note, this does not work:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, stroke = class))

# Wow! But probably not what we want...
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, stroke = hwy))

# Here we get big points:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), stroke = 4)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y= hwy, colour = displ < 5))
 #-----------

# Note: The + is in the wrong place here. This WON'T run:
ggplot(data = mpg) 
+ geom_point(mapping = aes(x = displ, y = hwy))

# Faceting by class variable:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# Faceting by both drv and by cyl variables, arranged as a grid a grid ()
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# I found the above plots hard to parse (how do you tell which one corresponds to which!) 
# Below, each cyl and drv values have different aesthetic properties, and it is clearer to parse!
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = cyl, shape = drv)) + 
  facet_grid(drv ~ cyl)

# Faceting into a single row
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)


# Exercises 3.5.1
#-----------

# Can we facet on a continuous variable?
?mpg 
mpg$cty
#Let's choose cty
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cty)


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# Rows or columns? The "." shows what dimension we arrange our faceting in.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

?facet_wrap

#-----------

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# Another example. How messy!
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = class))

# Mini exercise - an attempt to make the plot in the book (the code for which is not provided)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, colour = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# What if show.legend = TRUE?
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = TRUE
  )

# Overlapping geoms! Wow!
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# This does the same thing!
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# Overwriting global settings for a single layer (introducing colour ONLY in the geom_point layer)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class), show.legend = FALSE) + 
  geom_smooth() 

# Here we overwrite global settings and create a geom_smooth for subcompact cars only:
library(dplyr)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# Exercises 3.6.1
#-----------

# All coloured by drv, points, line plot w/o SE bar areas
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# Same:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Recreating graphs:
# 1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(stroke = 2) + 
  geom_smooth(size = 2, se = FALSE)
# 2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(stroke = 2) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv), size = 2, se = FALSE)
# 3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(stroke = 2) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv), size = 2, se = FALSE, show.legend = TRUE)
# 4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = drv, stroke = 2), show.legend = TRUE) + 
  geom_smooth(se = FALSE, size = 2)
# 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = drv), stroke = 2) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), size = 2, se = FALSE, show.legend = TRUE)
# 6 (layer dots, first a layer of white dots, then add scatterplot segmented by colour)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour = drv))

#-----------

# Here, ggplot uses a stat (statistical transformation) of the data, summarizing # of occurrences
# that fall into certain ranges to create a histogram:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# geom_bar uses stat_count (a counting function), so calling geom_bar here is equiv to calling stat_count:
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

# stat_count is the defaust stat for geom_bar, but we could use the identity stat, and explicitly pass
# the heights of the columns to geom_bar (overriding stat_count)

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

?stat_summary()

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

?stat_bin

# Exercises 3.7.1
#-----------

# Without using stat_summary() (https://stackoverflow.com/questions/41850568/r-ggplot2-pointrange-example)
# This doesn't work!
ggplot(data = diamonds,  mapping = aes(x = cut, y = depth)) +
  geom_pointrange(mapping=aes(ymin=min, ymax=max))
?stat_summary()
ggplot(data = diamonds) +
  geom_pointrange(mapping = aes(x = cut, y = depth),
                  stat = "summary",
                  fun.ymin = min,
                  fun.ymax = max,
                  fun.y = median)

?geom_col
?geom_bar
# https://ggplot2.tidyverse.org/reference/geom_bar.html
# geom_bar bars are proportional, geom_col bars represent values in data
?geom_abline
# Can't find stat
?geom_area
# stat = "identity"
?geom_bar
# stat = "count"
?geom_bin2d
# stat = "bin2d"
?geom_boxplot
# stat = "boxplot"
?geom_col
# stat = "count"
# ... etc. Very long list and I think I understand how to look these up and implement now.

?stat_smooth()
# Computes variables: 
# y: predicted value
# ymin: lower pointwise confidence interval around the mean
# ymax: upper pointwise confidence interval around the mean
# se: standard error

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))

diamonds$cut
?geom_bar
summary(diamonds)
table(diamonds$cut)

# COUNTS
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
# PROPORTIONS
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1 ))
# "geom_bar() makes the height of the bar proportional to the number of cases in each group"
# so setting group = 1 makes us look for proportion of diamonds of each cut relative to all other cuts
#-----------

# Bars have coloured outline:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

# Bars have colour fill:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# Use colour to rep another variable (e.g. clarity variable):
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# Position settings:

# Position = "identity"
# Overlaps bars (use alpha = 1/5 to adjust transparency, or no fill - so we can see overlapped bars)
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

# Position = "fill" 
# Bars now have height 1 (proportion)
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# Position = "dodge" 
# Bars are placed next to each other
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# Jitter for plots:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

# Exercises 3.8.1
#-----------
# What is wrong with this plot?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
# With jitter
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")
?geom_jitter()
# width and height can be adjusted:
ggplot(mpg, aes(cty, hwy)) + 
  geom_jitter(width = 0.25, height = 0.25)
?geom_count()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()
# geom_count makes sizes of points different

?geom_boxplot # position = "dodge2"
ggplot(data = mpg, mapping = aes(x=drv, y=cty, colour = class)) + 
  geom_boxplot()
ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot(position = "identity")
#-----------

# Co-ordinate switch example (x and y):
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

# Another example
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

# Another example:
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
# Bars:
bar
bar + coord_flip()
# Polar coordinates:
bar + coord_polar()

# Exercises 3.9.1
#-----------
?coord_polar
# From the documentation:
#  A pie chart = stacked bar chart + polar coordinates
#  pie <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
#  geom_bar(width = 1)
#  pie + coord_polar(theta = "y")
# A previous example made the following bar chart:
?diamonds
ggplot(diamonds, aes(x = factor(1), fill = factor(cut))) +
  geom_bar(width = 1) +
  coord_polar(theta = "y")

?labs
# labs allows us to put labels on plots

?coord_quickmap() 
?coord_map()
# "Map projections do not, in general, preserve straight lines, so this requires considerable 
# computation. coord_quickmap is a quick approximation that does preserve straight lines. It 
# works best for smaller areas closer to the equator."

# Original plot (in book):
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + # run up to here gives scatterplot
  geom_abline() + # run up to here creates line
  coord_fixed() # x and y axes now look similar, are they to scale? We check:
?coord_fixed() 
# The documentation shows we can fix the ratios between the x and y axes (default is set to 1)

#-----------

# In the abstract, layered grammar of graphics:

# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>, 
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>


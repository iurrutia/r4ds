library(nycflights13)
library(tidyverse)

# to use non-dplyr versions of filter() & lag() type stats::filter() and stats::lag().

# "These six functions provide the verbs for a language of data manipulation:"

# filter() - Pick observations by their values
# arrange() - Reorder the rows
# select() - Pick variables by their names
# mutate() - Create new variables with functions of existing variables 
# summarise() - Collapse many values down to a single summary
# group_by() - Takes an existing tbl and converts it into a grouped tbl where operations are performed "by group"

# E.g.

filter(flights, month == 1, day == 1) # all w/month == 1 and day == 1
jan1 <- filter(flights, month == 1, day == 1)
# wrap in parenthesis to assign AND print:
(dec25 <- filter(flights, month == 12, day == 25))

# This won't work because we've used "=" instead of "==":
filter(flights, month = 1)

# Test for "equality"
near(1 / 49 * 49, 1)

# AND, OR, NOT: &, |, !

# E.g. flights from November OR December:
filter(flights, month == 11 | month == 12)

# Another way of doing the same thing using %i%
nov_dec <- filter(flights, month %in% c(11, 12))

# Is a value missing? is.na(x)
# Preserve missing values by asking for them explicitly:
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)


# Exercises 5.2.1
#-----------

# Flights with an arrival delay of two or more hours
(filter(flights, arr_delay >= 2))
# I'm curious about the average delay time of flights delayed two or more hours!
two_hours <- filter(flights, arr_delay >= 120)
mean(two_hours$arr_delay)

# Flew to Houston (IAH or HOU)
head(flights$dest)

(filter(flights$dest))
IAH_or_HOU <- filter(flights, dest == "IAH"| dest =="HOU")
head(IAH_or_HOU$dest)

# Were operated by United, American, or Delta
(filter(flights,carrier == "DL"|carrier == "UA"|carrier == "AA"))

# Departed in summer (July, August, and September)
?flights
(filter(flights, month %in% c(7,8,9)))

# Arrived more than two hours late, but didn’t leave late
(filter(flights, dep_delay <=1 & arr_delay > 120))

# Were delayed by at least an hour, but made up over 30 minutes in flight
made_up_thirty <- filter(flights, dep_delay >=60 & (arr_delay + 30 < dep_delay))

# Departed between midnight and 6am (inclusive)
early <- filter(flights, dep_time <= 600)

?between()
# Simplifying the example of summer flights:
(filter(flights, between(month,7,9)))

(filter(flights, is.na(dep_time) ))
# Cancelled flights?

# Checking:
NA^0
NA | TRUE
FALSE & NA
NA * 0

# Testing for my own curiosity:
is.na(c("NA"))
is.na(c(NA))

#-----------


?arrange()
arrange(flights, year, month, day)
# An experiment, order by airline?
arrange(flights, carrier)

# Order a column in descending order:
arrange(flights, desc(dep_delay)) 

# Missing values go at the end:
df <- tibble(x = c(5, 2, NA))
arrange(df, x)

# Even if we reverse the order, as we just learned! :)
arrange(df, desc(x))

# Exercises 5.3.1
#-----------

# How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).
test <- arrange(flights, is.na(dep_time) == FALSE)
tail(test)
head(test)
(arrange(flights, dep_time))

# Sort flights to find the most delayed flights. Find the flights that left earliest.
arrange(flights, desc(arr_delay))
arrange(flights, dep_delay)
# By both:
arrange(flights, desc(arr_delay), dep_delay)

# Sort flights to find the fastest flights.
flights_by_time_fast <- arrange(flights, air_time)
head(fast_flights$air_time)
flights_by_time_slow <- (arrange(flights, desc(air_time)))
head(flights_by_time_slow$air_time)

#-----------

# Select just the COLUMNS specified:
?flights
# The line from the textbook doesn't work. Explanation and solution here: 
# https://community.rstudio.com/t/select-function-in-dplyr-package/11737
dplyr::select(flights, year, month, day)
dplyr::select(flights, year:day)

# And just checking...
dplyr::select(flights, year, month, day) == dplyr::select(flights, year:day)

# Exclude columns using -(columns)
dplyr::select(flights, -(year:day))

# starts_with("abc")
dplyr::select(flights, -(year:day))

?select() 
# starts_with("abc"): matches names that begin with “abc”
# e.g. columns that start with "a"

dplyr::select(flights, starts_with("a"))

# ends_with("xyz"): matches names that end with “xyz”.
# e.g. colmuns that end with "e"
dplyr::select(flights, ends_with("e"))

# contains("ijk"): matches names that contain “ijk”

# matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters. You’ll learn more about regular expressions in strings.
dplyr::select(flights, matches("(.)\\1"))

# num_range("x", 1:3): matches x1, x2 and x3
dplyr::select(flights, num_range("x", 1:3))

# Exercises 5.4.1
#-----------
# Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
dplyr::select(flights, starts_with("arr_"), starts_with("dep_")) # and all other combinations, etc

# What happens if you include the name of a variable multiple times in a select() call?
dplyr::select(flights, carrier, carrier)
dplyr::select(flights, carrier)
# it looks the same, checking:
dplyr::select(flights, carrier, carrier) == dplyr::select(flights, carrier)
# yup!

# What does the one_of() function do?
?one_of()
dplyr::select(flights, one_of(c("dep_time","arr_time","carrier")))
# It took me a while to find a way to make one_of work, still not sure what it does

# Why might it be helpful in conjunction with this vector?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
dplyr::select(flights, one_of(vars))
# Because modifying vars is easier than modifying the dplyr expression? (In this example the expressions seem equivalent, but perhaps for more complex projects.)              
              
# Does the result of running the following code surprise you? How do the select helpers deal with case by default? How can you change that default?
dplyr::select(flights, contains("TIME"))
# Appears to be case neutral.
#-----------

# MUTATE: mutate() adds new columns (functions of existing columns) to the end of the dataset (View())

flights_sml <- dplyr::select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

view(flights_sml)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

# Keep new variables
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

# Some e.g. of arithmetic ops on cols
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)

flights
# Note that flights is not affected


# Exercises 5.4.1
#-----------

# ... IN PROGRESS
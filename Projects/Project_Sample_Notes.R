#   GETTING STARTED   ####


##### Installing Packages    ====
install.packages("pacman")
install.packages("readxl")
install.packages("tidyverse")
install.packages("dplyr")
install.packages("remotes")
install.packages("rtools")



#####   Load Packages    ==== 
library(datasets)
library(pacman)
library(readxl)
library(tidyverse)
library(dplyr)
library(remotes)


# Data Visualization    ####

# Load Data
x = c(24, 13, 7, 5, 3, 2) # sample data
barplot(x)                # default bar plot

# Colors in R
?colors
colors() # Get a list of colors

#### Colors Names
barplot(x, col = "red3")        # red3
barplot(x, col = "slategray3")  #slategray3

#### RGB hex codes
barplot(x, col = "#CD0000")        # red3
barplot(x, col = "#9FB6CD")  #slategray3

#### Multiple Colors  
barplot(x, col = c("red3", "slategray3"))        # red3
barplot(x, col = c("#9FB6CD","#CD0000"))  #slategray3








## Creating Bar charts   ####

# Convert several adjacent variables to factors
df <- read_csv("data/state_trends.csv") |>
    mutate(across(c(region:psy_reg), factor)) |>
    print()

#### Bar plot of frequencies    ----

# Help
?plot
?barplot

# Shortest method to make a bar plot
plot(df$psy_reg)

# Similar process using pipes
df |>
  select(psy_reg) |>
  plot()

# Create frequency vector with table()
df |>
  select(psy_reg) |>
  table() |>
  barplot()

# sort bars by decreasing values
df |>
  select(psy_reg) |>
  table() |>
  sort(decreasing = T) |>
  barplot()

# Add options to plot 
df |>
  select(psy_reg) |>
  table() |>
  sort(decreasing = T) |>
  barplot(
      main = "Personalities of 48 Contigious US States", 
      sub  = "(Source: state_trends.csv)",
      horiz = T, # Draw horizontal bars,
      ylab = "Personality Profile",
      xlab = "Number of States",
      xlim = c(0, 25),
     # border = NA, # No borders on bars
      col = "red3"
  )

#### Stacked Barplot of Frequencies   ----

# 100% stacked bar
df |>
  select(region, psy_reg) |>
  plot()

# Stacked bars - step 1: create table
df_t <- df |>
  select(region, psy_reg) |>
  table() |>
  print()

# Stacked bars - step 2a: create graph w/ legend
df_t |> 
  barplot(legend = rownames(df_t))

# Stacked bars - step 2b: create graph w/o legend
df_t |> 
  barplot()

# Side-by-side bar w/ legend
df_t |> 
  barplot(beside = T)







## Creating Histograms   ####
df <- read_csv("data/state_trends.csv")
?hist

# Histogram with defaults
hist(df$data_science)

# Histogram with options 
hist(df$data_science,
     breaks = 7,
     main = "Histogram of Searches for \"Data Science\"",
     sub = "(Source: state_trends.csv)",
     ylab = "Frequency",
     xlab = "Searches for \"Data Science\"",
     #border = NA, # No borders on bars,
     col = "#CD0000")

#### Density Plot    ====
?density

# Density plot with defaults
plot(density(df$data_science))

# Density plot with options
df |>  
    pull(data_science) |>
    as.numeric() |>
    density() |>
    plot(
      main = "Density Plot of Searches for \"Data Science\"",
      sub = "(Source: state_trends.csv)",
      ylab = "Frequency",
      xlan = "Searches for \"Data Science\"",
    )

# Use polygon to ADD a filled density plot
df |>  
  pull(data_science) |>
  as.numeric() |>
  density() |>
  polygon(col = "red3")




















## Creating Box plots  ####


# Load Data
# convert all character variables to factors
df <- read_csv("data/state_trends.csv") |>
  mutate(across(where(is_character), as_factor)) |>
  print()

### BoxPlot of Frequencies ====
?plot 
?boxplot

# Boxplot with defaults
boxplot(df$dance)

# Who is the outlier? 
df |>
  filter(dance > 90) |>
  select(state, dance)

# Boxplot with options 
df |>
  select(dance) |>
  boxplot(
    horizontal = T,
    notch = T, 
    main = "Boxplot of Searches \"Dance\"",
    sub = "(Source: state_trends.csv)",
    xlab = "Searches for \"Dance\"",
    col = "red3"
  )

### Boxplots for Multiple variables   ====
df |>
  select(basketball:hockey) |>
  boxplot()

# Who are the outliers on "hockey"?
df |>
  filter(hockey > 45) |>
  select(state, hockey) |>
  arrange(desc(hockey))

### Boxplots by group   ====

# Boxplots by group using plot()
df |>
  select(has_nhl, hockey) |>
  plot()

# Who is the outlier on "No"?
df |>
  filter(has_nhl == "No") |>
  filter(hockey > 80) |>
  select(state, hockey)

# Boxplots by group using plot()
df |>
  select(has_nhl, hockey) |>
  plot(
    horizontal = T,
    notch = T,
    main = "Boxplot of Searches for \"Hockey\"",
    sub = "(Source: state_trends.csv)",
    xlab = "Searches for \"Hockey\"",
    ylab = "State has NHL Hockey Team",
    col = "red3"
  )


















## Creating Scatterplots   ####

# Load Data
df <- read_csv("data/state_trends.csv") |>
  select(basketball:hockey) |>
  glimpse()

### Scatterplots   ====

#Plot all associations
df |> plot()

# Bivariate scatterplot with defaults
df |> 
  select(soccer, hockey) |>
  plot()

# Bivariate scatterplot with options
df |>
  select(soccer, hockey) |>
  plot(
    main = "Scatterplot of Searches by State",
    xlab = "Searches for \"Hockey\"",
    ylab = "Searches for \"Hockey\"",
    col = "red3",
    pch = 19, # "Plotting character" (small circle)
  )

# See plotting characters
?pch

# Add fit linear regression line (y ~ x)
lm(df$hockey ~ df$soccer) |>
  abline()




























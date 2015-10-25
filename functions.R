library(babynames)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(ssalifetablesextended)
library(cwhmisc)

ageTableFor <- function(firstname, gender) {
  name_table <- filter(babynames, name == firstname, sex == gender, year >= 1900)
  expectancy_table <- filter(prob_living_2014, sex == gender)
  df <- merge(name_table, expectancy_table, by=c("year", "sex"), all=T)
  df$n_alive <- floor(df$px * df$n)
  med <- w.median(df$age, df$n_alive)
  df$median <- df$age == med
  df
}

ziggerZagger <- function(agetable) {
  gender <- removeNA(unique(agetable$sex))
  name <- removeNA(unique(agetable$name))
  median <- filter(agetable, median == T)[, "age"]
  gcolor <- if(gender == "M") {
    "dodgerblue"
  } else if(gender == "F") {
    "lightsalmon1"
  }
  ggplot(agetable) + 
    theme_fivethirtyeight() +
    theme(legend.position="none") +
    geom_bar(aes(x=year, y=n_alive, alpha=median), stat="identity", fill=gcolor(gender)) +
    scale_alpha_manual(values = c(0.75, 1)) +
    geom_line(aes(x=year, y=n), lwd=2) + 
    ggtitle(paste("Age Distribution of American", boysOrGirls(gender), "named", name))
}


gcolor <- function(g) {
  if(g == "M") {
    "dodgerblue"
  } else if(g == "F") {
    "lightsalmon1"
  }
}

boysOrGirls <- function(gender) {
  if(gender == "F") {
    "Girls"
  } else if(gender == "M") {
    "Boys"
  }
}

removeNA <- function(v) {
  v[!is.na(v)]
}
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
  if(is.null(agetable)) return(NULL)
  gender <- removeNA(unique(agetable$sex))
  name <- removeNA(unique(agetable$name))
  median <- dplyr::filter(agetable, median == T)[, "age"]
  ggplot(agetable, aes(x=year)) + 
    theme_fivethirtyeight() +
    theme(legend.position="right", legend.title=element_blank()) +
    geom_bar(aes(y=n_alive, fill="Born that year \nstill alive today"), alpha=0.75, stat="identity") +
    scale_fill_manual(values=gcolor(gender)[1]) +
    geom_bar(data=filter(agetable, median == T), aes(y=n_alive), fill=gcolor(gender)[2], stat="identity") +
    geom_line(aes(y=n, color="Born each year"), lwd=2) + 
    scale_color_manual(values="black") +
    ggtitle(paste("Age Distribution of American", boysOrGirls(gender), "named", name))
}

nameStats <- function(agetable) {
  list(
    median_age = filter(agetable, median == T)[, "age"],
    peak_born = max(agetable$n, na.rm=T),
    peak_year = last(filter(agetable, n == max(agetable$n, na.rm=T))[, "year"]),
    total_born = sum(agetable$n, na.rm=T),
    alive = sum(agetable$n_alive, na.rm=T)
  )
}

nameStatsText <- function(name, stats) {
  list(
    born = paste("There have been", fnum(stats$total_born), plural(name), "born since 1900."),
    alive = paste("There are an estimated", fnum(stats$alive), plural(name), "alive today."),
    median_age = paste("The median living", name, "is", stats$median_age, "years old."),
    peak = paste("The most number of", plural(name), "ever born in a year was in", 
                 stats$peak_year, "with", fnum(stats$peak_born), plural(name), "born.")
  )
}

plural <- function(n) {
  paste0(n, "s")
}

fnum <- function(num) {
  prettyNum(num, big.mark=",")
}

gcolor <- function(g) {
  if(g == "M") {
    c("dodgerblue", "blue")
  } else if(g == "F") {
    c("lightsalmon1", "red")
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
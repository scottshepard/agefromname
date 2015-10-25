# Age from Name

This is a shiny app that uses Social Security Administration acturarial tables
and cencus data to find the median age of a given first name.

The idea is from the Five Thirty Eight article [How to Tell Someone's Name When All  
You Know is Her Age](http://fivethirtyeight.com/features/how-to-tell-someones-age-when-all-you-know-is-her-name/#ss-2).

Data comes from Hadley Wickham's [babyname package](https://github.com/hadley/babynames).

## Method

The table `lifetables` give the mortality at every age in each cencus year. For
example, the first row shows that 14.6% of boys born in 1900 died before reaching
their first birthday. 

We know from the `babynames` table that there were 9830 Johns born in 1900. Therefore
there were 8,395 1 year old Johns alive in 1901. We do this for each year and can 
calculate the median age of Johns alive as of January 1st, 2014.

NOTE: Since the lifetables only give expectancies every decade, use linear interpolation to create expectancies for the years in between.
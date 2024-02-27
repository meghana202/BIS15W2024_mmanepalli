---
title: "Midterm 2 W24"
author: "Meghana Manepalli"
date: "2024-02-27"
output:
  html_document: 
    keep_md: yes
  pdf_document: default
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code must be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. 

Your code must knit in order to be considered. If you are stuck and cannot answer a question, then comment out your code and knit the document. You may use your notes, labs, and homework to help you complete this exam. Do not use any other resources- including AI assistance.  
Don't forget to answer any questions that are asked in the prompt. Some questions will require a plot, but others do not- make sure to read each question carefully.  

For the questions that require a plot, make sure to have clearly labeled axes and a title. Keep your plots clean and professional-looking, but you are free to add color and other aesthetics.  

Be sure to follow the directions and upload your exam on Gradescope.    

## Background
In the `data` folder, you will find data about shark incidents in California between 1950-2022. The [data](https://catalog.data.gov/dataset/shark-incident-database-california-56167) are from: State of California- Shark Incident Database.   

## Load the libraries

```r
library("tidyverse")
library("janitor")
library("naniar")
```

## Load the data
Run the following code chunk to import the data.

```r
sharks <- read_csv("data/SharkIncidents_1950_2022_220302.csv") %>% clean_names()
```

## Questions
1. (1 point) Start by doing some data exploration using your preferred function(s). What is the structure of the data? Where are the missing values and how are they represented?  


```r
glimpse(sharks)
```

```
## Rows: 211
## Columns: 16
## $ incident_num     <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1…
## $ month            <dbl> 10, 5, 12, 2, 8, 4, 10, 5, 6, 7, 10, 11, 4, 5, 5, 8, …
## $ day              <dbl> 8, 27, 7, 6, 14, 28, 12, 7, 14, 28, 4, 10, 24, 19, 21…
## $ year             <dbl> 1950, 1952, 1952, 1955, 1956, 1957, 1958, 1959, 1959,…
## $ time             <chr> "12:00", "14:00", "14:00", "12:00", "16:30", "13:30",…
## $ county           <chr> "San Diego", "San Diego", "Monterey", "Monterey", "Sa…
## $ location         <chr> "Imperial Beach", "Imperial Beach", "Lovers Point", "…
## $ mode             <chr> "Swimming", "Swimming", "Swimming", "Freediving", "Sw…
## $ injury           <chr> "major", "minor", "fatal", "minor", "major", "fatal",…
## $ depth            <chr> "surface", "surface", "surface", "surface", "surface"…
## $ species          <chr> "White", "White", "White", "White", "White", "White",…
## $ comment          <chr> "Body Surfing, bit multiple times on leg, thigh and b…
## $ longitude        <chr> "-117.1466667", "-117.2466667", "-122.05", "-122.15",…
## $ latitude         <dbl> 32.58833, 32.58833, 36.62667, 36.62667, 35.13833, 35.…
## $ confirmed_source <chr> "Miller/Collier, Coronado Paper, Oceanside Paper", "G…
## $ wfl_case_number  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
```

```r
summary(sharks)
```

```
##  incident_num           month             day             year     
##  Length:211         Min.   : 1.000   Min.   : 1.00   Min.   :1950  
##  Class :character   1st Qu.: 6.000   1st Qu.: 7.50   1st Qu.:1985  
##  Mode  :character   Median : 8.000   Median :18.00   Median :2004  
##                     Mean   : 7.858   Mean   :16.54   Mean   :1998  
##                     3rd Qu.:10.000   3rd Qu.:25.00   3rd Qu.:2014  
##                     Max.   :12.000   Max.   :31.00   Max.   :2022  
##                                                                    
##      time              county            location             mode          
##  Length:211         Length:211         Length:211         Length:211        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     injury             depth             species            comment         
##  Length:211         Length:211         Length:211         Length:211        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##   longitude            latitude     confirmed_source   wfl_case_number   
##  Length:211         Min.   :32.59   Length:211         Length:211        
##  Class :character   1st Qu.:34.04   Class :character   Class :character  
##  Mode  :character   Median :36.70   Mode  :character   Mode  :character  
##                     Mean   :36.36                                        
##                     3rd Qu.:38.18                                        
##                     Max.   :41.56                                        
##                     NA's   :6
```
The data has time data in separate columns (month/day/year=nums, time=char) as well as location (county, location, latitude, longitude) as well as various details of each incident such as the species, mode, injury, depth, source, case numbers and comments. There ae NA's that appear to be represented as NA.

2. (1 point) Notice that there are some incidents identified as "NOT COUNTED". These should be removed from the data because they were either not sharks, unverified, or were provoked. It's OK to replace the `sharks` object.


```r
sharks <- sharks %>% 
  filter(incident_num != "NOT COUNTED")
```

3. (3 points) Are there any "hotspots" for shark incidents in California? Make a plot that shows the total number of incidents per county. Which county has the highest number of incidents?


```r
sharks %>% 
  group_by(county) %>% 
  summarize(n=n()) %>% 
  ggplot(aes(x = reorder(county, n), y = n))+
  geom_col(fill="blue", alpha=.7)+
  labs(title="Incidents per County") +
  theme(axis.text.x=element_text(angle=60, hjust=1))
```

![](midterm2_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
?reorder
```

San Diego
4. (3 points) Are there months of the year when incidents are more likely to occur? Make a plot that shows the total number of incidents by month. Which month has the highest number of incidents?  

```r
months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
sharks <-sharks %>% 
  mutate(month = months[month])
```



```r
sharks %>% 
  group_by(month) %>% 
  summarize(n=n()) %>% 
  ggplot(aes(x = reorder(month, n), y = n))+
  geom_col(fill="forest green", alpha=.8)+
  labs(title="Incidents per Month") +
  theme(axis.text.x=element_text(angle=60, hjust=1))
```

![](midterm2_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
?reorder
```
October appears to have the most incidents.

5. (3 points) How do the number and types of injuries compare by county? Make a table (not a plot) that shows the number of injury types by county. Which county has the highest number of fatalities?  



```r
sharks %>% 
  filter(injury=="fatal") %>% 
  tabyl(county)
```

```
##               county n    percent
##  Island - San Miguel 1 0.06666667
##          Los Angeles 1 0.06666667
##            Mendocino 1 0.06666667
##             Monterey 2 0.13333333
##            San Diego 2 0.13333333
##        San Francisco 1 0.06666667
##      San Luis Obispo 3 0.20000000
##            San Mateo 1 0.06666667
##        Santa Barbara 2 0.13333333
##           Santa Cruz 1 0.06666667
```
SLO has most fatal
6. (2 points) In the data, `mode` refers to a type of activity. Which activity is associated with the highest number of incidents?


```r
sharks %>% 
  group_by(mode) %>% 
  summarize(n=n()) 
```

```
## # A tibble: 7 × 2
##   mode                    n
##   <chr>               <int>
## 1 Freediving             35
## 2 Hookah Diving          10
## 3 Kayaking / Canoeing    29
## 4 Paddleboarding          7
## 5 Scuba Diving           19
## 6 Surfing / Boarding     80
## 7 Swimming               22
```
Surfing/Boarding
7. (4 points) Use faceting to make a plot that compares the number and types of injuries by activity. (hint: the x axes should be the type of injury) 

```r
sharks %>% 
  group_by(injury, mode) %>% 
  summarize(n=n()) %>% 
  ggplot(aes(x = injury, y = n ,fill=injury)) + 
  geom_col()+
  labs(title="Incidents per Mode") +
  theme(axis.text.x=element_text(angle=30, hjust=1)) + 
  facet_wrap(~mode)
```

```
## `summarise()` has grouped output by 'injury'. You can override using the
## `.groups` argument.
```

![](midterm2_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

8. (1 point) Which shark species is involved in the highest number of incidents?  



```r
sharks %>% 
  group_by(species) %>% 
  summarize(n=n())
```

```
## # A tibble: 8 × 2
##   species        n
##   <chr>      <int>
## 1 Blue           2
## 2 Hammerhead     3
## 3 Leopard        2
## 4 Salmon         1
## 5 Sevengill      1
## 6 Thresher       1
## 7 Unknown       13
## 8 White        179
```
White sharks are involved in the higest number of accidents
9. (3 points) Are all incidents involving Great White's fatal? Make a plot that shows the number and types of injuries for Great White's only.  


```r
sharks %>% 
  filter(species=="White") %>% 
  group_by(injury) %>% 
  summarize(n=n()) %>% 
  ggplot(aes(x = injury, y = n, fill=injury)) + 
  geom_col(alpha=.8)+
  labs(title="Types of Injuries for Great White") +
  theme(axis.text.x=element_text(angle=30, hjust=1))
```

![](midterm2_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

## Background
Let's learn a little bit more about Great White sharks by looking at a small dataset that tracked 20 Great White's in the Fallaron Islands. The [data](https://link.springer.com/article/10.1007/s00227-007-0739-4) are from: Weng et al. (2007) Migration and habitat of white sharks (_Carcharodon carcharias_) in the eastern Pacific Ocean.

## Load the data

```r
white_sharks <- read_csv("data/White sharks tracked from Southeast Farallon Island, CA, USA, 1999 2004.csv", na = c("?", "n/a")) %>% clean_names()
```

10. (1 point) Start by doing some data exploration using your preferred function(s). What is the structure of the data? Where are the missing values and how are they represented?


```r
glimpse(white_sharks)
```

```
## Rows: 20
## Columns: 10
## $ shark           <chr> "1-M", "2-M", "3-M", "4-M", "5-F", "6-M", "7-F", "8-M"…
## $ tagging_date    <chr> "19-Oct-99", "30-Oct-99", "16-Oct-00", "5-Nov-01", "5-…
## $ total_length_cm <dbl> 402, 366, 457, 457, 488, 427, 442, 380, 450, 530, 427,…
## $ sex             <chr> "M", "M", "M", "M", "F", "M", "F", "M", "M", "F", NA, …
## $ maturity        <chr> "Mature", "Adolescent", "Mature", "Mature", "Mature", …
## $ pop_up_date     <chr> "2-Nov-99", "25-Nov-99", "16-Apr-01", "6-May-02", "19-…
## $ track_days      <dbl> 14, 26, 182, 182, 256, 275, 35, 60, 209, 91, 182, 240,…
## $ longitude       <dbl> -124.49, -125.97, -156.80, -141.47, -133.25, -138.83, …
## $ latitude        <dbl> 38.95, 38.69, 20.67, 26.39, 21.13, 26.50, 37.07, 34.93…
## $ comment         <chr> "Nearshore", "Nearshore", "To Hawaii", "To Hawaii", "O…
```

```r
summary(white_sharks)
```

```
##     shark           tagging_date       total_length_cm     sex           
##  Length:20          Length:20          Min.   :360.0   Length:20         
##  Class :character   Class :character   1st Qu.:400.5   Class :character  
##  Mode  :character   Mode  :character   Median :434.5   Mode  :character  
##                                        Mean   :436.1                     
##                                        3rd Qu.:457.0                     
##                                        Max.   :530.0                     
##                                                                          
##    maturity         pop_up_date          track_days      longitude     
##  Length:20          Length:20          Min.   : 14.0   Min.   :-156.8  
##  Class :character   Class :character   1st Qu.: 85.0   1st Qu.:-137.8  
##  Mode  :character   Mode  :character   Median :182.0   Median :-133.2  
##                                        Mean   :166.8   Mean   :-120.3  
##                                        3rd Qu.:216.8   3rd Qu.:-124.3  
##                                        Max.   :367.0   Max.   : 131.7  
##                                                        NA's   :1       
##     latitude       comment         
##  Min.   :20.67   Length:20         
##  1st Qu.:22.48   Class :character  
##  Median :26.39   Mode  :character  
##  Mean   :28.24                     
##  3rd Qu.:36.00                     
##  Max.   :38.95                     
##  NA's   :1
```
The data includes various observations about sharks including size, sex, tagging date, track days, location, maturity and comments. NAs are represented as NAs

11. (3 points) How do male and female sharks compare in terms of total length? Are males or females larger on average? Do a quick search online to verify your findings. (hint: this is a table, not a plot).  


```r
white_sharks %>% 
  group_by(sex) %>% 
  summarize(meanlength = mean(total_length_cm)) 
```

```
## # A tibble: 3 × 2
##   sex   meanlength
##   <chr>      <dbl>
## 1 F           462 
## 2 M           425.
## 3 <NA>        425
```
Females are slightly longer on average.

12. (3 points) Make a plot that compares the range of total length by sex.

```r
white_sharks %>% 
  filter(!is.na(sex)) %>% 
  select(sex, total_length_cm) %>% 
  ggplot(aes(x=total_length_cm, y= sex, fill=sex)) +
  geom_boxplot(alpha=.9)
```

![](midterm2_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

```r
  labs(title="Distribution of Length by Sex") 
```

```
## $title
## [1] "Distribution of Length by Sex"
## 
## attr(,"class")
## [1] "labels"
```

13. (2 points) Using the `sharks` or the `white_sharks` data, what is one question that you are interested in exploring? Write the question and answer it using a plot or table.

What is the maturity of tagged GWs by sex?


```r
white_sharks %>% 
  filter(!is.na(sex)) %>% 
  group_by(sex, maturity) %>% 
  ggplot(aes(x=maturity, fill=sex))+
  geom_bar(position="dodge", alpha=.8)+
  labs(title="Maturity by Sex of Great White Sharks Tagged")
```

![](midterm2_files/figure-html/unnamed-chunk-19-1.png)<!-- -->
It appears that there were many more tagged mature males than females, and more adolescent tagged females than males. 

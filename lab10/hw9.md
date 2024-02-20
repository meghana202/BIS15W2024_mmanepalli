---
title: "Homework 9"
author: "Meghana Manepalli"
date: "2024-02-20"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

For this homework, we will take a departure from biological data and use data about California colleges. These data are a subset of the national college scorecard (https://collegescorecard.ed.gov/data/). Load the `ca_college_data.csv` as a new object called `colleges`.

```r
colleges <- read_csv("data/ca_college_data.csv")
```

```
## Rows: 341 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): INSTNM, CITY, STABBR, ZIP
## dbl (6): ADM_RATE, SAT_AVG, PCIP26, COSTT4_A, C150_4_POOLED, PFTFTUG1_EF
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

The variables are a bit hard to decipher, here is a key:  

INSTNM: Institution name  
CITY: California city  
STABBR: Location state  
ZIP: Zip code  
ADM_RATE: Admission rate  
SAT_AVG: SAT average score  
PCIP26: Percentage of degrees awarded in Biological And Biomedical Sciences  
COSTT4_A: Annual cost of attendance  
C150_4_POOLED: 4-year completion rate  
PFTFTUG1_EF: Percentage of undergraduate students who are first-time, full-time degree/certificate-seeking undergraduate students  

1. Use your preferred function(s) to have a look at the data and get an idea of its structure. Make sure you summarize NA's and determine whether or not the data are tidy. You may also consider dealing with any naming issues.


```r
summary(colleges)
```

```
##     INSTNM              CITY              STABBR              ZIP           
##  Length:341         Length:341         Length:341         Length:341        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     ADM_RATE         SAT_AVG         PCIP26           COSTT4_A    
##  Min.   :0.0807   Min.   : 870   Min.   :0.00000   Min.   : 7956  
##  1st Qu.:0.4581   1st Qu.: 985   1st Qu.:0.00000   1st Qu.:12578  
##  Median :0.6370   Median :1078   Median :0.00000   Median :16591  
##  Mean   :0.5901   Mean   :1112   Mean   :0.01981   Mean   :26685  
##  3rd Qu.:0.7461   3rd Qu.:1237   3rd Qu.:0.02457   3rd Qu.:39289  
##  Max.   :1.0000   Max.   :1555   Max.   :0.21650   Max.   :69355  
##  NA's   :240      NA's   :276    NA's   :35        NA's   :124    
##  C150_4_POOLED     PFTFTUG1_EF    
##  Min.   :0.0625   Min.   :0.0064  
##  1st Qu.:0.4265   1st Qu.:0.3212  
##  Median :0.5845   Median :0.5016  
##  Mean   :0.5705   Mean   :0.5577  
##  3rd Qu.:0.7162   3rd Qu.:0.8117  
##  Max.   :0.9569   Max.   :1.0000  
##  NA's   :221      NA's   :53
```


```r
glimpse(colleges)
```

```
## Rows: 341
## Columns: 10
## $ INSTNM        <chr> "Grossmont College", "College of the Sequoias", "College…
## $ CITY          <chr> "El Cajon", "Visalia", "San Mateo", "Ventura", "Oxnard",…
## $ STABBR        <chr> "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "C…
## $ ZIP           <chr> "92020-1799", "93277-2214", "94402-3784", "93003-3872", …
## $ ADM_RATE      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ SAT_AVG       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ PCIP26        <dbl> 0.0016, 0.0066, 0.0038, 0.0035, 0.0085, 0.0151, 0.0000, …
## $ COSTT4_A      <dbl> 7956, 8109, 8278, 8407, 8516, 8577, 8580, 9181, 9281, 93…
## $ C150_4_POOLED <dbl> NA, NA, NA, NA, NA, NA, 0.2334, NA, NA, NA, NA, 0.1704, …
## $ PFTFTUG1_EF   <dbl> 0.3546, 0.5413, 0.3567, 0.3824, 0.2753, 0.4286, 0.2307, …
```


2. Which cities in California have the highest number of colleges?


```r
colleges %>% 
  group_by(CITY) %>% 
  summarise(num_colleges = n()) %>% 
  arrange(desc(num_colleges)) 
```

```
## # A tibble: 161 × 2
##    CITY          num_colleges
##    <chr>                <int>
##  1 Los Angeles             24
##  2 San Diego               18
##  3 San Francisco           15
##  4 Sacramento              10
##  5 Berkeley                 9
##  6 Oakland                  9
##  7 Claremont                7
##  8 Pasadena                 6
##  9 Fresno                   5
## 10 Irvine                   5
## # ℹ 151 more rows
```
Los Angeles, San Diego, San Francisco, and Sacramento are some top cities for number of colleges in California.

3. Based on your answer to #2, make a plot that shows the number of colleges in the top 10 cities.


```r
?geom_bar
colleges %>% 
  group_by(CITY) %>% 
  summarise(num_colleges = n()) %>% 
  arrange(desc(num_colleges)) %>% 
  head(10) %>% 
  ggplot(aes(x = reorder(CITY, num_colleges), y = num_colleges)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "City", y = "Number of Colleges", title = "Top 10 Cities by Number of Colleges") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](hw9_files/figure-html/unnamed-chunk-6-1.png)<!-- -->


4. The column `COSTT4_A` is the annual cost of each institution. Which city has the highest average cost? Where is it located?


```r
colleges %>% 
  group_by(CITY) %>% 
  summarise(avg_cost = mean(COSTT4_A, na.rm = TRUE)) %>% 
  arrange(desc(avg_cost)) 
```

```
## # A tibble: 161 × 2
##    CITY                avg_cost
##    <chr>                  <dbl>
##  1 Claremont              66498
##  2 Malibu                 66152
##  3 Valencia               64686
##  4 Orange                 64501
##  5 Redlands               61542
##  6 Moraga                 61095
##  7 Atherton               56035
##  8 Thousand Oaks          54373
##  9 Rancho Palos Verdes    50758
## 10 La Verne               50603
## # ℹ 151 more rows
```
Claremont has the highest average score.

5. Based on your answer to #4, make a plot that compares the cost of the individual colleges in the most expensive city. Bonus! Add UC Davis here to see how it compares :>).


```r
?theme
colleges %>% 
  filter(CITY == "Claremont" | INSTNM == "University of California-Davis") %>% 
  ggplot(aes(x = reorder(INSTNM, COSTT4_A), y = COSTT4_A, fill = INSTNM)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Institution", y = "Annual Cost", title = "Comparison of Annual Cost in Claremont") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

```
## Warning: Removed 2 rows containing missing values (`geom_bar()`).
```

![](hw9_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


6. The column `ADM_RATE` is the admissions rate by college and `C150_4_POOLED` is the four-year completion rate. Use a scatterplot to show the relationship between these two variables. What do you think this means?

```r
colleges %>% 
  ggplot(aes(x = ADM_RATE, y = C150_4_POOLED)) +
  geom_point() +
  labs(x = "Admissions Rate", y = "Four-Year Completion Rate", title = "Relationship between Admissions Rate and Four-Year Completion Rate")
```

```
## Warning: Removed 251 rows containing missing values (`geom_point()`).
```

![](hw9_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
It looks like admissions rate and 4 year completion rate are negatively correlated. 
7. Is there a relationship between cost and four-year completion rate? (You don't need to do the stats, just produce a plot). What do you think this means?


```r
colleges %>% 
  ggplot(aes(x = COSTT4_A, y = C150_4_POOLED)) +
  geom_point() +
  labs(x = "Annual Cost", y = "Four-Year Completion Rate", title = "Relationship between Cost and Four-Year Completion Rate")
```

```
## Warning: Removed 225 rows containing missing values (`geom_point()`).
```

![](hw9_files/figure-html/unnamed-chunk-10-1.png)<!-- -->
It looks like cost and completion rate are positively correlated. 

8. The column titled `INSTNM` is the institution name. We are only interested in the University of California colleges. Make a new data frame that is restricted to UC institutions. You can remove `Hastings College of Law` and `UC San Francisco` as we are only interested in undergraduate institutions.

Remove `Hastings College of Law` and `UC San Francisco` and store the final data frame as a new object `univ_calif_final`.

Use `separate()` to separate institution name into two new columns "UNIV" and "CAMPUS".


```r
univ_calif_final <- colleges %>% 
  filter(grepl("University of California", INSTNM)) %>% 
  filter(!grepl("Hastings College of Law|UC San Francisco", INSTNM)) %>% 
  separate(INSTNM, into = c("UNIV", "CAMPUS"), sep = "-")

summary(univ_calif_final$ADM_RATE)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##  0.1693  0.3124  0.3821  0.3918  0.4617  0.6634       1
```

```r
univ_calif_final %>% 
  ggplot(aes(x = reorder(CAMPUS, ADM_RATE), y = ADM_RATE)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Campus", y = "Admissions Rate", title = "Admissions Rate of UC Campuses") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

```
## Warning: Removed 1 rows containing missing values (`position_stack()`).
```

![](hw9_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

9. The column `ADM_RATE` is the admissions rate by campus. Which UC has the lowest and highest admissions rates? Produce a numerical summary and an appropriate plot.

As you can see above, the highest admissions rate is UC Riverside and lowest is UC Berkeley.


10. If you wanted to get a degree in biological or biomedical sciences, which campus confers the majority of these degrees? Produce a numerical summary and an appropriate plot.


```r
bio_degrees <- univ_calif_final %>% 
  filter(PCIP26 > 0)
```



```r
bio_degrees_summary <- bio_degrees %>% 
  group_by(CAMPUS) %>% 
  summarise(avg_bio_degrees = mean(PCIP26))
```



```r
ggplot(bio_degrees_summary, aes(x = reorder(CAMPUS, avg_bio_degrees), y = avg_bio_degrees)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Campus", y = "Average Percentage of Bio/Biomedical Degrees", title = "Distribution of Bio/Biomedical Degrees by UC Campuses") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](hw9_files/figure-html/unnamed-chunk-14-1.png)<!-- -->
The majority of biological or biomedical science degrees are conferred by UC San Diego.

## Knit Your Output and Post to [GitHub](https://github.com/FRS417-DataScienceBiologists)

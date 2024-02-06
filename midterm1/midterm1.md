---
title: "Midterm 1 W24"
author: "Meghana Manepalli"
date: "2024-02-06"
output:
  html_document: 
    keep_md: yes
  pdf_document: default
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code must be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. 

Your code must knit in order to be considered. If you are stuck and cannot answer a question, then comment out your code and knit the document. You may use your notes, labs, and homework to help you complete this exam. Do not use any other resources- including AI assistance.  

Don't forget to answer any questions that are asked in the prompt!  

Be sure to push your completed midterm to your repository. This exam is worth 30 points.  

## Background
In the data folder, you will find data related to a study on wolf mortality collected by the National Park Service. You should start by reading the `README_NPSwolfdata.pdf` file. This will provide an abstract of the study and an explanation of variables.  

The data are from: Cassidy, Kira et al. (2022). Gray wolf packs and human-caused wolf mortality. [Dryad](https://doi.org/10.5061/dryad.mkkwh713f). 

## Load the libraries

```r
library("tidyverse")
library("janitor")
```

## Load the wolves data
In these data, the authors used `NULL` to represent missing values. I am correcting this for you below and using `janitor` to clean the column names.

```r
wolves <- read.csv("data/NPS_wolfmortalitydata.csv", na = c("NULL")) %>% clean_names()
```

- Knit exam
- Open HTML File
- Save as PDF
- Upload PDF to Gradescope

## Questions
Problem 1. (1 point) Let's start with some data exploration. What are the variable (column) names?  


```r
names(wolves)
```

```
##  [1] "park"         "biolyr"       "pack"         "packcode"     "packsize_aug"
##  [6] "mort_yn"      "mort_all"     "mort_lead"    "mort_nonlead" "reprody1"    
## [11] "persisty1"
```
The column names are park, biolyr, pack, packcode, packsize_aug, mort_yn, mort_all, mort_lead, mort_nonlead, reprody1, and persisty1.

Problem 2. (1 point) Use the function of your choice to summarize the data and get an idea of its structure.  


```r
summary(wolves)
```

```
##      park               biolyr         pack              packcode     
##  Length:864         Min.   :1986   Length:864         Min.   :  2.00  
##  Class :character   1st Qu.:1999   Class :character   1st Qu.: 48.00  
##  Mode  :character   Median :2006   Mode  :character   Median : 86.50  
##                     Mean   :2005                      Mean   : 91.39  
##                     3rd Qu.:2012                      3rd Qu.:133.00  
##                     Max.   :2021                      Max.   :193.00  
##                                                                       
##   packsize_aug       mort_yn          mort_all         mort_lead      
##  Min.   : 0.000   Min.   :0.0000   Min.   : 0.0000   Min.   :0.00000  
##  1st Qu.: 5.000   1st Qu.:0.0000   1st Qu.: 0.0000   1st Qu.:0.00000  
##  Median : 8.000   Median :0.0000   Median : 0.0000   Median :0.00000  
##  Mean   : 8.789   Mean   :0.1956   Mean   : 0.3715   Mean   :0.09552  
##  3rd Qu.:12.000   3rd Qu.:0.0000   3rd Qu.: 0.0000   3rd Qu.:0.00000  
##  Max.   :37.000   Max.   :1.0000   Max.   :24.0000   Max.   :3.00000  
##  NA's   :55                                          NA's   :16       
##   mort_nonlead        reprody1        persisty1     
##  Min.   : 0.0000   Min.   :0.0000   Min.   :0.0000  
##  1st Qu.: 0.0000   1st Qu.:1.0000   1st Qu.:1.0000  
##  Median : 0.0000   Median :1.0000   Median :1.0000  
##  Mean   : 0.2641   Mean   :0.7629   Mean   :0.8865  
##  3rd Qu.: 0.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
##  Max.   :22.0000   Max.   :1.0000   Max.   :1.0000  
##  NA's   :12        NA's   :71       NA's   :9
```

Problem 3. (3 points) Which parks/ reserves are represented in the data? Don't just use the abstract, pull this information from the data.  


```r
table(wolves$park)
```

```
## 
## DENA GNTP  VNP  YNP YUCH 
##  340   77   48  248  151
```
The parks represented are DENA (Denali National Park and Reserve), GNTP (Grand Teton National Park), VNP (Voyageurs National Park), YNP (Yellowstone National Park), and YUCH (Yukon-Charley Rivers National Preserve).

Problem 4. (4 points) Which park has the largest number of wolf packs?

```r
wolves %>% 
  select(park, pack) %>% 
  group_by(park) %>% 
  summarize(packs=n_distinct(pack))
```

```
## # A tibble: 5 × 2
##   park  packs
##   <chr> <int>
## 1 DENA     69
## 2 GNTP     12
## 3 VNP      22
## 4 YNP      46
## 5 YUCH     36
```
Denalie NP has the largest number of packs with 69 packs.
Problem 5. (4 points) Which park has the highest total number of human-caused mortalities `mort_all`?


```r
wolves %>% 
  select(park, mort_all) %>% 
  group_by(park) %>% 
  summarize(park, total=sum(mort_all)) %>% 
  arrange(desc(total))
```

```
## Warning: Returning more (or less) than 1 row per `summarise()` group was deprecated in
## dplyr 1.1.0.
## ℹ Please use `reframe()` instead.
## ℹ When switching from `summarise()` to `reframe()`, remember that `reframe()`
##   always returns an ungrouped data frame and adjust accordingly.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## `summarise()` has grouped output by 'park'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 864 × 2
## # Groups:   park [5]
##    park  total
##    <chr> <int>
##  1 YUCH    136
##  2 YUCH    136
##  3 YUCH    136
##  4 YUCH    136
##  5 YUCH    136
##  6 YUCH    136
##  7 YUCH    136
##  8 YUCH    136
##  9 YUCH    136
## 10 YUCH    136
## # ℹ 854 more rows
```
YUCH (Yukon Charley Rivers National Preserve) has the highest number of human-caused mortalities in total.

The wolves in [Yellowstone National Park](https://www.nps.gov/yell/learn/nature/wolf-restoration.htm) are an incredible conservation success story. Let's focus our attention on this park.  

Problem 6. (2 points) Create a new object "ynp" that only includes the data from Yellowstone National Park.  


```r
ynp <- filter(wolves, park=="YNP")
```


Problem 7. (3 points) Among the Yellowstone wolf packs, the [Druid Peak Pack](https://www.pbs.org/wnet/nature/in-the-valley-of-the-wolves-the-druid-wolf-pack-story/209/) is one of most famous. What was the average pack size of this pack for the years represented in the data?


```r
ynp %>% 
  filter(pack=="druid") %>% 
  filter(!is.na(packsize_aug)) %>% 
  summarize(average_size=mean(packsize_aug))
```

```
##   average_size
## 1     13.93333
```
The average size of the druid peak pack in the years represented in the data is 13.93.

Problem 8. (4 points) Pack dynamics can be hard to predict- even for strong packs like the Druid Peak pack. At which year did the Druid Peak pack have the largest pack size? What do you think happened in 2010?


```r
ynp %>% 
  select(biolyr, packsize_aug, pack) %>% 
  filter(pack=="druid") %>% 
  filter(!is.na(packsize_aug)) %>% 
  arrange(desc(packsize_aug))
```

```
##    biolyr packsize_aug  pack
## 1    2001           37 druid
## 2    2000           27 druid
## 3    2008           21 druid
## 4    2003           18 druid
## 5    2007           18 druid
## 6    2002           16 druid
## 7    2006           15 druid
## 8    2004           13 druid
## 9    2009           12 druid
## 10   1999            9 druid
## 11   1998            8 druid
## 12   1997            5 druid
## 13   1996            5 druid
## 14   2005            5 druid
## 15   2010            0 druid
```
In 2001, the Druid Peak Pack was largest with a size of 37. In 2010, the pack died off likely due to disease or environmental factors. 

Problem 9. (5 points) Among the YNP wolf packs, which one has had the highest overall persistence `persisty1` for the years represented in the data? Look this pack up online and tell me what is unique about its behavior- specifically, what prey animals does this pack specialize on?  


```r
ynp %>% 
  select(pack, persisty1) %>% 
  group_by(pack) %>% 
  summarize(pack, most_per=sum(persisty1, na.rm=T)) %>% 
  arrange(desc(most_per))
```

```
## Warning: Returning more (or less) than 1 row per `summarise()` group was deprecated in
## dplyr 1.1.0.
## ℹ Please use `reframe()` instead.
## ℹ When switching from `summarise()` to `reframe()`, remember that `reframe()`
##   always returns an ungrouped data frame and adjust accordingly.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## `summarise()` has grouped output by 'pack'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 248 × 2
## # Groups:   pack [46]
##    pack    most_per
##    <chr>      <int>
##  1 mollies       26
##  2 mollies       26
##  3 mollies       26
##  4 mollies       26
##  5 mollies       26
##  6 mollies       26
##  7 mollies       26
##  8 mollies       26
##  9 mollies       26
## 10 mollies       26
## # ℹ 238 more rows
```
The most persistent pack over the year were the mollies with 26 total 1s in the persisty1 column. They are unique for hunting bison and having regular interactions with bears, and they often prey on bison.

Problem 10. (3 points) Perform one analysis or exploration of your choice on the `wolves` data. Your answer needs to include at least two lines of code and not be a summary function.  


```r
wolves %>% 
  filter(park=="DENA") %>% 
  select(park, pack, packsize_aug, biolyr) %>% 
  arrange(desc(packsize_aug))
```

```
##     park             pack packsize_aug biolyr
## 1   DENA        East Fork           33   1990
## 2   DENA        East Fork           27   1989
## 3   DENA         100 Mile           23   2000
## 4   DENA      Birch Creek           23   1988
## 5   DENA      Little Bear           23   1991
## 6   DENA        East Fork           20   2013
## 7   DENA           McLeod           20   1990
## 8   DENA        East Fork           19   1988
## 9   DENA  McKinley Slough           19   2010
## 10  DENA        East Fork           17   2014
## 11  DENA      Riley Creek           17   2017
## 12  DENA          Bearpaw           17   2017
## 13  DENA      Pinto Creek           17   2000
## 14  DENA      Pinto Creek           17   2001
## 15  DENA          Bearpaw           16   2016
## 16  DENA        East Fork           16   1991
## 17  DENA        East Fork           16   2008
## 18  DENA      Grant Creek           16   2010
## 19  DENA        East Fork           15   1992
## 20  DENA        East Fork           15   2006
## 21  DENA      Birch Creek           15   1989
## 22  DENA        East Fork           15   2007
## 23  DENA  Iron Creek West           15   2015
## 24  DENA      John Hansen           15   2017
## 25  DENA  McKinley Slough           15   2007
## 26  DENA  McKinley Slough           15   2009
## 27  DENA  McKinley Slough           15   2011
## 28  DENA           McLeod           15   1993
## 29  DENA        Sanctuary           15   1997
## 30  DENA        East Fork           14   2005
## 31  DENA      Pinto Creek           14   1999
## 32  DENA         100 Mile           14   2002
## 33  DENA        East Fork           14   1995
## 34  DENA      Grant Creek           14   2009
## 35  DENA     Headquarters           14   1989
## 36  DENA     Nenana River           14   2014
## 37  DENA      Riley Creek           14   2016
## 38  DENA        East Fork           13   1996
## 39  DENA        East Fork           13   2012
## 40  DENA      Grant Creek           13   2006
## 41  DENA      Grant Creek           13   2011
## 42  DENA           McLeod           13   1991
## 43  DENA           McLeod           13   1992
## 44  DENA           McLeod           13   1996
## 45  DENA  McKinley River1           12   1996
## 46  DENA        East Fork           12   2004
## 47  DENA      Mt Margaret           12   2003
## 48  DENA         100 Mile           12   1999
## 49  DENA Chitsia Mountain           12   1991
## 50  DENA        East Fork           12   2009
## 51  DENA          Foraker           12   1995
## 52  DENA      Grant Creek           12   2016
## 53  DENA        Highpower           12   1990
## 54  DENA      Little Bear           12   1989
## 55  DENA      Little Bear           12   1992
## 56  DENA      Little Bear           12   1993
## 57  DENA           McLeod           12   1988
## 58  DENA           McLeod           12   1989
## 59  DENA     Straightaway           12   2002
## 60  DENA          Chitsia           11   2007
## 61  DENA        East Fork           11   2010
## 62  DENA           Somber           11   2007
## 63  DENA     Straightaway           11   2003
## 64  DENA         100 Mile           11   1998
## 65  DENA      Birch Creek           11   1987
## 66  DENA          Chitsia           11   2006
## 67  DENA     Headquarters           11   1990
## 68  DENA        Highpower           11   1991
## 69  DENA      McLeod West           11   1991
## 70  DENA      Mt Margaret           11   2006
## 71  DENA            Pinto           10   2007
## 72  DENA        East Fork           10   2000
## 73  DENA          Bearpaw           10   2006
## 74  DENA          Bearpaw           10   2007
## 75  DENA         Bearpaw1           10   1987
## 76  DENA        East Fork           10   2001
## 77  DENA        East Fork           10   2011
## 78  DENA     Headquarters           10   1991
## 79  DENA           Herron           10   2002
## 80  DENA        Highpower           10   1989
## 81  DENA       Hot Slough           10   2011
## 82  DENA  Iron Creek West           10   2016
## 83  DENA   McKinley River           10   2007
## 84  DENA  McKinley Slough           10   2005
## 85  DENA           McLeod           10   1994
## 86  DENA      Mt Margaret           10   2002
## 87  DENA      Mt Margaret           10   2005
## 88  DENA      Pinto Creek           10   2002
## 89  DENA        Sanctuary           10   1996
## 90  DENA         Stampede           10   1989
## 91  DENA       Starr Lake           10   2003
## 92  DENA     Straightaway           10   2000
## 93  DENA          Savage1            9   1995
## 94  DENA     Nenana River            9   2013
## 95  DENA          Savage1            9   1994
## 96  DENA     Headquarters            9   1993
## 97  DENA        Sanctuary            9   2000
## 98  DENA      Beaver Fork            9   1996
## 99  DENA Chitsia Mountain            9   1992
## 100 DENA        East Fork            9   1986
## 101 DENA        East Fork            9   1993
## 102 DENA        East Fork            9   1994
## 103 DENA        East Fork            9   1999
## 104 DENA          Foraker            9   1990
## 105 DENA          Foraker            9   2000
## 106 DENA       Iron Creek            9   2010
## 107 DENA  McKinley River1            9   1991
## 108 DENA     Pirate Creek            9   1988
## 109 DENA      Riley Creek            9   2015
## 110 DENA       Starr Lake            9   2005
## 111 DENA     Straightaway            9   2001
## 112 DENA      Eagle Gorge            8   2017
## 113 DENA         100 Mile            8   2003
## 114 DENA       Hot Slough            8   2008
## 115 DENA      Little Bear            8   1994
## 116 DENA         100 Mile            8   2001
## 117 DENA          Bearpaw            8   2012
## 118 DENA          Bearpaw            8   2015
## 119 DENA          Chitsia            8   2005
## 120 DENA Chitsia Mountain            8   1990
## 121 DENA Chitsia Mountain            8   1993
## 122 DENA       Clearwater            8   1989
## 123 DENA        East Fork            8   1987
## 124 DENA        East Fork            8   2003
## 125 DENA        Ewe Creek            8   1987
## 126 DENA          Foraker            8   1991
## 127 DENA          Foraker            8   1997
## 128 DENA          Foraker            8   1998
## 129 DENA          Foraker            8   1999
## 130 DENA           Herron            8   2004
## 131 DENA        Highpower            8   1988
## 132 DENA       Iron Creek            8   2011
## 133 DENA      John Hansen            8   2013
## 134 DENA      John Hansen            8   2016
## 135 DENA  Kantishna River            8   2003
## 136 DENA  Kantishna River            8   2010
## 137 DENA  McKinley River1            8   1990
## 138 DENA  McKinley Slough            8   2003
## 139 DENA  McKinley Slough            8   2004
## 140 DENA  McKinley Slough            8   2006
## 141 DENA     Nenana River            8   2012
## 142 DENA      Pinto Creek            8   1998
## 143 DENA          Savage1            8   1993
## 144 DENA           Somber            8   2008
## 145 DENA         Stampede            8   1995
## 146 DENA     Turtle Hill1            8   1992
## 147 DENA      Windy Creek            8   1987
## 148 DENA          Foraker            7   1992
## 149 DENA    Castle Rocks2            7   2003
## 150 DENA      Grant Creek            7   2013
## 151 DENA      John Hansen            7   2014
## 152 DENA  McKinley River1            7   1992
## 153 DENA         100 Mile            7   1997
## 154 DENA    Castle Rocks3            7   2007
## 155 DENA          Chitsia            7   2008
## 156 DENA      Corner Lake            7   1996
## 157 DENA        East Fork            7   1997
## 158 DENA        East Fork            7   1998
## 159 DENA          Foraker            7   1989
## 160 DENA     Headquarters            7   1988
## 161 DENA           Herron            7   2003
## 162 DENA       Hot Slough            7   2007
## 163 DENA       Hot Slough            7   2009
## 164 DENA  Kantishna River            7   2005
## 165 DENA      Little Bear            7   1988
## 166 DENA  McKinley Slough            7   2002
## 167 DENA           McLeod            7   1987
## 168 DENA           McLeod            7   1995
## 169 DENA      Mt Margaret            7   2004
## 170 DENA      Mt Margaret            7   2007
## 171 DENA     Nenana River            7   2011
## 172 DENA      Otter Creek            7   1998
## 173 DENA         Stampede            7   1988
## 174 DENA         Stampede            7   1994
## 175 DENA       Starr Lake            7   2004
## 176 DENA            Stony            7   1997
## 177 DENA     Turtle Hill1            7   1993
## 178 DENA     Headquarters            6   1994
## 179 DENA          McLeod2            6   2007
## 180 DENA          Bearpaw            6   2005
## 181 DENA          Bearpaw            6   2010
## 182 DENA          Bearpaw            6   2011
## 183 DENA      Beaver Fork            6   1997
## 184 DENA    Castle Rocks3            6   2006
## 185 DENA    Chilchukabena            6   1991
## 186 DENA       Clearwater            6   1986
## 187 DENA       Clearwater            6   1987
## 188 DENA          Foraker            6   1994
## 189 DENA      Grant Creek            6   2005
## 190 DENA      Grant Creek            6   2008
## 191 DENA      Grant Creek            6   2015
## 192 DENA  Iron Creek West            6   2013
## 193 DENA  Iron Creek West            6   2014
## 194 DENA      Jenny Creek            6   1993
## 195 DENA  Kantishna River            6   2000
## 196 DENA  Kantishna River            6   2001
## 197 DENA  Kantishna River            6   2009
## 198 DENA   McKinley River            6   2004
## 199 DENA   McKinley River            6   2006
## 200 DENA           McLeod            6   1997
## 201 DENA      Mt Margaret            6   2001
## 202 DENA           Myrtle            6   2015
## 203 DENA     Nenana River            6   2009
## 204 DENA      Otter Creek            6   1999
## 205 DENA      Riley Creek            6   2014
## 206 DENA        Sanctuary            6   1999
## 207 DENA    Sandless Lake            6   1997
## 208 DENA           Savage            6   2008
## 209 DENA           Somber            6   2010
## 210 DENA           Somber            6   2012
## 211 DENA         Stampede            6   1998
## 212 DENA       Starr Lake            6   2007
## 213 DENA       Starr Lake            6   2009
## 214 DENA            Stony            6   1996
## 215 DENA    Birch Creek N            5   1991
## 216 DENA        Ewe Creek            5   1988
## 217 DENA      Grant Creek            5   2007
## 218 DENA      Grant Creek            5   2012
## 219 DENA      Mt Margaret            5   2009
## 220 DENA           Myrtle            5   2016
## 221 DENA          Bearpaw            5   2004
## 222 DENA          Bearpaw            5   2008
## 223 DENA      Eagle Gorge            5   2016
## 224 DENA      Grant Creek            5   2004
## 225 DENA      Grant Creek            5   2017
## 226 DENA     Headquarters            5   1992
## 227 DENA  Iron Creek East            5   2013
## 228 DENA  Kantishna River            5   2002
## 229 DENA  Kantishna River            5   2008
## 230 DENA  McKinley Slough            5   2012
## 231 DENA     Nenana River            5   2010
## 232 DENA       North Fork            5   1999
## 233 DENA       North Fork            5   2001
## 234 DENA            Pinto            5   2006
## 235 DENA        Sanctuary            5   1995
## 236 DENA   Slippery Creek            5   1991
## 237 DENA           Somber            5   2013
## 238 DENA           Somber            5   2015
## 239 DENA      White Creek            5   1996
## 240 DENA      Windy Creek            5   1988
## 241 DENA        East Fork            4   2015
## 242 DENA      Hauke Creek            4   2007
## 243 DENA      Birch Hills            4   1999
## 244 DENA    Caribou Creek            4   1997
## 245 DENA          Chitsia            4   2004
## 246 DENA Chitsia Mountain            4   1989
## 247 DENA Chitsia Mountain            4   1994
## 248 DENA       Clearwater            4   1988
## 249 DENA      Corner Lake            4   1995
## 250 DENA      Corner Lake            4   1997
## 251 DENA        East Fork            4   2002
## 252 DENA      Grant Creek            4   2014
## 253 DENA  McKinley Slough            4   2013
## 254 DENA      Muddy River            4   2001
## 255 DENA       North Fork            4   2000
## 256 DENA     Straightaway            4   2004
## 257 DENA      White Creek            4   1998
## 258 DENA        East Fork            3   2016
## 259 DENA      Muddy River            3   2003
## 260 DENA         Stampede            3   1990
## 261 DENA       Starr Lake            3   2006
## 262 DENA         100 Mile            3   2004
## 263 DENA      Beaver Fork            3   1998
## 264 DENA      Beaver Fork            3   1999
## 265 DENA        Boot Lake            3   2009
## 266 DENA          Brooker            3   2001
## 267 DENA     Death Valley            3   2001
## 268 DENA       Hot Slough            3   2010
## 269 DENA       Hot Slough            3   2012
## 270 DENA       Hot Slough            3   2013
## 271 DENA       Hot Slough            3   2014
## 272 DENA      John Hansen            3   2015
## 273 DENA  McKinley River1            3   1993
## 274 DENA  McKinley Slough            3   2000
## 275 DENA      Mt Margaret            3   2000
## 276 DENA        Sanctuary            3   1998
## 277 DENA         Stampede            3   1993
## 278 DENA         Stampede            3   1999
## 279 DENA       Starr Lake            3   2008
## 280 DENA       Starr Lake            3   2010
## 281 DENA            Stony            3   1998
## 282 DENA            Stony            3   1999
## 283 DENA     Turtle Hill             3   2005
## 284 DENA     Turtle Hill             3   2006
## 285 DENA      White Creek            3   1997
## 286 DENA  Iron Creek West            2   2017
## 287 DENA      Mt Margaret            2   2008
## 288 DENA         Stampede            2   1991
## 289 DENA          Bearpaw            2   2009
## 290 DENA          Bearpaw            2   2014
## 291 DENA        Boot Lake            2   2008
## 292 DENA          Brooker            2   2002
## 293 DENA    Castle Rocks3            2   2008
## 294 DENA     Death Valley            2   2000
## 295 DENA     Death Valley            2   2002
## 296 DENA      Grant Creek            2   2002
## 297 DENA      Grant Creek            2   2003
## 298 DENA     Headquarters            2   1986
## 299 DENA     Headquarters            2   1987
## 300 DENA  Iron Creek East            2   2014
## 301 DENA  Kantishna River            2   2004
## 302 DENA   McKinley River            2   2005
## 303 DENA  McKinley Slough            2   1999
## 304 DENA  McKinley Slough            2   2001
## 305 DENA  McKinley Slough            2   2014
## 306 DENA  McKinley Slough            2   2015
## 307 DENA  McKinley Slough            2   2016
## 308 DENA      Moose Creek            2   2009
## 309 DENA      Muddy River            2   2000
## 310 DENA      Muddy River            2   2002
## 311 DENA       Otter Lake            2   2009
## 312 DENA Riley Creek West            2   2018
## 313 DENA           Somber            2   2009
## 314 DENA           Somber            2   2014
## 315 DENA         Stampede            2   1992
## 316 DENA         Stampede            2   1997
## 317 DENA         Stampede            2   2000
## 318 DENA         Stampede            2   2001
## 319 DENA       Starr Lake            2   2001
## 320 DENA       Starr Lake            2   2002
## 321 DENA            Stony            2   1995
## 322 DENA      White Creek            2   1999
## 323 DENA  Kantishna River            1   2006
## 324 DENA          Tonzona            1   2009
## 325 DENA          Bearpaw            1   2013
## 326 DENA    Castle Rocks2            1   2004
## 327 DENA      Corner Lake            1   1998
## 328 DENA          Foraker            1   2001
## 329 DENA  Kantishna River            1   2007
## 330 DENA   Slippery Creek            1   1992
## 331 DENA     Death Valley            0   2003
## 332 DENA      Birch Hills            0   2000
## 333 DENA      Hauke Creek            0   2008
## 334 DENA       Hot Slough            0   2015
## 335 DENA      Little Bear            0   1995
## 336 DENA      Moose Creek            0   2010
## 337 DENA           Savage           NA   2007
## 338 DENA      Pinto Creek           NA   1997
## 339 DENA          Foraker           NA   1993
## 340 DENA          Foraker           NA   1996
```
This shows that the largest wolf pack that has existed in Denali NP was the East Fork pack in the year 1990 with 33 members. 

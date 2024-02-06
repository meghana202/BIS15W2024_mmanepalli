---
title: "Lab 7 Homework"
author: "Meghana Manepalli"
date: "2024-02-05"
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
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv(file = "data/FAO_1950to2012_111914.csv")
```

```
## Rows: 17692 Columns: 71
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (69): Country, Common name, ISSCAAP taxonomic group, ASFIS species#, ASF...
## dbl  (2): ISSCAAP group#, FAO major fishing area
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
summary(fisheries)
```

```
##    Country          Common name        ISSCAAP group#  ISSCAAP taxonomic group
##  Length:17692       Length:17692       Min.   :11.00   Length:17692           
##  Class :character   Class :character   1st Qu.:33.00   Class :character       
##  Mode  :character   Mode  :character   Median :36.00   Mode  :character       
##                                        Mean   :37.38                          
##                                        3rd Qu.:38.00                          
##                                        Max.   :77.00                          
##  ASFIS species#     ASFIS species name FAO major fishing area
##  Length:17692       Length:17692       Min.   :18.00         
##  Class :character   Class :character   1st Qu.:31.00         
##  Mode  :character   Mode  :character   Median :37.00         
##                                        Mean   :45.34         
##                                        3rd Qu.:57.00         
##                                        Max.   :88.00         
##    Measure              1950               1951               1952          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1953               1954               1955               1956          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1957               1958               1959               1960          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1961               1962               1963               1964          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1965               1966               1967               1968          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1969               1970               1971               1972          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1973               1974               1975               1976          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1977               1978               1979               1980          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1981               1982               1983               1984          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1985               1986               1987               1988          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1989               1990               1991               1992          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1993               1994               1995               1996          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      1997               1998               1999               2000          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      2001               2002               2003               2004          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      2005               2006               2007               2008          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##      2009               2010               2011               2012          
##  Length:17692       Length:17692       Length:17692       Length:17692      
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
## 
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <- clean_names(fisheries)
class(fisheries$country) <- "Factor"
class(fisheries$isscaap_group_number) <- "Factor"
class(fisheries$asfis_species_number) <- "Factor"
class(fisheries$fao_major_fishing_area) <- "Factor"
```

We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!  

```r
fisheries_tidy <- fisheries %>% 
pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
              names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
table(fisheries_tidy$country)
```

```
## 
##                   Albania                   Algeria            American Samoa 
##                       934                      1561                       556 
##                    Angola                  Anguilla       Antigua and Barbuda 
##                      2119                       129                       356 
##                 Argentina                     Aruba                 Australia 
##                      3403                       172                      8183 
##                   Bahamas                   Bahrain                Bangladesh 
##                       423                      1169                       169 
##                  Barbados                   Belgium                    Belize 
##                       795                      2530                      1075 
##                     Benin                   Bermuda  Bonaire/S.Eustatius/Saba 
##                      1419                       846                         4 
##    Bosnia and Herzegovina                    Brazil  British Indian Ocean Ter 
##                        21                      4784                        97 
##    British Virgin Islands         Brunei Darussalam                  Bulgaria 
##                       332                       186                      1596 
##                Cabo Verde                  Cambodia                  Cameroon 
##                       462                       238                      1340 
##                    Canada            Cayman Islands           Channel Islands 
##                      5099                        84                      1313 
##                     Chile                     China      China, Hong Kong SAR 
##                      3878                      2801                      1782 
##          China, Macao SAR                  Colombia                   Comoros 
##                       206                      2710                       965 
##   Congo, Dem. Rep. of the        Congo, Republic of              Cook Islands 
##                       484                      1527                       810 
##                Costa Rica                   Croatia                      Cuba 
##                      1171                       947                      2981 
##                Cura\xe7ao                    Cyprus          C\xf4te d'Ivoire 
##                        18                      1703                      1859 
##                   Denmark                  Djibouti                  Dominica 
##                      3741                       352                       213 
##        Dominican Republic                   Ecuador                     Egypt 
##                      1958                      1595                      2467 
##               El Salvador         Equatorial Guinea                   Eritrea 
##                       620                       551                       653 
##                   Estonia                  Ethiopia    Falkland Is.(Malvinas) 
##                      1088                       129                       502 
##             Faroe Islands         Fiji, Republic of                   Finland 
##                      2283                      1798                       706 
##                    France             French Guiana          French Polynesia 
##                     10639                       231                       672 
##      French Southern Terr                     Gabon                    Gambia 
##                       139                      1089                      1214 
##                   Georgia                   Germany                     Ghana 
##                       428                      4813                      2462 
##                 Gibraltar                    Greece                 Greenland 
##                        61                      4091                      1311 
##                   Grenada                Guadeloupe                      Guam 
##                      1635                       372                       520 
##                 Guatemala                    Guinea              GuineaBissau 
##                       622                       697                       634 
##                    Guyana                     Haiti                  Honduras 
##                       251                       204                       842 
##                   Iceland                     India                 Indonesia 
##                      2346                      5588                      9274 
##    Iran (Islamic Rep. of)                      Iraq                   Ireland 
##                      1210                       150                      3235 
##               Isle of Man                    Israel                     Italy 
##                       952                      1359                      4567 
##                   Jamaica                     Japan                    Jordan 
##                       149                     15429                       226 
##                     Kenya                  Kiribati  Korea, Dem. People's Rep 
##                       958                       875                       210 
##        Korea, Republic of                    Kuwait                    Latvia 
##                     10824                       805                      1101 
##                   Lebanon                   Liberia                     Libya 
##                       614                      1514                       578 
##                 Lithuania                Madagascar                  Malaysia 
##                      1274                      1008                      6963 
##                  Maldives                     Malta          Marshall Islands 
##                       487                      2156                       292 
##                Martinique                Mauritania                 Mauritius 
##                       672                      1501                       991 
##                   Mayotte                    Mexico Micronesia, Fed.States of 
##                       194                      6202                       413 
##                    Monaco                Montenegro                Montserrat 
##                        43                       168                        63 
##                   Morocco                Mozambique                   Myanmar 
##                      4758                       434                       117 
##                   Namibia                     Nauru               Netherlands 
##                       905                       150                      2944 
##      Netherlands Antilles             New Caledonia               New Zealand 
##                       338                       789                      4594 
##                 Nicaragua                   Nigeria                      Niue 
##                       904                      1479                       145 
##            Norfolk Island      Northern Mariana Is.                    Norway 
##                        41                       488                      3747 
##                      Oman                 Other nei                  Pakistan 
##                      1086                      1556                      2166 
##                     Palau   Palestine, Occupied Tr.                    Panama 
##                       636                       429                      1773 
##          Papua New Guinea                      Peru               Philippines 
##                       686                      2767                      4548 
##          Pitcairn Islands                    Poland                  Portugal 
##                        63                      2553                     11570 
##               Puerto Rico                     Qatar                   Romania 
##                       918                       941                      1738 
##        Russian Federation                R\xe9union       Saint Barth\xe9lemy 
##                      4736                       736                         6 
##              Saint Helena     Saint Kitts and Nevis               Saint Lucia 
##                       609                       397                       558 
##  Saint Vincent/Grenadines               SaintMartin                     Samoa 
##                       715                         6                       386 
##     Sao Tome and Principe              Saudi Arabia                   Senegal 
##                      1035                      2200                      2988 
##     Serbia and Montenegro                Seychelles              Sierra Leone 
##                       516                      1142                      1526 
##                 Singapore              Sint Maarten                  Slovenia 
##                      1937                         4                       644 
##           Solomon Islands                   Somalia              South Africa 
##                       505                       141                      3881 
##                     Spain                 Sri Lanka   St. Pierre and Miquelon 
##                     17482                      1351                      1038 
##                     Sudan            Sudan (former)                  Suriname 
##                         3                        90                       234 
##    Svalbard and Jan Mayen                    Sweden      Syrian Arab Republic 
##                        41                      3115                       793 
##  Taiwan Province of China  Tanzania, United Rep. of                  Thailand 
##                      9927                      1277                      4843 
##                TimorLeste                      Togo                   Tokelau 
##                        98                      1723                       102 
##                     Tonga       Trinidad and Tobago                   Tunisia 
##                       403                       923                      3019 
##                    Turkey      Turks and Caicos Is.                    Tuvalu 
##                      3326                       193                       162 
##                   Ukraine        Un. Sov. Soc. Rep.      United Arab Emirates 
##                      1823                      7084                      1801 
##            United Kingdom  United States of America                   Uruguay 
##                      6577                     18080                      2134 
##         US Virgin Islands                   Vanuatu   Venezuela, Boliv Rep of 
##                       348                       789                      3409 
##                  Viet Nam     Wallis and Futuna Is.                     Yemen 
##                       405                       128                      1278 
##            Yugoslavia SFR                  Zanzibar 
##                      1383                       247
```

```r
n_distinct(fisheries_tidy$country)
```

```
## [1] 203
```
There are 203 countries, the counts are listed above.
4. Refocus the data only to include country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
fisheries_tidy %>% select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch)
```

```
## # A tibble: 376,771 × 6
##    country  isscaap_taxonomic_gr…¹ asfis_species_name asfis_species_number  year
##    <Factor> <chr>                  <chr>              <Factor>             <dbl>
##  1 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            1995
##  2 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            1996
##  3 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            1997
##  4 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            1998
##  5 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            1999
##  6 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            2000
##  7 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            2001
##  8 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            2002
##  9 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            2003
## 10 Albania  Sharks, rays, chimaer… Squatinidae        10903XXXXX            2004
## # ℹ 376,761 more rows
## # ℹ abbreviated name: ¹​isscaap_taxonomic_group
## # ℹ 1 more variable: catch <dbl>
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
n_distinct(fisheries_tidy$asfis_species_name)
```

```
## [1] 1546
```
There are 1546 distinct species caught.
6. Which country had the largest overall catch in the year 2000?

```r
fisheries_tidy %>%
  filter(year == 2000) %>%
  group_by(country) %>%
  summarize(total_catch = sum(catch, na.rm = TRUE)) %>%
  arrange(desc(total_catch))
```

```
## # A tibble: 193 × 2
##    country                  total_catch
##    <Factor>                       <dbl>
##  1 China                          25899
##  2 Russian Federation             12181
##  3 United States of America       11762
##  4 Japan                           8510
##  5 Indonesia                       8341
##  6 Peru                            7443
##  7 Chile                           6906
##  8 India                           6351
##  9 Thailand                        6243
## 10 Korea, Republic of              6124
## # ℹ 183 more rows
```
China
7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
fisheries_tidy %>%
  filter(year >= 1990 & year <= 2000, asfis_species_name == "Sardina pilchardus") %>%
  group_by(country) %>%
  summarize(total_catch = sum(catch, na.rm = TRUE)) %>%
  arrange(desc(total_catch))
```

```
## # A tibble: 37 × 2
##    country               total_catch
##    <Factor>                    <dbl>
##  1 Morocco                      7470
##  2 Spain                        3507
##  3 Russian Federation           1639
##  4 Ukraine                      1030
##  5 France                        966
##  6 Portugal                      818
##  7 Greece                        528
##  8 Italy                         507
##  9 Serbia and Montenegro         478
## 10 Denmark                       477
## # ℹ 27 more rows
```
Morocco.
8. Which five countries caught the most cephalopods between 2008-2012?

```r
fisheries_tidy %>%
  filter(year >= 2008 & year <= 2012, asfis_species_name == "Cephalopoda") %>%
  group_by(country) %>%
  summarize(total_catch = sum(catch, na.rm = TRUE)) %>%
  arrange(desc(total_catch))
```

```
## # A tibble: 16 × 2
##    country                  total_catch
##    <Factor>                       <dbl>
##  1 India                            570
##  2 China                            257
##  3 Spain                            198
##  4 Algeria                          162
##  5 France                           101
##  6 Mauritania                        90
##  7 TimorLeste                        76
##  8 Italy                             66
##  9 Mozambique                        16
## 10 Cambodia                          15
## 11 Taiwan Province of China          13
## 12 Madagascar                        11
## 13 Croatia                            7
## 14 Israel                             0
## 15 Somalia                            0
## 16 Viet Nam                           0
```
Indonesia, China, Spain, Algeria and France.

9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
 fisheries_tidy %>%
  filter(year >= 2008 & year <= 2012) %>%
  group_by(asfis_species_name) %>%
  summarize(total_catch = sum(catch, na.rm = TRUE)) %>%
  arrange(desc(total_catch)) 
```

```
## # A tibble: 1,472 × 2
##    asfis_species_name    total_catch
##    <chr>                       <dbl>
##  1 Osteichthyes               107808
##  2 Theragra chalcogramma       41075
##  3 Engraulis ringens           35523
##  4 Katsuwonus pelamis          32153
##  5 Trichiurus lepturus         30400
##  6 Clupea harengus             28527
##  7 Thunnus albacares           20119
##  8 Scomber japonicus           14723
##  9 Gadus morhua                13253
## 10 Thunnus alalunga            12019
## # ℹ 1,462 more rows
```
Theragra chalcogramma had the greatest catch total.
10. Use the data to do at least one analysis of your choice.


```r
fisheries_tidy %>%
  filter(year >= 2008 & year <= 2012, country == "India") %>%
  group_by(asfis_species_name) %>%
  summarize(total_catch = sum(catch, na.rm = TRUE)) %>%
  arrange(desc(total_catch))
```

```
## # A tibble: 52 × 2
##    asfis_species_name   total_catch
##    <chr>                      <dbl>
##  1 Osteichthyes                4200
##  2 Harpadon nehereus           3172
##  3 Sardinella longiceps        2898
##  4 Natantia                    2780
##  5 Trichiuridae                2047
##  6 Sciaenidae                  1988
##  7 Penaeus monodon             1323
##  8 Cephalopoda                  570
##  9 Thunnus alalunga             544
## 10 Upeneus spp                  540
## # ℹ 42 more rows
```

Bombay duck (Harpadon nehereus) is the most common fish caught in India.
## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   

---
title: "dplyr Superhero"
date: "2024-01-30"
output:
  html_document:
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
---

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. This lab doubles as your homework. Please complete the lab and push your final code to GitHub.  

## Load the libraries

```r
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here. Before you do anything, first have a look at the names of the variables. You can use `rename()` or `clean_names()`.    

```r
names(superhero_info)
```

```
##  [1] "name"       "Gender"     "Eye color"  "Race"       "Hair color"
##  [6] "Height"     "Publisher"  "Skin color" "Alignment"  "Weight"
```


```r
names(superhero_powers)
```

```
##   [1] "hero_names"                   "Agility"                     
##   [3] "Accelerated Healing"          "Lantern Power Ring"          
##   [5] "Dimensional Awareness"        "Cold Resistance"             
##   [7] "Durability"                   "Stealth"                     
##   [9] "Energy Absorption"            "Flight"                      
##  [11] "Danger Sense"                 "Underwater breathing"        
##  [13] "Marksmanship"                 "Weapons Master"              
##  [15] "Power Augmentation"           "Animal Attributes"           
##  [17] "Longevity"                    "Intelligence"                
##  [19] "Super Strength"               "Cryokinesis"                 
##  [21] "Telepathy"                    "Energy Armor"                
##  [23] "Energy Blasts"                "Duplication"                 
##  [25] "Size Changing"                "Density Control"             
##  [27] "Stamina"                      "Astral Travel"               
##  [29] "Audio Control"                "Dexterity"                   
##  [31] "Omnitrix"                     "Super Speed"                 
##  [33] "Possession"                   "Animal Oriented Powers"      
##  [35] "Weapon-based Powers"          "Electrokinesis"              
##  [37] "Darkforce Manipulation"       "Death Touch"                 
##  [39] "Teleportation"                "Enhanced Senses"             
##  [41] "Telekinesis"                  "Energy Beams"                
##  [43] "Magic"                        "Hyperkinesis"                
##  [45] "Jump"                         "Clairvoyance"                
##  [47] "Dimensional Travel"           "Power Sense"                 
##  [49] "Shapeshifting"                "Peak Human Condition"        
##  [51] "Immortality"                  "Camouflage"                  
##  [53] "Element Control"              "Phasing"                     
##  [55] "Astral Projection"            "Electrical Transport"        
##  [57] "Fire Control"                 "Projection"                  
##  [59] "Summoning"                    "Enhanced Memory"             
##  [61] "Reflexes"                     "Invulnerability"             
##  [63] "Energy Constructs"            "Force Fields"                
##  [65] "Self-Sustenance"              "Anti-Gravity"                
##  [67] "Empathy"                      "Power Nullifier"             
##  [69] "Radiation Control"            "Psionic Powers"              
##  [71] "Elasticity"                   "Substance Secretion"         
##  [73] "Elemental Transmogrification" "Technopath/Cyberpath"        
##  [75] "Photographic Reflexes"        "Seismic Power"               
##  [77] "Animation"                    "Precognition"                
##  [79] "Mind Control"                 "Fire Resistance"             
##  [81] "Power Absorption"             "Enhanced Hearing"            
##  [83] "Nova Force"                   "Insanity"                    
##  [85] "Hypnokinesis"                 "Animal Control"              
##  [87] "Natural Armor"                "Intangibility"               
##  [89] "Enhanced Sight"               "Molecular Manipulation"      
##  [91] "Heat Generation"              "Adaptation"                  
##  [93] "Gliding"                      "Power Suit"                  
##  [95] "Mind Blast"                   "Probability Manipulation"    
##  [97] "Gravity Control"              "Regeneration"                
##  [99] "Light Control"                "Echolocation"                
## [101] "Levitation"                   "Toxin and Disease Control"   
## [103] "Banish"                       "Energy Manipulation"         
## [105] "Heat Resistance"              "Natural Weapons"             
## [107] "Time Travel"                  "Enhanced Smell"              
## [109] "Illusions"                    "Thirstokinesis"              
## [111] "Hair Manipulation"            "Illumination"                
## [113] "Omnipotent"                   "Cloaking"                    
## [115] "Changing Armor"               "Power Cosmic"                
## [117] "Biokinesis"                   "Water Control"               
## [119] "Radiation Immunity"           "Vision - Telescopic"         
## [121] "Toxin and Disease Resistance" "Spatial Awareness"           
## [123] "Energy Resistance"            "Telepathy Resistance"        
## [125] "Molecular Combustion"         "Omnilingualism"              
## [127] "Portal Creation"              "Magnetism"                   
## [129] "Mind Control Resistance"      "Plant Control"               
## [131] "Sonar"                        "Sonic Scream"                
## [133] "Time Manipulation"            "Enhanced Touch"              
## [135] "Magic Resistance"             "Invisibility"                
## [137] "Sub-Mariner"                  "Radiation Absorption"        
## [139] "Intuitive aptitude"           "Vision - Microscopic"        
## [141] "Melting"                      "Wind Control"                
## [143] "Super Breath"                 "Wallcrawling"                
## [145] "Vision - Night"               "Vision - Infrared"           
## [147] "Grim Reaping"                 "Matter Absorption"           
## [149] "The Force"                    "Resurrection"                
## [151] "Terrakinesis"                 "Vision - Heat"               
## [153] "Vitakinesis"                  "Radar Sense"                 
## [155] "Qwardian Power Ring"          "Weather Control"             
## [157] "Vision - X-Ray"               "Vision - Thermal"            
## [159] "Web Creation"                 "Reality Warping"             
## [161] "Odin Force"                   "Symbiote Costume"            
## [163] "Speed Force"                  "Phoenix Force"               
## [165] "Molecular Dissipation"        "Vision - Cryo"               
## [167] "Omnipresent"                  "Omniscient"
```


```r
superhero_info <- clean_names(superhero_info)
superhero_powers <- clean_names(superhero_powers)
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superhero_info, alignment)
```

```
##  alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

1. Who are the publishers of the superheros? Show the proportion of superheros from each publisher. Which publisher has the highest number of superheros?  

```r
tabyl(superhero_info, publisher)
```

```
##          publisher   n     percent valid_percent
##        ABC Studios   4 0.005449591   0.005563282
##          DC Comics 215 0.292915531   0.299026426
##  Dark Horse Comics  18 0.024523161   0.025034771
##       George Lucas  14 0.019073569   0.019471488
##      Hanna-Barbera   1 0.001362398   0.001390821
##      HarperCollins   6 0.008174387   0.008344924
##     IDW Publishing   4 0.005449591   0.005563282
##        Icon Comics   4 0.005449591   0.005563282
##       Image Comics  14 0.019073569   0.019471488
##      J. K. Rowling   1 0.001362398   0.001390821
##   J. R. R. Tolkien   1 0.001362398   0.001390821
##      Marvel Comics 388 0.528610354   0.539638387
##          Microsoft   1 0.001362398   0.001390821
##       NBC - Heroes  19 0.025885559   0.026425591
##          Rebellion   1 0.001362398   0.001390821
##           Shueisha   4 0.005449591   0.005563282
##      Sony Pictures   2 0.002724796   0.002781641
##         South Park   1 0.001362398   0.001390821
##          Star Trek   6 0.008174387   0.008344924
##               SyFy   5 0.006811989   0.006954103
##       Team Epic TV   5 0.006811989   0.006954103
##        Titan Books   1 0.001362398   0.001390821
##  Universal Studios   1 0.001362398   0.001390821
##          Wildstorm   3 0.004087193   0.004172462
##               <NA>  15 0.020435967            NA
```
The publishers and proportions are listed above, the highest proportion appears to come form Marvel with about 53.9% of the comics.

2. Notice that we have some neutral superheros! Who are they? List their names below.  

```r
filter(superhero_info, superhero_info$alignment=="neutral") %>% select(name)
```

```
## # A tibble: 24 × 1
##    name        
##    <chr>       
##  1 Bizarro     
##  2 Black Flash 
##  3 Captain Cold
##  4 Copycat     
##  5 Deadpool    
##  6 Deathstroke 
##  7 Etrigan     
##  8 Galactus    
##  9 Gladiator   
## 10 Indigo      
## # ℹ 14 more rows
```
## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
select(superhero_info, alignment, race)
```

```
## # A tibble: 734 × 2
##    alignment race             
##    <chr>     <chr>            
##  1 good      Human            
##  2 good      Icthyo Sapien    
##  3 good      Ungaran          
##  4 bad       Human / Radiation
##  5 bad       Cosmic Entity    
##  6 bad       Human            
##  7 good      <NA>             
##  8 good      Human            
##  9 good      <NA>             
## 10 good      Human            
## # ℹ 724 more rows
```
Isolate them using select().
## Not Human
4. List all of the superheros that are not human.

```r
filter(superhero_info, race!="Human") %>% select(name) #any superhero that isn't fully human
```

```
## # A tibble: 222 × 1
##    name        
##    <chr>       
##  1 Abe Sapien  
##  2 Abin Sur    
##  3 Abomination 
##  4 Abraxas     
##  5 Ajax        
##  6 Alien       
##  7 Amazo       
##  8 Angel       
##  9 Angel Dust  
## 10 Anti-Monitor
## # ℹ 212 more rows
```

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
good <- filter(superhero_info, alignment=="good")
good
```

```
## # A tibble: 496 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Adam… Male   blue      <NA>  Blond          NA NBC - He… <NA>       good     
##  5 Adam… Male   blue      Human Blond         185 DC Comics <NA>       good     
##  6 Agen… Female blue      <NA>  Blond         173 Marvel C… <NA>       good     
##  7 Agen… Male   brown     Human Brown         178 Marvel C… <NA>       good     
##  8 Agen… Male   <NA>      <NA>  <NA>          191 Marvel C… <NA>       good     
##  9 Alan… Male   blue      <NA>  Blond         180 DC Comics <NA>       good     
## 10 Alex… Male   <NA>      <NA>  <NA>           NA NBC - He… <NA>       good     
## # ℹ 486 more rows
## # ℹ 1 more variable: weight <dbl>
```


```r
bad <- filter(superhero_info, alignment=="bad")
bad
```

```
## # A tibble: 207 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  2 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  3 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  4 Air-… Male   blue      <NA>  White         188 Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alex… Male   <NA>      Human <NA>           NA Wildstorm <NA>       bad      
##  7 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  8 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  9 Ammo  Male   brown     Human Black         188 Marvel C… <NA>       bad      
## 10 Ange… Female <NA>      <NA>  <NA>           NA Image Co… <NA>       bad      
## # ℹ 197 more rows
## # ℹ 1 more variable: weight <dbl>
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
tabyl(good, race)
```

```
##               race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```

7. Among the good guys, Who are the Vampires?

```r
filter(good, race=="Vampire") %>% select(name)
```

```
## # A tibble: 2 × 1
##   name 
##   <chr>
## 1 Angel
## 2 Blade
```

```r
bad
```

```
## # A tibble: 207 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  2 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  3 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  4 Air-… Male   blue      <NA>  White         188 Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alex… Male   <NA>      Human <NA>           NA Wildstorm <NA>       bad      
##  7 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  8 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  9 Ammo  Male   brown     Human Black         188 Marvel C… <NA>       bad      
## 10 Ange… Female <NA>      <NA>  <NA>           NA Image Co… <NA>       bad      
## # ℹ 197 more rows
## # ℹ 1 more variable: weight <dbl>
```
The only good vampires are Angel and Blade.
8. Among the bad guys, who are the male humans over 200 inches in height?

```r
filter(bad, height>200 & race=="Human" & gender=="Male")
```

```
## # A tibble: 5 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Bane   Male   <NA>      Human <NA>          203 DC Comics <NA>       bad      
## 2 Docto… Male   brown     Human Brown         201 Marvel C… <NA>       bad      
## 3 Kingp… Male   blue      Human No Hair       201 Marvel C… <NA>       bad      
## 4 Lizard Male   red       Human No Hair       203 Marvel C… <NA>       bad      
## 5 Scorp… Male   brown     Human Brown         211 Marvel C… <NA>       bad      
## # ℹ 1 more variable: weight <dbl>
```

9. Are there more good guys or bad guys with green hair?

```r
table(good$hair_color=="Green")
```

```
## 
## FALSE  TRUE 
##   375     7
```

```r
table(bad$hair_color=="Green")
```

```
## 
## FALSE  TRUE 
##   153     1
```
More good guys have green hair than bad.

10. Let's explore who the really small superheros are. In the `superhero_info` data, which have a weight less than 50? Be sure to sort your results by weight lowest to highest.  

```r
small_supes <- filter(superhero_info, weight < 50) %>% arrange(weight)
small_supes
```

```
## # A tibble: 19 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Iron… Male   blue      <NA>  No Hair        NA Marvel C… <NA>       bad      
##  2 Groot Male   yellow    Flor… <NA>          701 Marvel C… <NA>       good     
##  3 Jack… Male   blue      Human Brown          71 Dark Hor… <NA>       good     
##  4 Gala… Male   black     Cosm… Black         876 Marvel C… <NA>       neutral  
##  5 Yoda  Male   brown     Yoda… White          66 George L… green      good     
##  6 Fin … Male   red       Kaka… No Hair       975 Marvel C… green      good     
##  7 Howa… Male   brown     <NA>  Yellow         79 Marvel C… <NA>       good     
##  8 Kryp… Male   blue      Kryp… White          64 DC Comics <NA>       good     
##  9 Rock… Male   brown     Anim… Brown         122 Marvel C… <NA>       good     
## 10 Dash  Male   blue      Human Blond         122 Dark Hor… <NA>       good     
## 11 Long… Male   blue      Human Blond         188 Marvel C… <NA>       good     
## 12 Robi… Male   blue      Human Black         137 DC Comics <NA>       good     
## 13 Wiz … <NA>   brown     <NA>  Black         140 Marvel C… <NA>       good     
## 14 Viol… Female violet    Human Black         137 Dark Hor… <NA>       good     
## 15 Fran… Male   blue      Muta… Blond         142 Marvel C… <NA>       good     
## 16 Swarm Male   yellow    Muta… No Hair       196 Marvel C… yellow     bad      
## 17 Hope… Female green     <NA>  Red           168 Marvel C… <NA>       good     
## 18 Jolt  Female blue      <NA>  Black         165 Marvel C… <NA>       good     
## 19 Snow… Female white     <NA>  Blond         178 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

```r
# arrange sorts by value desc does decreasing
```


11. Let's make a new variable that is the ratio of height to weight. Call this variable `height_weight_ratio`.    

```r
superhero_info %>% mutate(height_weight_ratio = height/weight) %>% select(name, height, weight, height_weight_ratio) %>% 
  arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 × 4
##    name            height weight height_weight_ratio
##    <chr>            <dbl>  <dbl>               <dbl>
##  1 Groot              701      4              175.  
##  2 Galactus           876     16               54.8 
##  3 Fin Fang Foom      975     18               54.2 
##  4 Longshot           188     36                5.22
##  5 Jack-Jack           71     14                5.07
##  6 Rocket Raccoon     122     25                4.88
##  7 Dash               122     27                4.52
##  8 Howard the Duck     79     18                4.39
##  9 Swarm              196     47                4.17
## 10 Yoda                66     17                3.88
## # ℹ 724 more rows
```

12. Who has the highest height to weight ratio?  
Groot has the highest height:weight ratio at a height of 701 and weight of 4.

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.

```r
glimpse(superhero_powers)
```

```
## Rows: 667
## Columns: 168
## $ hero_names                   <chr> "3-D Man", "A-Bomb", "Abe Sapien", "Abin …
## $ agility                      <lgl> TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, F…
## $ accelerated_healing          <lgl> FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, FA…
## $ lantern_power_ring           <lgl> FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, …
## $ dimensional_awareness        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ cold_resistance              <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ durability                   <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, T…
## $ stealth                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_absorption            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ flight                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ danger_sense                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ underwater_breathing         <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ marksmanship                 <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ weapons_master               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ power_augmentation           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animal_attributes            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ longevity                    <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, F…
## $ intelligence                 <lgl> FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, FA…
## $ super_strength               <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE…
## $ cryokinesis                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ telepathy                    <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ energy_armor                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_blasts                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ duplication                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ size_changing                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ density_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ stamina                      <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, FAL…
## $ astral_travel                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ audio_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ dexterity                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnitrix                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ super_speed                  <lgl> TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, FA…
## $ possession                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animal_oriented_powers       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ weapon_based_powers          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ electrokinesis               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ darkforce_manipulation       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ death_touch                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ teleportation                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ enhanced_senses              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ telekinesis                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_beams                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ magic                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ hyperkinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ jump                         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ clairvoyance                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ dimensional_travel           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ power_sense                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ shapeshifting                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ peak_human_condition         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ immortality                  <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, F…
## $ camouflage                   <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, …
## $ element_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ phasing                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ astral_projection            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ electrical_transport         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ fire_control                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ projection                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ summoning                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_memory              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ reflexes                     <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ invulnerability              <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, T…
## $ energy_constructs            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ force_fields                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ self_sustenance              <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, …
## $ anti_gravity                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ empathy                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_nullifier              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ radiation_control            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ psionic_powers               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ elasticity                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ substance_secretion          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ elemental_transmogrification <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ technopath_cyberpath         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ photographic_reflexes        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ seismic_power                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animation                    <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, …
## $ precognition                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ mind_control                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ fire_resistance              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_absorption             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_hearing             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ nova_force                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ insanity                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ hypnokinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animal_control               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ natural_armor                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ intangibility                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_sight               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ molecular_manipulation       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ heat_generation              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ adaptation                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ gliding                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_suit                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ mind_blast                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ probability_manipulation     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ gravity_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ regeneration                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ light_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ echolocation                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ levitation                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ toxin_and_disease_control    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ banish                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_manipulation          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ heat_resistance              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ natural_weapons              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ time_travel                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_smell               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ illusions                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ thirstokinesis               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ hair_manipulation            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ illumination                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnipotent                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ cloaking                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ changing_armor               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_cosmic                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ biokinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ water_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ radiation_immunity           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_telescopic            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ toxin_and_disease_resistance <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ spatial_awareness            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_resistance            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ telepathy_resistance         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ molecular_combustion         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnilingualism               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ portal_creation              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ magnetism                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ mind_control_resistance      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ plant_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ sonar                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ sonic_scream                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ time_manipulation            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_touch               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ magic_resistance             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ invisibility                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ sub_mariner                  <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ radiation_absorption         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ intuitive_aptitude           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_microscopic           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ melting                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ wind_control                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ super_breath                 <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, …
## $ wallcrawling                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_night                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_infrared              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ grim_reaping                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ matter_absorption            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ the_force                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ resurrection                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ terrakinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_heat                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vitakinesis                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ radar_sense                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ qwardian_power_ring          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ weather_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_x_ray                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_thermal               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ web_creation                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ reality_warping              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ odin_force                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ symbiote_costume             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ speed_force                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ phoenix_force                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ molecular_dissipation        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_cryo                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnipresent                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omniscient                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
```


13. How many superheros have a combination of agility, stealth, super_strength, stamina?

```r
superhero_powers %>% filter(agility==TRUE, stealth==TRUE, super_strength==TRUE, stamina==TRUE) %>%  count
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1    40
```
40 have a combination of all traits. 
## Your Favorite
14. Pick your favorite superhero and let's see their powers!  


```r
fav <- filter(superhero_info, superhero_info$name=="Dr Manhattan")

attributes <- filter(superhero_powers, hero_names=="Dr Manhattan") %>%  apply(1, function(data) names(which(data == T))) # had to look this up
attributes
```

```
##       [,1]                    
##  [1,] "accelerated_healing"   
##  [2,] "durability"            
##  [3,] "energy_absorption"     
##  [4,] "flight"                
##  [5,] "longevity"             
##  [6,] "intelligence"          
##  [7,] "super_strength"        
##  [8,] "energy_blasts"         
##  [9,] "duplication"           
## [10,] "size_changing"         
## [11,] "density_control"       
## [12,] "super_speed"           
## [13,] "teleportation"         
## [14,] "telekinesis"           
## [15,] "immortality"           
## [16,] "phasing"               
## [17,] "invulnerability"       
## [18,] "energy_constructs"     
## [19,] "force_fields"          
## [20,] "self_sustenance"       
## [21,] "precognition"          
## [22,] "intangibility"         
## [23,] "molecular_manipulation"
## [24,] "energy_manipulation"   
## [25,] "time_travel"           
## [26,] "omnilingualism"        
## [27,] "time_manipulation"     
## [28,] "matter_absorption"     
## [29,] "molecular_dissipation"
```


```r
?filter
```

```
## Help on topic 'filter' was found in the following packages:
## 
##   Package               Library
##   dplyr                 /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/library
##   stats                 /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/library
## 
## 
## Using the first match ...
```

15. Can you find your hero in the superhero_info data? Show their info!  



```r
fav
```

```
## # A tibble: 1 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Dr Ma… Male   white     Huma… No Hair        NA DC Comics blue       good     
## # ℹ 1 more variable: weight <dbl>
```
Dr Manhattan is a Human/Cosmic character with no hair and blue skin from DC Comics.
## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  

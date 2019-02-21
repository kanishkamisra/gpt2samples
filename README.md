
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gpt2samples

The goal of gpt2samples is to
…

## Installation

<!-- You can install the released version of gpt2samples from [CRAN](https://CRAN.R-project.org) with:-->

You can install the released version of gpt2samples from GitHub with:

``` r
# install.packages("gpt2samples")
# install.packages("devtools")
devtools::install_github("kanishkamisra/gpt2samples")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:lubridate':
#> 
#>     intersect, setdiff, union
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(gpt2samples)

conditional %>%
  filter(id == 100)
#> # A tibble: 2 x 4
#>   file         id text                                             type    
#>   <chr>     <int> <chr>                                            <chr>   
#> 1 conditio…   100 "\n the waterbody that you are managing, gettin… sample  
#> 2 conditio…   100 "\n Permit, WDFW ensures that nonconventional c… complet…
```

## Contributor Code of Conduct

Please note that the ‘gpt2samples’ project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to
this project, you agree to abide by its terms.

# Ship observation records data dictionary

Column names, class labels, and descriptions for each variable in
[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md).

## Usage

``` r
ships_dictionary
```

## Format

A tibble with 21 rows and 3 variables:

- column_name:

  (`character`) Name of the column in
  [ships](https://jonthegeek.github.io/seabirddata/reference/ships.md).

- class:

  (`character`) Class label for the column, following `vctrs` type
  conventions.

- description:

  (`character`) Human-readable description of the column's contents.

## See also

[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md),
the dataset this dictionary describes. The script used to prepare this
dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/dictionaries.R>

## Examples

``` r
ships_dictionary
#> # A tibble: 21 × 3
#>    column_name class   description                                              
#>    <chr>       <chr>   <chr>                                                    
#>  1 record_id   integer "Record identifier. Links to `birds$record_id`."         
#>  2 date        date    "Observation date."                                      
#>  3 time        time    "Local time at the start of the 10-minute count."        
#>  4 latitude    double  "Decimal latitude (negative values indicate southern hem…
#>  5 longitude   double  "Decimal longitude."                                     
#>  6 hemisphere  factor  "East/West hemisphere: `\"E\"` or `\"W\"`."              
#>  7 activity    factor  "Ship activity during the count period. One of `\"steami…
#>  8 speed       double  "Ship speed in knots."                                   
#>  9 direction   integer "Ship direction in degrees."                             
#> 10 cloud_cover ordered "Cloud cover: `\"clear\"`, `\"partially cloudy\"`, or `\…
#> # ℹ 11 more rows
```

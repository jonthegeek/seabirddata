# Beaufort scale data dictionary

Column names, class labels, and descriptions for each variable in
[beaufort_scale](https://jonthegeek.github.io/seabirddata/reference/beaufort_scale.md).

## Usage

``` r
beaufort_scale_dictionary
```

## Format

A tibble with 4 rows and 3 variables:

- column_name:

  (`character`) Name of the column in
  [beaufort_scale](https://jonthegeek.github.io/seabirddata/reference/beaufort_scale.md).

- class:

  (`character`) Class label for the column, following `vctrs` type
  conventions.

- description:

  (`character`) Human-readable description of the column's contents.

## See also

[beaufort_scale](https://jonthegeek.github.io/seabirddata/reference/beaufort_scale.md),
the dataset this dictionary describes. The script used to prepare this
dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/dictionaries.R>

## Examples

``` r
beaufort_scale_dictionary
#> # A tibble: 4 × 3
#>   column_name          class   description                                      
#>   <chr>                <chr>   <chr>                                            
#> 1 wind_speed_class     integer "Beaufort scale class (0--12), corresponding to …
#> 2 wind_description     ordered "Text description of the wind conditions, ordere…
#> 3 wind_speed_knots_min integer "Minimum wind speed in knots for this class."    
#> 4 wind_speed_knots_max integer "Maximum wind speed in knots for this class. `NA…
```

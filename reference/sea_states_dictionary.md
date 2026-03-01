# Sea states data dictionary

Column names, class labels, and descriptions for each variable in
[sea_states](https://jonthegeek.github.io/seabirddata/reference/sea_states.md).

## Usage

``` r
sea_states_dictionary
```

## Format

A tibble with 4 rows and 3 variables:

- column_name:

  (`character`) Name of the column in
  [sea_states](https://jonthegeek.github.io/seabirddata/reference/sea_states.md).

- class:

  (`character`) Class label for the column, following `vctrs` type
  conventions.

- description:

  (`character`) Human-readable description of the column's contents.

## See also

[sea_states](https://jonthegeek.github.io/seabirddata/reference/sea_states.md),
the dataset this dictionary describes. The script used to prepare this
dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/dictionaries.R>

## Examples

``` r
sea_states_dictionary
#> # A tibble: 4 × 3
#>   column_name           class   description                                     
#>   <chr>                 <chr>   <chr>                                           
#> 1 sea_state_class       integer "Sea state class (0--6), corresponding to `ship…
#> 2 sea_state_description ordered "Text description of the sea state, ordered fro…
#> 3 wave_meters_min       double  "Minimum wave height in meters for this class." 
#> 4 wave_meters_max       double  "Maximum wave height in meters for this class." 
```

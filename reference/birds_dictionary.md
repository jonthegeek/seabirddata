# Bird observation records data dictionary

Column names, class labels, and descriptions for each variable in
[birds](https://jonthegeek.github.io/seabirddata/reference/birds.md).

## Usage

``` r
birds_dictionary
```

## Format

A tibble with 26 rows and 3 variables:

- column_name:

  (`character`) Name of the column in
  [birds](https://jonthegeek.github.io/seabirddata/reference/birds.md).

- class:

  (`character`) Class label for the column, following `vctrs` type
  conventions.

- description:

  (`character`) Human-readable description of the column's contents.

## See also

[birds](https://jonthegeek.github.io/seabirddata/reference/birds.md),
the dataset this dictionary describes. The script used to prepare this
dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/dictionaries.R>

## Examples

``` r
birds_dictionary
#> # A tibble: 26 × 3
#>    column_name             class     description                                
#>    <chr>                   <chr>     <chr>                                      
#>  1 bird_observation_id     integer   "Identifier for this bird observation reco…
#>  2 record_id               integer   "Record identifier. Links to `ships$record…
#>  3 species_common_name     character "The original log entry as recorded in the…
#>  4 species_scientific_name character "Scientific name, derived from `species_co…
#>  5 species_abbreviation    character "Abbreviated species name (mostly the firs…
#>  6 age                     ordered   "Age class, derived from `species_common_n…
#>  7 wan_plumage_phase       ordered   "Wandering albatross plumage phase, derive…
#>  8 plumage_phase           ordered   "Plumage phase for species other than wand…
#>  9 sex                     factor    "Sex, derived from `species_common_name`. …
#> 10 count                   integer   "Total number of birds counted in this obs…
#> # ℹ 16 more rows
```

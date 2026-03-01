# Beaufort wind scale lookup table

Descriptions and wind speed ranges in knots for each class of the
Beaufort wind force scale, as used in
[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md).
This table was constructed from the data dictionary accompanying the
source dataset.

## Usage

``` r
beaufort_scale
```

## Format

A tibble with 13 rows and 4 variables:

- wind_speed_class:

  (`integer`) Beaufort scale class (0–12), corresponding to
  `ships$wind_speed_class`.

- wind_description:

  (`ordered`) Text description of the wind conditions, ordered from
  `"calm"` (class 0) to `"hurricane"` (class 12).

- wind_speed_knots_min:

  (`integer`) Minimum wind speed in knots for this class.

- wind_speed_knots_max:

  (`integer`) Maximum wind speed in knots for this class. `NA` for class
  12 (hurricane), which has no upper bound.

## Source

At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The Museum
of New Zealand.
<https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>

## See also

[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md),
where `wind_speed_class` references this table. The script used to
prepare this dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/ships.R>

## Examples

``` r
beaufort_scale
#> # A tibble: 13 × 4
#>    wind_speed_class wind_description wind_speed_knots_min wind_speed_knots_max
#>               <int> <ord>                           <int>                <int>
#>  1                0 calm                                0                    1
#>  2                1 light air                           1                    3
#>  3                2 light breeze                        4                    6
#>  4                3 gentle breeze                       7                   10
#>  5                4 moderate breeze                    11                   16
#>  6                5 fresh breeze                       17                   21
#>  7                6 strong breeze                      22                   27
#>  8                7 near gale                          28                   33
#>  9                8 gale                               34                   40
#> 10                9 strong gale                        41                   47
#> 11               10 storm                              48                   55
#> 12               11 violent storm                      56                   63
#> 13               12 hurricane                          64                   NA

# Join to ships for human-readable wind descriptions
if (requireNamespace("dplyr", quietly = TRUE)) {
  dplyr::left_join(ships, beaufort_scale, by = "wind_speed_class")
}
#> # A tibble: 12,310 × 24
#>    record_id date       time       latitude longitude hemisphere activity  speed
#>        <int> <date>     <hms>         <dbl>     <dbl> <fct>      <fct>     <dbl>
#>  1   1083001 1975-10-15 50400 secs    -45.9      165. E          steaming…  15  
#>  2   1084001 1975-11-03 47400 secs    -35.5      125  E          steaming…  14  
#>  3   1084002 1975-11-04 51600 secs    -37.7      132. E          steaming…  14.5
#>  4   1084003 1975-11-08 58500 secs    -40        162  E          steaming…  14.6
#>  5   1086001 1975-11-16 45000 secs    -36.2      175. E          steaming…  15  
#>  6   1086002 1975-11-16 55800 secs    -35.4      175. E          steaming…  15  
#>  7   1086003 1975-11-17 52200 secs    -35.2      168  E          steaming…  15  
#>  8   1086004 1975-11-17 59400 secs    -35.3      167. E          steaming…  15  
#>  9   1086005 1975-11-18 52200 secs    -36.5      161  E          steaming…  15  
#> 10   1086006 1975-11-18 59400 secs    -36.3      160. E          steaming…  15  
#> # ℹ 12,300 more rows
#> # ℹ 16 more variables: direction <int>, cloud_cover <ord>, precipitation <fct>,
#> #   wind_speed_class <int>, wind_direction <int>, air_temperature <dbl>,
#> #   pressure <int>, sea_state_class <int>, sea_surface_temperature <dbl>,
#> #   depth <int>, observer <fct>, census_method <ord>, season <ord>,
#> #   wind_description <ord>, wind_speed_knots_min <int>,
#> #   wind_speed_knots_max <int>
```

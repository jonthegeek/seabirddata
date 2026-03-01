# Sea state lookup table

Descriptions and wave height ranges for each sea state class used in
[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md).
This table was constructed from the data dictionary accompanying the
source dataset.

## Usage

``` r
sea_states
```

## Format

A tibble with 7 rows and 4 variables:

- sea_state_class:

  (`integer`) Sea state class (0–6), corresponding to
  `ships$sea_state_class`.

- sea_state_description:

  (`ordered`) Text description of the sea state, ordered from
  `"calm, glassy"` (class 0) to `"very rough"` (class 6).

- wave_meters_min:

  (`double`) Minimum wave height in meters for this class.

- wave_meters_max:

  (`double`) Maximum wave height in meters for this class.

## Source

At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The Museum
of New Zealand.
<https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>

## See also

[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md),
where `sea_state_class` references this table. The script used to
prepare this dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/ships.R>

## Examples

``` r
sea_states
#> # A tibble: 7 × 4
#>   sea_state_class sea_state_description wave_meters_min wave_meters_max
#>             <int> <ord>                           <dbl>           <dbl>
#> 1               0 calm, glassy                      0               0  
#> 2               1 calm, rippled                     0               0.1
#> 3               2 smooth                            0.1             0.5
#> 4               3 slight                            0.5             1.2
#> 5               4 moderate                          1.3             2.5
#> 6               5 rough                             2.5             4  
#> 7               6 very rough                        4               6  

# Join to ships for human-readable sea state descriptions
if (requireNamespace("dplyr", quietly = TRUE)) {
  dplyr::left_join(ships, sea_states, by = "sea_state_class")
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
#> #   sea_state_description <ord>, wave_meters_min <dbl>, wave_meters_max <dbl>
```

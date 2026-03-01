# Ship observation records

Environmental and operational records for each 10-minute seabird census
period, covering at-sea observations from 1969 to 1990. Each row
represents one census period and links to zero or more bird observation
records in
[birds](https://jonthegeek.github.io/seabirddata/reference/birds.md) via
`record_id`.

## Usage

``` r
ships
```

## Format

A tibble with 12310 rows and 21 variables:

- record_id:

  (`integer`) Record identifier. Links to `birds$record_id`.

- date:

  (`date`) Observation date.

- time:

  (`time`) Local time at the start of the 10-minute count.

- latitude:

  (`double`) Decimal latitude (negative values indicate southern
  hemisphere).

- longitude:

  (`double`) Decimal longitude.

- hemisphere:

  (`factor`) East/West hemisphere: `"E"` or `"W"`.

- activity:

  (`factor`) Ship activity during the count period. One of
  `"steaming, sailing"`, `"dropping trash"`, `"trawling"`,
  `"oceanography"`, `"potting"`, `"line fishing"`, `"cleaning fish"`,
  `"stationary"`, `"flying helicopters"`, or `"whaling"`. Recoded from
  numeric codes 1–10 in the source data.

- speed:

  (`double`) Ship speed in knots.

- direction:

  (`integer`) Ship direction in degrees.

- cloud_cover:

  (`ordered`) Cloud cover: `"clear"`, `"partially cloudy"`, or
  `"overcast"`. Recoded from codes 0–2 in the source data.

- precipitation:

  (`factor`) Precipitation type: `"none"`, `"squalls"`, `"fog"`,
  `"drizzle"`, `"rain"`, `"showers"`, `"snow showers"`, or
  `"continuous snow"`. Recoded from numeric codes in the source data.

- wind_speed_class:

  (`integer`) Wind speed on the Beaufort scale (0–12). Join to
  [beaufort_scale](https://jonthegeek.github.io/seabirddata/reference/beaufort_scale.md)
  for descriptions and knot ranges.

- wind_direction:

  (`integer`) Wind direction in degrees.

- air_temperature:

  (`double`) Air temperature in degrees Celsius.

- pressure:

  (`integer`) Atmospheric sea-level pressure in millibars.

- sea_state_class:

  (`integer`) Sea state class (0–6). Join to
  [sea_states](https://jonthegeek.github.io/seabirddata/reference/sea_states.md)
  for descriptions and wave height ranges.

- sea_surface_temperature:

  (`double`) Sea surface temperature in degrees Celsius.

- depth:

  (`integer`) Sea floor depth in meters.

- observer:

  (`factor`) Name of the observer, decoded from a 4-letter code in the
  source data.

- census_method:

  (`ordered`) Count method: `"partial"` indicates a count lasting less
  than 10 minutes or a casual observation; `"full"` indicates a complete
  10-minute count. Recoded from `"P"` and `"F"` in the source data.

- season:

  (`ordered`) Southern hemisphere season: `"summer"`, `"autumn"`,
  `"winter"`, or `"spring"`. Recorded directly in the source data (but
  likely derived rather than being entered directly in the log book
  data).

## Source

At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The Museum
of New Zealand.
<https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>

## Details

Several columns derived in the source data have been excluded: the
original row order (implicit in the data), month (derivable from
`date`), longitude in 0–360-degree format (derivable from `longitude`
and `hemisphere`), 1-degree grid cell centre coordinates (derivable from
`latitude` and `longitude`), and sea surface salinity (missing for all
but one entry).

## See also

[birds](https://jonthegeek.github.io/seabirddata/reference/birds.md) for
the corresponding bird observation records.
[sea_states](https://jonthegeek.github.io/seabirddata/reference/sea_states.md)
and
[beaufort_scale](https://jonthegeek.github.io/seabirddata/reference/beaufort_scale.md)
for lookup tables describing the `sea_state_class` and
`wind_speed_class` codes. The script used to prepare this dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/ships.R>

## Examples

``` r
ships
#> # A tibble: 12,310 × 21
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
#> # ℹ 13 more variables: direction <int>, cloud_cover <ord>, precipitation <fct>,
#> #   wind_speed_class <int>, wind_direction <int>, air_temperature <dbl>,
#> #   pressure <int>, sea_state_class <int>, sea_surface_temperature <dbl>,
#> #   depth <int>, observer <fct>, census_method <ord>, season <ord>

# Join ship records with bird observations
if (requireNamespace("dplyr", quietly = TRUE)) {
  dplyr::left_join(ships, birds, by = "record_id")
}
#> # A tibble: 49,019 × 46
#>    record_id date       time       latitude longitude hemisphere activity  speed
#>        <int> <date>     <hms>         <dbl>     <dbl> <fct>      <fct>     <dbl>
#>  1   1083001 1975-10-15 50400 secs    -45.9      165. E          steaming…  15  
#>  2   1083001 1975-10-15 50400 secs    -45.9      165. E          steaming…  15  
#>  3   1083001 1975-10-15 50400 secs    -45.9      165. E          steaming…  15  
#>  4   1083001 1975-10-15 50400 secs    -45.9      165. E          steaming…  15  
#>  5   1083001 1975-10-15 50400 secs    -45.9      165. E          steaming…  15  
#>  6   1084001 1975-11-03 47400 secs    -35.5      125  E          steaming…  14  
#>  7   1084001 1975-11-03 47400 secs    -35.5      125  E          steaming…  14  
#>  8   1084001 1975-11-03 47400 secs    -35.5      125  E          steaming…  14  
#>  9   1084002 1975-11-04 51600 secs    -37.7      132. E          steaming…  14.5
#> 10   1084002 1975-11-04 51600 secs    -37.7      132. E          steaming…  14.5
#> # ℹ 49,009 more rows
#> # ℹ 38 more variables: direction <int>, cloud_cover <ord>, precipitation <fct>,
#> #   wind_speed_class <int>, wind_direction <int>, air_temperature <dbl>,
#> #   pressure <int>, sea_state_class <int>, sea_surface_temperature <dbl>,
#> #   depth <int>, observer <fct>, census_method <ord>, season <ord>,
#> #   bird_observation_id <int>, species_common_name <chr>,
#> #   species_scientific_name <chr>, species_abbreviation <chr>, age <ord>, …
```

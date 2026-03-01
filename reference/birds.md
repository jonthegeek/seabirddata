# Bird observation records

Individual seabird observation records for each 10-minute census period,
covering at-sea observations from 1969 to 1990. Each row represents one
species entry within a census period and links to the corresponding
environmental and ship data in
[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md) via
`record_id`.

## Usage

``` r
birds
```

## Format

A tibble with 49019 rows and 26 variables:

- bird_observation_id:

  (`integer`) Identifier for this bird observation record, corresponding
  to the original record order in the source data.

- record_id:

  (`integer`) Record identifier. Links to `ships$record_id`. One
  observation (record_id 1184009, bird_observation_id 974) has no
  corresponding ship record in the source data.

- species_common_name:

  (`character`) The original log entry as recorded in the source data.
  May encode species, age, sex, and plumage phase in a single string.
  `NA` indicates a census period with no birds recorded (converted from
  the sentinel value `"[NO BIRDS RECORDED]"` in the source data).

- species_scientific_name:

  (`character`) Scientific name, derived from `species_common_name` by
  Te Papa staff. May represent a species aggregate if the log entry
  could not be identified to a single species.

- species_abbreviation:

  (`character`) Abbreviated species name (mostly the first three letters
  of the genus and species), derived from `species_common_name` by Te
  Papa staff.

- age:

  (`ordered`) Age class, derived from `species_common_name`. One of
  `"juvenile"`, `"immature"`, `"subadult"`, or `"adult"`.

- wan_plumage_phase:

  (`ordered`) Wandering albatross plumage phase, derived from
  `species_common_name`. One of `"all brown"`,
  `"brown plumage breaking"`, `"white patch on wing"`,
  `"wing patch breaking"`, or `"white"`.

- plumage_phase:

  (`ordered`) Plumage phase for species other than wandering albatross,
  derived from `species_common_name`. One of `"dark"`, `"intermediate"`,
  `"light"`, or `"white"`.

- sex:

  (`factor`) Sex, derived from `species_common_name`. One of `"female"`
  or `"male"`.

- count:

  (`integer`) Total number of birds counted in this observation. `99999`
  is used for counts estimated to be over 100,000.

- n_feeding:

  (`integer`) Number of birds observed feeding (unspecified whether
  actively or passively). `99999` is used for counts estimated to be
  over 100,000.

- feeding:

  (`logical`) Whether any birds were observed feeding.

- n_sitting_on_water:

  (`integer`) Number of birds sitting on water.

- sitting_on_water:

  (`logical`) Whether any birds were sitting on water.

- n_sitting_on_ice:

  (`integer`) Number of birds sitting on ice.

- sitting_on_ice:

  (`logical`) Whether any birds were sitting on ice.

- sitting_on_ship:

  (`logical`) Whether any birds were sitting on the ship.

- in_hand:

  (`logical`) Whether any birds were held in hand (i.e., captured).

- n_flying_past:

  (`integer`) Number of birds flying past. `99999` is used for counts
  estimated to be over 100,000.

- flying_past:

  (`logical`) Whether any birds were flying past.

- n_accompanying:

  (`integer`) Number of birds accompanying the ship (flying alongside).

- accompanying:

  (`logical`) Whether any birds were accompanying the ship.

- n_following_ship:

  (`integer`) Number of birds following the ship's wake.

- following_ship:

  (`logical`) Whether any birds were following the ship's wake.

- moulting:

  (`logical`) Whether any birds were observed moulting.

- naturally_feeding:

  (`logical`) Whether any birds were naturally feeding (i.e., not
  feeding on ship discards).

## Source

At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The Museum
of New Zealand.
<https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>

## Details

The data was built from records extracted by Te Papa staff from the
at-sea bird observation logbooks of Captain John Arthur Francis Jenkins
(1928–1989) and count cards held by the convenor of the Australasian
Seabird Mapping Scheme. The logbooks of Captain Jenkins are held by the
Archives of the Auckland War Memorial Museum.

`species_common_name` contains the original log entry as it appeared in
the source data. The raw column was named "Species common name (taxon
\[AGE / SEX / PLUMAGE PHASE\])", reflecting that a single entry could
encode species, age, sex, and plumage information together. The columns
`species_scientific_name`, `species_abbreviation`, `age`,
`wan_plumage_phase`, `plumage_phase`, and `sex` were all derived from
this log entry by Te Papa staff.

For the occurrence columns (`feeding`, `sitting_on_water`, etc.), `NA`
indicates the occurrence was unknown or unrecorded (original value `"U"`
in the source data).

## See also

[ships](https://jonthegeek.github.io/seabirddata/reference/ships.md) for
the corresponding ship and environmental records. The script used to
prepare this dataset:
<https://github.com/jonthegeek/seabirddata/blob/main/data-raw/birds.R>

## Examples

``` r
birds
#> # A tibble: 49,019 × 26
#>    bird_observation_id record_id species_common_name      species_scientific_n…¹
#>                  <int>     <int> <chr>                    <chr>                 
#>  1                   1   1083001 Royal / Wandering albat… Diomedea epomophora /…
#>  2                   2   1083001 Black-browed albatross … Diomedea impavida / m…
#>  3                   3   1083001 Cape petrel              Daption capense       
#>  4                   4   1083001 Fairy prion              Pachyptila turtur     
#>  5                   5   1083001 Sooty shearwater         Puffinus griseus      
#>  6                   6   1084001 Royal albatross sensu l… Diomedea epomophora /…
#>  7                   7   1084001 Black-browed albatross … Diomedea impavida / m…
#>  8                   8   1084001 Sooty shearwater         Puffinus griseus      
#>  9                   9   1084002 Royal albatross sensu l… Diomedea epomophora /…
#> 10                  10   1084002 Black-browed albatross … Diomedea impavida / m…
#> # ℹ 49,009 more rows
#> # ℹ abbreviated name: ¹​species_scientific_name
#> # ℹ 22 more variables: species_abbreviation <chr>, age <ord>,
#> #   wan_plumage_phase <ord>, plumage_phase <ord>, sex <fct>, count <int>,
#> #   n_feeding <int>, feeding <lgl>, n_sitting_on_water <int>,
#> #   sitting_on_water <lgl>, n_sitting_on_ice <int>, sitting_on_ice <lgl>,
#> #   sitting_on_ship <lgl>, in_hand <lgl>, n_flying_past <int>, …

# Join with ship records for environmental context
if (requireNamespace("dplyr", quietly = TRUE)) {
  dplyr::left_join(birds, ships, by = "record_id")
}
#> # A tibble: 49,019 × 46
#>    bird_observation_id record_id species_common_name      species_scientific_n…¹
#>                  <int>     <int> <chr>                    <chr>                 
#>  1                   1   1083001 Royal / Wandering albat… Diomedea epomophora /…
#>  2                   2   1083001 Black-browed albatross … Diomedea impavida / m…
#>  3                   3   1083001 Cape petrel              Daption capense       
#>  4                   4   1083001 Fairy prion              Pachyptila turtur     
#>  5                   5   1083001 Sooty shearwater         Puffinus griseus      
#>  6                   6   1084001 Royal albatross sensu l… Diomedea epomophora /…
#>  7                   7   1084001 Black-browed albatross … Diomedea impavida / m…
#>  8                   8   1084001 Sooty shearwater         Puffinus griseus      
#>  9                   9   1084002 Royal albatross sensu l… Diomedea epomophora /…
#> 10                  10   1084002 Black-browed albatross … Diomedea impavida / m…
#> # ℹ 49,009 more rows
#> # ℹ abbreviated name: ¹​species_scientific_name
#> # ℹ 42 more variables: species_abbreviation <chr>, age <ord>,
#> #   wan_plumage_phase <ord>, plumage_phase <ord>, sex <fct>, count <int>,
#> #   n_feeding <int>, feeding <lgl>, n_sitting_on_water <int>,
#> #   sitting_on_water <lgl>, n_sitting_on_ice <int>, sitting_on_ice <lgl>,
#> #   sitting_on_ship <lgl>, in_hand <lgl>, n_flying_past <int>, …
```

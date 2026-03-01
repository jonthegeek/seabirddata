library(tidyverse)
library(janitor)
ship_url <- "https://www.tepapa.govt.nz/assets/76067/1692923095-at-sea_seabird_observation_data_ship_data_by_record_id_1.csv"

ships_raw <- readr::read_csv(ship_url)
readr::problems(ships_raw)
# The issue is the one entry in the SAL column. Not worth fixing, since almost
# no rows have it.

# readr::read_csv(ship_url, col_types = readr::cols(.default = "c"))

ships <- ships_raw |>
  janitor::clean_names() |>
  dplyr::select(
    # Remove pointless or empty columns, and rename columns to more descriptive
    # names using the data dictionary from
    # https://www.tepapa.govt.nz/assets/76067/1692923086-asms_10min_seabird_counts_final.xls
    "record_id",
    "date",
    "time",
    "latitude" = "lat",
    "longitude" = "long",
    "hemisphere" = "ew",
    "activity" = "sact",
    "speed",
    "direction" = "sdir",
    "cloud_cover" = "cld",
    "precipitation" = "prec",
    "wind_speed_class" = "wspeed",
    "wind_direction" = "wdir",
    "air_temperature" = "atmp",
    "pressure" = "aprs",
    "sea_state_class" = "sste",
    "sea_surface_temperature" = "stmp",
    "depth",
    "observer" = "obs",
    "census_method" = "csmeth",
    "season" = "seasn"
  ) |>
  dplyr::mutate(
    dplyr::across(
      c(
        "record_id",
        "direction",
        "wind_speed_class",
        "wind_direction",
        "pressure",
        "sea_state_class",
        "depth"
      ),
      as.integer
    ),
    date = lubridate::dmy(date),
    activity = dplyr::recode_values(
      .data$activity,
      1 ~ "steaming, sailing",
      2 ~ "dropping trash",
      3 ~ "trawling",
      4 ~ "oceanography",
      5 ~ "potting",
      6 ~ "line fishing",
      7 ~ "cleaning fish",
      8 ~ "stationary",
      9 ~ "flying helicopters",
      10 ~ "whaling",
      default = NA
    ),
    cloud_cover = dplyr::recode_values(
      .data$cloud_cover,
      0 ~ "clear",
      1 ~ "partially cloudy",
      2 ~ "overcast",
      default = NA
    ),
    precipitation = dplyr::recode_values(
      .data$precipitation,
      0 ~ "none",
      2 ~ "squalls",
      4 ~ "fog",
      5 ~ "drizzle",
      6 ~ "rain",
      8 ~ "showers",
      10 ~ "snow showers",
      11 ~ "continuous snow",
      default = NA
    ),
    observer = dplyr::recode_values(
      .data$observer,
      "BAIN" ~ "A. Baines",
      "BARK" ~ "R. Barker",
      "BIRD" ~ "A.I. Bird",
      "CART" ~ "M.J. Carter",
      "CHES" ~ "N. Cheshire",
      "CLAR" ~ "G.S. Clark",
      "CLEA" ~ "J.D. Cleaver",
      "COLE" ~ "L.R. Cole",
      "COPS" ~ "G.R. Copson",
      "COWA" ~ "A. Cowan",
      "EADE" ~ "D. Eades",
      "GREE" ~ "E.N. Greenwood",
      "HAND" ~ "R.M. Hand",
      "IMBE" ~ "M.J. Imber",
      "JEFF" ~ "D. Jeffcock",
      "JENK" ~ "J. Jenkins",
      "JOHN" ~ "G.W. Johnstone",
      "KERR" ~ "N.R. Kerry",
      "LEWI" ~ "P.P.R. Lewis",
      "MCQU" ~ "P. McQuillan",
      "MILF" ~ "R. Milford",
      "MILL" ~ "D. Milledge",
      "NESF" ~ "P.T. Nesfield",
      "PARK" ~ "L.F. Parkes",
      "SEPP" ~ "R.D. Seppelt",
      "SMIT" ~ "D.G.D. Smith",
      "THOM" ~ "K.J. Thomas",
      default = NA
    ),
    census_method = dplyr::recode_values(
      .data$census_method,
      "F" ~ "full",
      "P" ~ "partial",
      default = NA
    ),
    dplyr::across(
      c("hemisphere", "activity", "precipitation", "observer"),
      as.factor
    ),
    cloud_cover = factor(
      .data$cloud_cover,
      levels = c("clear", "partially cloudy", "overcast"),
      ordered = TRUE
    ),
    census_method = factor(
      .data$census_method,
      levels = c("partial", "full"),
      ordered = TRUE
    ),
    season = factor(
      .data$season,
      levels = c("summer", "autumn", "winter", "spring"),
      ordered = TRUE
    )
  )

sea_states <- tibble::tibble(
  sea_state_class = 0:6,
  sea_state_description = c(
    "calm, glassy",
    "calm, rippled",
    "smooth",
    "slight",
    "moderate",
    "rough",
    "very rough"
  ),
  wave_meters_min = c(0, 0, 0.1, 0.5, 1.3, 2.5, 4),
  wave_meters_max = c(0, 0.1, 0.5, 1.2, 2.5, 4, 6)
) |>
  dplyr::mutate(
    sea_state_description = factor(
      sea_state_description,
      levels = sea_state_description,
      ordered = TRUE
    )
  )

beaufort_scale <- tibble::tibble(
  wind_speed_class = 0:12,
  wind_description = c(
    "calm",
    "light air",
    "light breeze",
    "gentle breeze",
    "moderate breeze",
    "fresh breeze",
    "strong breeze",
    "near gale",
    "gale",
    "strong gale",
    "storm",
    "violent storm",
    "hurricane"
  ),
  wind_speed_knots_min = as.integer(c(
    0,
    1,
    4,
    7,
    11,
    17,
    22,
    28,
    34,
    41,
    48,
    56,
    64
  )),
  wind_speed_knots_max = as.integer(c(
    1,
    3,
    6,
    10,
    16,
    21,
    27,
    33,
    40,
    47,
    55,
    63,
    NA
  ))
) |>
  dplyr::mutate(
    wind_description = factor(
      wind_description,
      levels = wind_description,
      ordered = TRUE
    )
  )

usethis::use_data(
  sea_states,
  beaufort_scale,
  overwrite = TRUE,
  compress = "gzip"
)
usethis::use_data(ships, overwrite = TRUE, compress = "xz")

# tools::resaveRdaFiles("data/")
# tools::checkRdaFiles("data/")

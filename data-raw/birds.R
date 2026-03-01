library(tidyverse)
library(janitor)
bird_url <- "https://www.tepapa.govt.nz/assets/76067/1692923111-at-sea_seabird_observation_data_bird_data_by_record_id.csv"

birds_raw <- readr::read_csv(bird_url, col_types = readr::cols(.default = "c"))

birds <- birds_raw |>
  janitor::clean_names() |>
  dplyr::select(
    "bird_observation_id" = "record",
    "record_id",
    "species_common_name" = "species_common_name_taxon_age_sex_plumage_phase",
    "species_scientific_name" = "species_scientific_name_taxon_age_sex_plumage_phase",
    "species_abbreviation",
    "age",
    "wan_plumage_phase" = "wanplum",
    "plumage_phase" = "plphase",
    "sex",
    "count",
    "n_feeding" = "nfeed",
    "feeding" = "ocfeed",
    "n_sitting_on_water" = "nsow",
    "sitting_on_water" = "ocsow",
    "n_sitting_on_ice" = "nsoice",
    "sitting_on_ice" = "ocsoice",
    "sitting_on_ship" = "ocsoshp",
    "in_hand" = "ocinhd",
    "n_flying_past" = "nflyp",
    "flying_past" = "ocflyp",
    "n_accompanying" = "nacc",
    "accompanying" = "ocacc",
    "n_following_ship" = "nfoll",
    "following_ship" = "ocfol",
    "moulting" = "ocmoult",
    "naturally_feeding" = "ocnatfed"
  ) |>
  dplyr::mutate(
    dplyr::across(
      c(
        "bird_observation_id",
        "record_id",
        "count",
        "n_feeding",
        "n_sitting_on_water",
        "n_sitting_on_ice",
        "n_flying_past",
        "n_accompanying",
        "n_following_ship"
      ),
      as.integer
    ),
    # [NO BIRDS RECORDED] is the source data's sentinel for a census period
    # with no observations in species_common_name
    species_common_name = dplyr::na_if(
      .data$species_common_name,
      "[NO BIRDS RECORDED]"
    ),
    age = dplyr::recode_values(
      .data$age,
      "AD" ~ "adult",
      "SUBAD" ~ "subadult",
      "IMM" ~ "immature",
      "JUV" ~ "juvenile",
      default = NA
    ),
    wan_plumage_phase = dplyr::recode_values(
      .data$wan_plumage_phase,
      "1" ~ "all brown",
      "2" ~ "brown plumage breaking",
      "3" ~ "white patch on wing",
      "4" ~ "wing patch breaking",
      "5" ~ "white",
      default = NA
    ),
    plumage_phase = dplyr::recode_values(
      .data$plumage_phase,
      "DRK" ~ "dark",
      "INT" ~ "intermediate",
      "LGHT" ~ "light",
      "WHITE" ~ "white",
      default = NA
    ),
    sex = dplyr::recode_values(
      .data$sex,
      "F" ~ "female",
      "M" ~ "male",
      default = NA
    ),
    sex = as.factor(.data$sex),
    age = factor(
      .data$age,
      levels = c("juvenile", "immature", "subadult", "adult"),
      ordered = TRUE
    ),
    wan_plumage_phase = factor(
      .data$wan_plumage_phase,
      levels = c(
        "all brown",
        "brown plumage breaking",
        "white patch on wing",
        "wing patch breaking",
        "white"
      ),
      ordered = TRUE
    ),
    plumage_phase = factor(
      .data$plumage_phase,
      levels = c("dark", "intermediate", "light", "white"),
      ordered = TRUE
    ),
    dplyr::across(
      c(
        "feeding",
        "sitting_on_water",
        "sitting_on_ice",
        "sitting_on_ship",
        "in_hand",
        "flying_past",
        "accompanying",
        "following_ship",
        "moulting",
        "naturally_feeding"
      ),
      \(x) dplyr::recode_values(x, "Y" ~ TRUE, "N" ~ FALSE, default = NA)
    )
  )

usethis::use_data(birds, overwrite = TRUE, compress = "xz")

# tools::resaveRdaFiles("data/")
# tools::checkRdaFiles("data/")

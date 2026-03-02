#' Sea state lookup table
#'
#' Descriptions and wave height ranges for each sea state class used in [ships].
#' This table was constructed from the data dictionary accompanying the source
#' dataset.
#'
#' @eval datawrap::describe_dataset(sea_states, sea_states_dictionary)
#'
#' @seealso [ships], where `sea_state_class` references this table. The script
#'   used to prepare this dataset:
#'   <https://github.com/jonthegeek/seabirddata/blob/main/data-raw/ships.R>
#'
#' @source At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The
#'   Museum of New Zealand.
#'   <https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>
#'
#' @examples
#' sea_states
#'
#' # Join to ships for human-readable sea state descriptions
#' if (requireNamespace("dplyr", quietly = TRUE)) {
#'   dplyr::left_join(ships, sea_states, by = "sea_state_class")
#' }
"sea_states"

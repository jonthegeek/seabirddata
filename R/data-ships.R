#' Ship observation records
#'
#' Environmental and operational records for each 10-minute seabird census
#' period, covering at-sea observations from 1969 to 1990. Each row represents
#' one census period and links to zero or more bird observation records in
#' [birds] via `record_id`.
#'
#' Several columns derived in the source data have been excluded: the original
#' row order (implicit in the data), month (derivable from `date`), longitude in
#' 0--360-degree format (derivable from `longitude` and `hemisphere`), 1-degree
#' grid cell centre coordinates (derivable from `latitude` and `longitude`), and
#' sea surface salinity (missing for all but one entry).
#'
#' @eval datawrap::describe_dataset(ships, ships_dictionary)
#'
#' @seealso [birds] for the corresponding bird observation records. [sea_states]
#'   and [beaufort_scale] for lookup tables describing the `sea_state_class` and
#'   `wind_speed_class` codes. The script used to prepare this dataset:
#'   <https://github.com/jonthegeek/seabirddata/blob/main/data-raw/ships.R>
#'
#' @source At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The
#'   Museum of New Zealand.
#'   <https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>
#'
#' @examples
#' ships
#'
#' # Join ship records with bird observations
#' if (requireNamespace("dplyr", quietly = TRUE)) {
#'   dplyr::left_join(ships, birds, by = "record_id")
#' }
"ships"

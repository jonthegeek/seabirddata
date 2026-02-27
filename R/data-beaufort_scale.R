#' Beaufort wind scale lookup table
#'
#' Descriptions and wind speed ranges in knots for each class of the Beaufort
#' wind force scale, as used in [ships]. This table was constructed from the
#' data dictionary accompanying the source dataset.
#'
#' @eval .describe_dataset(beaufort_scale, beaufort_scale_dictionary)
#'
#' @seealso [ships], where `wind_speed_class` references this table. The script
#'   used to prepare this dataset:
#'   <https://github.com/jonthegeek/seabirddata/blob/main/data-raw/ships.R>
#'
#' @source At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The
#'   Museum of New Zealand.
#'   <https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>
#'
#' @examples
#' beaufort_scale
#'
#' # Join to ships for human-readable wind descriptions
#' if (requireNamespace("dplyr", quietly = TRUE)) {
#'   dplyr::left_join(ships, beaufort_scale, by = "wind_speed_class")
#' }
"beaufort_scale"

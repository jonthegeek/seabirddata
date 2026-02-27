#' Bird observation records
#'
#' Individual seabird observation records for each 10-minute census period,
#' covering at-sea observations from 1969 to 1990. Each row represents one
#' species entry within a census period and links to the corresponding
#' environmental and ship data in [ships] via `record_id`.
#'
#' The data was built from records extracted by Te Papa staff from the at-sea
#' bird observation logbooks of Captain John Arthur Francis Jenkins (1928--1989)
#' and count cards held by the convenor of the Australasian Seabird Mapping
#' Scheme. The logbooks of Captain Jenkins are held by the Archives of the
#' Auckland War Memorial Museum.
#'
#' `species_common_name` contains the original log entry as it appeared in the
#' source data. The raw column was named "Species common name (taxon \[AGE / SEX
#' / PLUMAGE PHASE\])", reflecting that a single entry could encode species,
#' age, sex, and plumage information together. The columns
#' `species_scientific_name`, `species_abbreviation`, `age`,
#' `wan_plumage_phase`, `plumage_phase`, and `sex` were all derived from this
#' log entry by Te Papa staff.
#'
#' For the occurrence columns (`feeding`, `sitting_on_water`, etc.), `NA`
#' indicates the occurrence was unknown or unrecorded (original value `"U"` in
#' the source data).
#'
#' @eval .describe_dataset(birds, birds_dictionary)
#'
#' @seealso [ships] for the corresponding ship and environmental records. The
#'   script used to prepare this dataset:
#'   <https://github.com/jonthegeek/seabirddata/blob/main/data-raw/birds.R>
#'
#' @source At-Sea Observations of Seabirds dataset, Te Papa Tongarewa, The
#'   Museum of New Zealand.
#'   <https://www.tepapa.govt.nz/learn/research/datasets/sea-observations-seabirds-dataset>
#'
#' @examples
#' birds
#'
#' # Join with ship records for environmental context
#' if (requireNamespace("dplyr", quietly = TRUE)) {
#'   dplyr::left_join(birds, ships, by = "record_id")
#' }
"birds"

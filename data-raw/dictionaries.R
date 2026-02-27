# Download and parse the data dictionary from the Te Papa XLS file.
# The XLS is ~20MB and not saved in the package; this script is here so the
# dictionaries can be easily recreated for reference when writing documentation
# or understanding the raw data fields.
#
# Sheet 3: Ship data codes -> ship_dictionary_raw
# Sheet 4: Bird data codes -> bird_dictionary_raw

xls_url <- "https://www.tepapa.govt.nz/assets/76067/1692923086-asms_10min_seabird_counts_final.xls"
xls_path <- file.path(tempdir(), "seabird_dictionary.xls")
on.exit(unlink(xls_path), add = TRUE)
download.file(xls_url, xls_path, mode = "wb")

ship_dictionary_raw <- readxl::read_xls(xls_path, sheet = 3)
bird_dictionary_raw <- readxl::read_xls(xls_path, sheet = 4)

pkgload::load_all()

# Run once to generate initial dictionary MD files. Edit descriptions in those
# files; do not re-run unless column classes have changed.
# .write_dataset_dictionary(beaufort_scale)
# .write_dataset_dictionary(sea_states)
# .write_dataset_dictionary(ships)
# .write_dataset_dictionary(birds)

beaufort_scale_dictionary <- readMDTable::read_md_table(
  "data-raw/beaufort_scale_dictionary.md",
  show_col_types = FALSE
)
sea_states_dictionary <- readMDTable::read_md_table(
  "data-raw/sea_states_dictionary.md",
  show_col_types = FALSE
)
ships_dictionary <- readMDTable::read_md_table(
  "data-raw/ships_dictionary.md",
  show_col_types = FALSE
)
birds_dictionary <- readMDTable::read_md_table(
  "data-raw/birds_dictionary.md",
  show_col_types = FALSE
)

usethis::use_data(
  beaufort_scale_dictionary,
  sea_states_dictionary,
  ships_dictionary,
  birds_dictionary,
  overwrite = TRUE,
  compress = "bzip2"
)

# tools::resaveRdaFiles("data/")
# tools::checkRdaFiles("data/")

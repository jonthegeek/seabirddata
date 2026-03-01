#' Describe the class of an object for a data dictionary
#'
#' Determine a human-readable class label for an object.
#'
#' @param x (`any`) The object to describe.
#'
#' @returns (`character(1)`) A descriptive class label for the object.
#' @keywords internal
.class_friendly <- function(x) {
  rlang::check_installed("vctrs", "to describe column classes.")
  result <- sub("<[^>]*>", "", vctrs::vec_ptype_full(x))
  # vctrs returns "hms" or "time" for hms/difftime columns depending on whether
  # the hms package is loaded; normalise to "time" for consistency.
  if (result == "hms") "time" else result
}

#' Convert a string to a full sentence
#'
#' Converts a string to sentence case and appends a trailing period.
#' Underscores are replaced with spaces before conversion, making it suitable
#' for generating readable labels from programmatic names.
#'
#' @inheritParams stringr::str_to_sentence
#'
#' @returns (`character`) The input string(s) converted to sentence case, with
#'   underscores replaced by spaces and a trailing period appended.
#' @keywords internal
.str_to_sentence_full <- function(string, locale = "en") {
  rlang::check_installed("stringr", "to convert strings to sentence case.")
  string |>
    stringr::str_replace_all("_", " ") |>
    stringr::str_remove("\\.$") |>
    stringr::str_to_sentence(locale = locale) |>
    paste0(".")
}

#' Create a data dictionary tibble for a dataset
#'
#' Builds a tibble with one row per column in `dataset`, containing the column
#' name, class label, and a placeholder description.
#'
#' @param dataset (`data.frame`) The dataset to describe.
#'
#' @returns (`tibble`) A tibble with columns `column_name`, `class`, and
#'   `description`.
#' @keywords internal
.create_dataset_dictionary <- function(dataset) {
  rlang::check_installed(
    c("purrr", "tibble"),
    "to create a data dictionary."
  )
  tibble::tibble(
    column_name = names(dataset),
    class = purrr::map_chr(dataset, .class_friendly),
    description = purrr::map_chr(colnames(dataset), .str_to_sentence_full)
  )
}

#' Generate a `@format` roxygen2 block for a dataset
#'
#' Builds a complete `@format` block describing a dataset's columns, suitable
#' for use with `@eval` in roxygen2 documentation. The header line reflects the
#' actual dimensions of `dataset`; each column gets one `\item` entry combining
#' the class label and description from `dictionary`.
#'
#' @param dataset (`data.frame`) The dataset to document.
#' @param dictionary (`data.frame`) A dictionary tibble with columns
#'   `column_name`, `class`, and `description`, one row per column of
#'   `dataset`. Defaults to a placeholder dictionary generated from `dataset`.
#'
#' @returns (`character`) A character vector of roxygen2 lines forming a
#'   `@format` block, suitable for returning from `@eval`.
#' @keywords internal
.describe_dataset <- function(
  dataset,
  dictionary = .create_dataset_dictionary(dataset)
) {
  header <- sprintf(
    "@format A tibble with %d rows and %d variables:",
    nrow(dataset),
    ncol(dataset)
  )
  items <- sprintf(
    "  \\item{%s}{(`%s`) %s}",
    dictionary$column_name,
    dictionary$class,
    dictionary$description
  )
  c(header, "\\describe{", items, "}")
}

#' Write an initial data dictionary markdown file for a dataset
#'
#' Creates a markdown data dictionary file for a dataset with one row per
#' column, pre-filled with placeholder descriptions. The file is intended to be
#' edited by hand, then committed as the source of truth for the dictionary.
#'
#' @param dataset (`data.frame`) The dataset to document.
#' @param path (`character(1)`) Directory in which to write the markdown file.
#'   Defaults to `"data-raw"`.
#' @param dataset_name (`character(1)`) Base name of the dataset, used to
#'   construct the output filename (`{dataset_name}_dictionary.md`). Defaults to
#'   the name of the object passed as `dataset`.
#' @param open (`logical(1)`) Whether to open the file for editing after
#'   writing. Defaults to `TRUE` in interactive sessions.
#'
#' @returns (`character(1)`) The path to the written file, invisibly.
#' @keywords internal
.write_dataset_dictionary <- function(
  dataset,
  path = "data-raw",
  dataset_name = rlang::caller_arg(dataset),
  open = rlang::is_interactive()
) {
  rlang::check_installed("knitr", "to create a data dictionary.")
  dict <- .create_dataset_dictionary(dataset)
  file_path <- file.path(path, paste0(dataset_name, "_dictionary.md"))
  .write_file_lines(knitr::kable(dict), file_path, open = open)
}

#' Write lines to a file and optionally open it for editing
#'
#' Writes a character vector to a file and optionally opens it for editing.
#'
#' @param lines (`character`) The lines to write.
#' @param file_path (`character(1)`) Path to the output file.
#' @param open (`logical(1)`) Whether to open the file for editing after
#'   writing. Defaults to `TRUE` in interactive sessions.
#'
#' @returns (`character(1)`) The path to the written file, invisibly.
#' @keywords internal
.write_file_lines <- function(
  lines,
  file_path,
  open = rlang::is_interactive()
) {
  writeLines(lines, file_path)
  if (open) {
    if (rlang::is_installed("usethis")) {
      usethis::edit_file(file_path)
    } else {
      utils::file.edit(file_path)
    }
  }
  invisible(file_path)
}

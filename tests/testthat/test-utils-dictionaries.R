# .class_friendly() ----------------------------------------------------------

test_that(".class_friendly returns a single character string", {
  expect_type(.class_friendly(1L), "character")
  expect_length(.class_friendly(1L), 1L)
})

test_that(".class_friendly returns 'factor' for unordered factors", {
  expect_equal(.class_friendly(factor(letters)), "factor")
})

test_that(".class_friendly returns 'ordered' for ordered factors", {
  expect_equal(.class_friendly(factor(letters, ordered = TRUE)), "ordered")
})

test_that(".class_friendly normalises 'hms' to 'time'", {
  # vctrs returns "hms" when the hms package is loaded; we normalise to "time"
  # so the label is consistent regardless of the environment.
  local_mocked_bindings(
    vec_ptype_full = function(...) "hms",
    .package = "vctrs"
  )
  expect_equal(.class_friendly(1L), "time")
})

test_that(".class_friendly strips angle-bracket suffix regardless of levels", {
  # Two factors with different level sets produce different hashes but the
  # same label.
  expect_equal(
    .class_friendly(factor(letters)),
    .class_friendly(factor(LETTERS))
  )
})

# .str_to_sentence_full() -----------------------------------------------------

test_that(".str_to_sentence_full capitalises the first letter", {
  expect_equal(.str_to_sentence_full("hello world"), "Hello world.")
})

test_that(".str_to_sentence_full replaces underscores with spaces", {
  expect_equal(.str_to_sentence_full("wind_speed_class"), "Wind speed class.")
})

test_that(".str_to_sentence_full does not double-add a trailing period", {
  expect_equal(.str_to_sentence_full("hello world."), "Hello world.")
})

test_that(".str_to_sentence_full is vectorised", {
  expect_equal(
    .str_to_sentence_full(c("foo_bar", "baz.")),
    c("Foo bar.", "Baz.")
  )
})

# .describe_dataset() ---------------------------------------------------------

test_that(".describe_dataset returns a character vector", {
  df <- data.frame(x = 1L, y = "a")
  dict <- data.frame(
    column_name = c("x", "y"),
    class = c("integer", "character"),
    description = c("An integer.", "A string.")
  )
  result <- .describe_dataset(df, dict)
  expect_type(result, "character")
})

test_that(".describe_dataset header reflects actual dataset dimensions", {
  df <- data.frame(x = 1L, y = 2L, z = 3L)
  dict <- data.frame(
    column_name = c("x", "y", "z"),
    class = c("integer", "integer", "integer"),
    description = c("X.", "Y.", "Z.")
  )
  result <- .describe_dataset(df, dict)
  expect_match(result[[1]], "@format A tibble with 1 rows and 3 variables:")
})

test_that(".describe_dataset produces one \\item per dictionary row", {
  df <- data.frame(x = 1L, y = "a")
  dict <- data.frame(
    column_name = c("x", "y"),
    class = c("integer", "character"),
    description = c("An integer.", "A string.")
  )
  result <- .describe_dataset(df, dict)
  items <- grep("\\\\item", result, value = TRUE)
  expect_length(items, nrow(dict))
})

test_that(".describe_dataset formats \\item entries correctly", {
  df <- data.frame(x = 1L)
  dict <- data.frame(
    column_name = "x",
    class = "integer",
    description = "An integer column."
  )
  result <- .describe_dataset(df, dict)
  expect_match(
    result,
    "\\\\item\\{x\\}\\{\\(`integer`\\) An integer column\\.\\}",
    all = FALSE
  )
})

test_that(".describe_dataset wraps items in \\describe{}", {
  df <- data.frame(x = 1L)
  dict <- data.frame(
    column_name = "x",
    class = "integer",
    description = "An integer."
  )
  result <- .describe_dataset(df, dict)
  expect_equal(result[[2]], "\\describe{")
  expect_equal(result[[length(result)]], "}")
})

# .write_file_lines() ---------------------------------------------------------

test_that(".write_file_lines writes content to the file", {
  tmp <- withr::local_tempfile(fileext = ".txt")
  .write_file_lines(c("line 1", "line 2"), tmp, open = FALSE)
  expect_equal(readLines(tmp), c("line 1", "line 2"))
})

test_that(".write_file_lines returns the file path invisibly", {
  tmp <- withr::local_tempfile(fileext = ".txt")
  result <- withVisible(.write_file_lines("x", tmp, open = FALSE))
  expect_equal(result$value, tmp)
  expect_false(result$visible)
})

test_that(".write_file_lines opens with usethis when open = TRUE and usethis is available", {
  tmp <- withr::local_tempfile(fileext = ".txt")
  local_mocked_bindings(
    edit_file = function(...) {
      message("opened")
      invisible(NULL)
    },
    .package = "usethis"
  )
  expect_message(.write_file_lines("x", tmp, open = TRUE), "opened")
})

test_that(".write_file_lines falls back to file.edit when usethis is unavailable", {
  tmp <- withr::local_tempfile(fileext = ".txt")
  local_mocked_bindings(is_installed = function(...) FALSE, .package = "rlang")
  local_mocked_bindings(
    file.edit = function(...) {
      message("opened")
      invisible(NULL)
    },
    .package = "utils"
  )
  expect_message(.write_file_lines("x", tmp, open = TRUE), "opened")
})

# .write_dataset_dictionary() -------------------------------------------------

test_that(".write_dataset_dictionary creates a file at the expected path", {
  tmp_dir <- withr::local_tempdir()
  df <- data.frame(x = 1L)
  .write_dataset_dictionary(
    df,
    path = tmp_dir,
    dataset_name = "my_df",
    open = FALSE
  )
  expect_true(file.exists(file.path(tmp_dir, "my_df_dictionary.md")))
})

test_that(".write_dataset_dictionary infers dataset_name from the call", {
  tmp_dir <- withr::local_tempdir()
  my_special_df <- data.frame(x = 1L)
  .write_dataset_dictionary(my_special_df, path = tmp_dir, open = FALSE)
  expect_true(file.exists(file.path(tmp_dir, "my_special_df_dictionary.md")))
})

test_that(".write_dataset_dictionary returns the file path invisibly", {
  tmp_dir <- withr::local_tempdir()
  df <- data.frame(x = 1L)
  result <- withVisible(
    .write_dataset_dictionary(
      df,
      path = tmp_dir,
      dataset_name = "df",
      open = FALSE
    )
  )
  expect_equal(result$value, file.path(tmp_dir, "df_dictionary.md"))
  expect_false(result$visible)
})

test_that(".write_dataset_dictionary produces one row per column", {
  tmp_dir <- withr::local_tempdir()
  df <- data.frame(x = 1L, y = "a", z = TRUE)
  .write_dataset_dictionary(
    df,
    path = tmp_dir,
    dataset_name = "df",
    open = FALSE
  )
  lines <- readLines(file.path(tmp_dir, "df_dictionary.md"))
  # kable output: header + separator + one row per column
  expect_length(lines, ncol(df) + 2L)
})

test_that(".write_dataset_dictionary includes column names in the output", {
  tmp_dir <- withr::local_tempdir()
  df <- data.frame(wind_speed = 1.0, air_temp = 1.0)
  .write_dataset_dictionary(
    df,
    path = tmp_dir,
    dataset_name = "df",
    open = FALSE
  )
  content <- paste(
    readLines(file.path(tmp_dir, "df_dictionary.md")),
    collapse = "\n"
  )
  expect_match(content, "wind_speed")
  expect_match(content, "air_temp")
})

test_that(".write_dataset_dictionary uses .class_friendly for the class column", {
  tmp_dir <- withr::local_tempdir()
  df <- data.frame(x = 1L, y = factor("a"))
  .write_dataset_dictionary(
    df,
    path = tmp_dir,
    dataset_name = "df",
    open = FALSE
  )
  content <- paste(
    readLines(file.path(tmp_dir, "df_dictionary.md")),
    collapse = "\n"
  )
  expect_match(content, "integer")
  expect_match(content, "factor")
})

test_that(".write_dataset_dictionary uses .str_to_sentence_full for descriptions", {
  tmp_dir <- withr::local_tempdir()
  df <- data.frame(wind_speed = 1.0)
  .write_dataset_dictionary(
    df,
    path = tmp_dir,
    dataset_name = "df",
    open = FALSE
  )
  content <- paste(
    readLines(file.path(tmp_dir, "df_dictionary.md")),
    collapse = "\n"
  )
  expect_match(content, "Wind speed\\.")
})

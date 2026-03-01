# Checks that every column_name in a dictionary exists in the dataset, and
# that the actual class of each column matches the dictionary's class value.
check_dictionary_integrity <- function(dataset, dictionary) {
  for (i in seq_len(nrow(dictionary))) {
    col <- dictionary$column_name[[i]]
    expected_class <- dictionary$class[[i]]
    expect_true(
      col %in% names(dataset),
      label = paste0("column '", col, "' exists in dataset")
    )
    if (col %in% names(dataset)) {
      actual_class <- .class_friendly(dataset[[col]])
      expect_equal(
        actual_class,
        expected_class,
        label = paste0("class of '", col, "'")
      )
    }
  }
}

# beaufort_scale --------------------------------------------------------------

test_that("beaufort_scale columns match beaufort_scale_dictionary", {
  skip_if_not_installed("datawrap")
  check_dictionary_integrity(beaufort_scale, beaufort_scale_dictionary)
})

test_that("beaufort_scale has the expected number of columns", {
  expect_equal(ncol(beaufort_scale), nrow(beaufort_scale_dictionary))
})

# sea_states ------------------------------------------------------------------

test_that("sea_states columns match sea_states_dictionary", {
  skip_if_not_installed("datawrap")
  check_dictionary_integrity(sea_states, sea_states_dictionary)
})

test_that("sea_states has the expected number of columns", {
  expect_equal(ncol(sea_states), nrow(sea_states_dictionary))
})

# ships -----------------------------------------------------------------------

test_that("ships columns match ships_dictionary", {
  skip_if_not_installed("datawrap")
  check_dictionary_integrity(ships, ships_dictionary)
})

test_that("ships has the expected number of columns", {
  expect_equal(ncol(ships), nrow(ships_dictionary))
})

# birds -----------------------------------------------------------------------

test_that("birds columns match birds_dictionary", {
  skip_if_not_installed("datawrap")
  check_dictionary_integrity(birds, birds_dictionary)
})

test_that("birds has the expected number of columns", {
  expect_equal(ncol(birds), nrow(birds_dictionary))
})

# Referential integrity -------------------------------------------------------

test_that("birds$record_id matches ships$record_id except for one known orphan", {
  # record_id 1184009 (bird_observation_id 974) has no corresponding ship
  # record in the source data; this is a known data quality issue.
  orphaned <- birds$record_id[!birds$record_id %in% ships$record_id]
  expect_equal(sort(orphaned), 1184009L)
})

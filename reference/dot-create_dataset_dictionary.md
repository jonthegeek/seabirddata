# Create a data dictionary tibble for a dataset

Builds a tibble with one row per column in `dataset`, containing the
column name, class label, and a placeholder description.

## Usage

``` r
.create_dataset_dictionary(dataset)
```

## Arguments

- dataset:

  (`data.frame`) The dataset to describe.

## Value

(`tibble`) A tibble with columns `column_name`, `class`, and
`description`.

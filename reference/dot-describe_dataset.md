# Generate a `@format` roxygen2 block for a dataset

Builds a complete `@format` block describing a dataset's columns,
suitable for use with `@eval` in roxygen2 documentation. The header line
reflects the actual dimensions of `dataset`; each column gets one
`\item` entry combining the class label and description from
`dictionary`.

## Usage

``` r
.describe_dataset(dataset, dictionary = .create_dataset_dictionary(dataset))
```

## Arguments

- dataset:

  (`data.frame`) The dataset to document.

- dictionary:

  (`data.frame`) A dictionary tibble with columns `column_name`,
  `class`, and `description`, one row per column of `dataset`. Defaults
  to a placeholder dictionary generated from `dataset`.

## Value

(`character`) A character vector of roxygen2 lines forming a `@format`
block, suitable for returning from `@eval`.

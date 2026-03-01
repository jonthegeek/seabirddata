# Write an initial data dictionary markdown file for a dataset

Creates a markdown data dictionary file for a dataset with one row per
column, pre-filled with placeholder descriptions. The file is intended
to be edited by hand, then committed as the source of truth for the
dictionary.

## Usage

``` r
.write_dataset_dictionary(
  dataset,
  path = "data-raw",
  dataset_name = rlang::caller_arg(dataset),
  open = rlang::is_interactive()
)
```

## Arguments

- dataset:

  (`data.frame`) The dataset to document.

- path:

  (`character(1)`) Directory in which to write the markdown file.
  Defaults to `"data-raw"`.

- dataset_name:

  (`character(1)`) Base name of the dataset, used to construct the
  output filename (`{dataset_name}_dictionary.md`). Defaults to the name
  of the object passed as `dataset`.

- open:

  (`logical(1)`) Whether to open the file for editing after writing.
  Defaults to `TRUE` in interactive sessions.

## Value

(`character(1)`) The path to the written file, invisibly.

# Convert a string to a full sentence

Converts a string to sentence case and appends a trailing period.
Underscores are replaced with spaces before conversion, making it
suitable for generating readable labels from programmatic names.

## Usage

``` r
.str_to_sentence_full(string, locale = "en")
```

## Arguments

- string:

  Input vector. Either a character vector, or something coercible to
  one.

- locale:

  Locale to use for comparisons. See
  [`stringi::stri_locale_list()`](https://rdrr.io/pkg/stringi/man/stri_locale_list.html)
  for all possible options. Defaults to "en" (English) to ensure that
  default behaviour is consistent across platforms.

## Value

(`character`) The input string(s) converted to sentence case, with
underscores replaced by spaces and a trailing period appended.

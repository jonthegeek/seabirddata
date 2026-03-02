# AGENTS.md

## Skills

Skills in @.github/skills should be loaded when the user triggers them.

| Triggers              | Path                                           |
------------------------|------------------------------------------------|
| search / rewrite code | @.github/skills/search-code/SKILL.md           |
| create github issues  | @.github/skills/create-issue/SKILL.md          |

## GitHub

Use the `gh` CLI to interact with GitHub rather than fetching web URLs. Common examples:

```bash
# View an issue
gh issue view 123

# List open issues
gh issue list

# View a pull request
gh pr view 456

# List open PRs
gh pr list
```

### Commit message style

Use conventional commits with backtick-quoted function names. Close issues in the body with `- Closes #N`. Example:

```
feat: add `describe_dataset()`

Generates a `@format` roxygen2 block for a dataset, suitable for use
with `@eval` in package dataset documentation.

- Closes #3
```

## Testing

- Before starting any coding task, run all tests so you know the baseline state.
- Always run `air format .` before running tests, after every R file edit.
- This package is data-only. The only tests are in `tests/testthat/test-data-integrity.R`.
- Helper function(s) are in `tests/testthat/helper-data-integrity.R`.
- Use `devtools::test(reporter = "check")` to run all tests
- All testing functions automatically load code; you don't need to.
- All new code/data should have an accompanying test.
- If there are existing tests, place new tests next to similar existing tests.

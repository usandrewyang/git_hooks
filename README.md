Example .pre-commit-config.yaml
It needs to be included in the project direcotry.

```
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
    -   id: end-of-file-fixer
    -   id: trailing-whitespace
-   repo: https://github.com/usandrewyang/git_hooks
    rev: v1.0.8
    hooks:
    -   id: remove-cpp-comments

```

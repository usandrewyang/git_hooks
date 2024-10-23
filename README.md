## Install pre-commit
```
pip install pre-commit
```

$ pre-commit --version
pre-commit 4.0.1

## Add a pre-commit config
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
    rev: v1.0.12
    hooks:
    -   id: remove-cpp-comments
    -   id: check-release-files
```

## Install the git hook scripts
Run pre-commit install inside the project directory

```
pre-commit install
```
## Hooks
id: remove-cpp-comments Remove c++ style (//) single line comments

id: check-release-files Check the update files exist in FILES.esw or FILES.ltsw



# Conventional Commits

https://www.conventionalcommits.org/en/v1.0.0/

Format: `<type>(<scope>): <subject>`

`<scope>` is optional

Example:

```
feat: add hat wobble
^--^  ^------------^
|     |
|     +-> Summary in present tense.
|
+-------> Type: chore, docs, feat, fix, refactor, style, or test.
```
- `feat`: (new feature for the user, not a new feature for build script)
- `fix`: (bug fix for the user, not a fix to a build script)
- `docs`: (changes to the documentation)
- `style`: (formatting, missing semi colons, etc; no production code change)
- `refactor`: (refactoring production code, eg. renaming a variable)
- `test`: (adding missing tests, refactoring tests; no production code change)
- `chore`: (updating grunt tasks etc; no production code change)

[semantic commit messages](https://seesparkbox.com/foundry/semantic_commit_messages)

## Use with Commitizen and Commitlint

[commitizen](https://commitizen-tools.github.io/commitizen/)
> is a release management tool designed for teams.
>
> By default, commitizen uses
> [conventional commits](https://www.conventionalcommits.org/), but you can
> build your own set of rules, and publish them.

Use commitizen with [pre-commit-hook](pre-commit-hook.html).

[commitlint](https://github.com/conventional-changelog/commitlint)
> checks if your commit messages meet the
> [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) format.

```sh
brew upgrade npm
```

# terragrunt


To check if your code is compatible with 1.0, enable [strict mode](https://terragrunt.gruntwork.io/docs/reference/strict-mode/):

```sh
terragrunt run --all --strict-mode plan
```

Alternatively, set `TG_STRICT_MODE` to `true`:

```sh
TG_STRICT_MODE='true' terragrunt run --all plan
```

If your terragrunt ≥ 0.77.22, AND the strict mode is enabled, you will not need to change your usage of terragrunt by the time 1.0 is released.

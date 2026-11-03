## Development setup

Install `nixfmt` and `pre-commit` (both available through Nixpkgs).

Enable the Git hooks after cloning:

```bash
pre-commit install
```

Nix files are automatically checked for formatting before every commit.

To format files manually:

```bash
nixfmt flake.nix
```

To check the entire repository:

```bash
pre-commit run --all-files
```

All contributions must pass the formatting checks before merging.

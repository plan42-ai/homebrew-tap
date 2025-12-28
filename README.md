# homebrew-plan42
Plan42 Homebrew TAP

## Usage

Tap the repository and install the latest Plan42 CLI release:

```sh
brew tap plan42-ai/plan42
brew install plan42-cli
```

Specific versions are available through versioned formulas, for example:

```sh
brew install plan42-cli@1.0.4
```

## Adding a new version

Use the helper script to generate a new versioned formula (the default formula is updated to the same version):

```sh
./add_package_version.sh plan42-cli 1.0.5
```

By default the script downloads the macOS arm64 and x86_64 release tarballs to calculate checksums. If you need to skip downloads, set `SKIP_CHECKSUM=1` when running the script.
If the downloads fail, the formulas are still generated with `sha256 :no_check` so they can be published and updated later.

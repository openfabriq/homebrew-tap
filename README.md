# openfabriq Homebrew tap

The [Homebrew](https://brew.sh) formula for openfabriq, the engine that runs a software factory described in your repository.

```bash
brew install openfabriq/tap/openfabriq
```

It brings Node and `gh`. openfabriq also needs Claude Code, which you install and log in to yourself:

```bash
brew install --cask claude-code
claude auth login && gh auth login
```

The formula arrives here with the first release on npm. Until then, see the engine's repository to install from the sources.

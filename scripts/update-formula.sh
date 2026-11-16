#!/usr/bin/env bash
# Points Formula/openfabriq.rb at npm's latest openfabriq, only when it is a newer release (X.Y.Z).
set -euo pipefail

formula="${1:-Formula/openfabriq.rb}"
latest="$(npm view openfabriq dist-tags.latest)"
current="$(sed -nE 's#^  url ".*/openfabriq-([^"]+)\.tgz"#\1#p' "$formula")"

# npm briefly shows a placeholder while it processes a publish: only a plain release counts.
if ! [[ "$latest" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	echo "npm's latest is $latest, not a release: nothing to do"
	exit 0
fi
newest="$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -n 1)"
if [ "$latest" = "$current" ] || [ "$newest" != "$latest" ]; then
	echo "The formula has $current, npm's latest is $latest: nothing to do"
	exit 0
fi

url="https://registry.npmjs.org/openfabriq/-/openfabriq-$latest.tgz"
sha="$(curl -fsSL "$url" | shasum -a 256 | cut -d' ' -f1)"
perl -pi -e "s#^  url \".*\"#  url \"$url\"#; s#^  sha256 \".*\"#  sha256 \"$sha\"#" "$formula"
echo "The formula now installs openfabriq $latest ($sha)"

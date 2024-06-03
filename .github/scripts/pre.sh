#!/bin/sh
# Pre project generation script

# Stop Xcode if it's running
pkill Xcode

# Run linters and formatters
if [[ -f ".github/dotfiles/.swiftformat" ]]; then
    swiftformat . --config ".github/dotfiles/.swiftformat"
fi

if [[ -f ".github/dotfiles/.swiftlint" ]]; then
    swiftlint autocorrect --config ".github/dotfiles/.swiftlint.yml"
fi

if [[ -f "swiftgen.yml" ]]; then
    swiftgen
fi
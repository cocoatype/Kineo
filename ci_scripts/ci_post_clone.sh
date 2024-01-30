#!/bin/sh
curl https://mise.jdx.dev/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

mise install tuist # Version controlled by .tool-versions
eval "$(mise activate zsh --shims)" # Adds the activated tools to $PATH

tuist fetch --path ..
tuist generate --no-open --path ..

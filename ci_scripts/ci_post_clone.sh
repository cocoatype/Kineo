#!/bin/sh
curl https://mise.jdx.dev/install.sh | sh
export PATH="$HOME/.local/bin/bin:$PATH"

mise install # Installs the tools in .tool-versions
eval "$(mise activate bash --shims)" # Adds the activated tools to $PATH

tuist fetch
tuist generate --no-open

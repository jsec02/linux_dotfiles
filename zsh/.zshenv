# ================================================================================
# =                                   .ZSHENV                                    =
# ================================================================================

# Load secrets
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"

# Only add to PATH if not already present
typeset -U PATH path

# General
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
fi

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/python/scripts:$PATH"
export PATH="$HOME/bash/scripts:$PATH"
export PATH="$HOME/bash/backup:$PATH"
export PATH="$PATH:/mnt/c/Windows/System32"

# Python
export PYTHONBREAKPOINT=ipdb.set_trace

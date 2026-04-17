# -g  session-global (not universal — dotfiles is source of truth)
# -P  modify $PATH directly instead of $fish_user_paths
# -m  move existing entries to the front (overrides macOS path_helper re-ordering)
fish_add_path -gPm \
    /opt/homebrew/bin \
    $HOME/.local/bin \
    $HOME/.local/share/mise/shims \
    $HOME/.antigravity/antigravity/bin \
    $HOME/google-cloud-sdk/bin \
    $GOPATH/bin \
    $HOME/tools/verible/bin

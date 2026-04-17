status is-interactive; or exit 0

type -q bat; and alias cat='bat'

if type -q eza
    alias ls='eza'
    alias ll='eza -lh --git'
    alias la='eza -lah --git'
    alias lt='eza --tree --level=2'
end

type -q fd; and alias f='fd'

if type -q fzf; and type -q fd
    function vf
        set -l file (fd . | fzf)
        and vim $file
    end
end

alias dotfiles "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias c='claude'
alias .. 'cd ..'
alias ... 'cd ../..'

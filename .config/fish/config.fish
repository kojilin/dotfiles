if type -q exa 
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

if type -q starship
  starship init fish | source
end

if status is-interactive
and not set -q TMUX
    exec tmux
end

set -gx EDITOR vim

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

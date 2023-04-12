if type -q exa 
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

starship init fish | source

set -gx EDITOR vim

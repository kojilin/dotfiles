{ config, pkgs, ... }:

{
  home.username = "kojilin";
  home.homeDirectory = "/home/kojilin";

  home.stateVersion = "22.11";

  home.packages = [
    pkgs.htop
    pkgs.ripgrep
    pkgs.jq
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  programs.fzf = {
    enable = true;
    # fzf.fish plugin will help integrate.
    enableFishIntegration = false;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
    };
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    mouse = true;
    customPaneNavigationAndResize = true;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "9.7";
          sha256 = "sha256-haNSqXJzLL3JGvD4JrASVmhLJz6i9lna6/EdojXdFOo=";
        };
      }

      {
        name = "sdkman-for-fish";
        src = pkgs.fetchFromGitHub {
          owner = "reitzig";
          repo = "sdkman-for-fish";
          rev = "ac380d8f61f2afa800cdf4bbfb5c980a99b13f1a";
          sha256 = "sha256:kZvyip+InxNd54kGT9bcRjAVGymw58jbQjzqiOk3jRU=";
        };
      }

      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "sha256:+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }

      # Need this when using Fish as a default macOS shell in order to pick
      # up ~/.nix-profile/bin
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
        };
      }
    ];

    shellInit = ''
      alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    '';

    interactiveShellInit = ''
      if not set -q TMUX
         if tmux has-session -t home 2>/dev/null
             exec tmux attach-session -t home
         else
             tmux new-session -s home
         end
      end
    '';
  };
}

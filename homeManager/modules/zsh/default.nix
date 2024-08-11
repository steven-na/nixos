{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.fzf
    pkgs.zoxide
  ];

  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-autosuggestions";
        file = "zsh-autosuggestions.plugin.zsh";
        src = builtins.fetchGit {
          # Updated 2024-Aug-03
          url = "https://github.com/zsh-users/zsh-autosuggestions";
          rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
        };
      }
      {
        name = "zsh-completions";
        file = "zsh-completions.plugin.zsh";
        src = builtins.fetchGit {
          # Updated 2024-Aug-03
          url = "https://github.com/zsh-users/zsh-completions";
          rev = "67921bc12502c1e7b0f156533fbac2cb51f6943d";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = builtins.fetchGit {
          # Updated 2024-Aug-03
          url = "https://github.com/zsh-users/zsh-syntax-highlighting";
          rev = "db085e4661f6aafd24e5acb5b2e17e4dd5dddf3e";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = builtins.fetchGit {
          # Updated 2024-Aug-03
          url = "https://github.com/Aloxaf/fzf-tab";
          rev = "c7fb028ec0bbc1056c51508602dbd61b0f475ac3";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git"
       ];
      theme = "robbyrussell";
    };

    # zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    # zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview '[ -d $realpath ] && ls $realpath || [ -f $realpath ] && bat $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview '[ -d $realpath ] && ls $realpath || [ -f $realpath ] && bat $realpath'
      zstyle ':fzf-tab:complete:sn:*' fzf-preview '[ -d $realpath ] && ls $realpath || [ -f $realpath ] && bat $realpath'
      
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(fzf --zsh)"

      alias ls='ls --color'
      alias sn='sudo nano'

      neofetch
    ''; 
    
    #shellAliases = {};
  };
}

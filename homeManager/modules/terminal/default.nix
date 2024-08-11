{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.fzf

    pkgs.tmuxPlugins.vim-tmux-navigator
    pkgs.tmuxPlugins.continuum
    # pkgs.tmuxPlugins.tmux-fzf
    pkgs.tmuxPlugins.nord
    pkgs.tmuxPlugins.yank
  ];

  programs.tmux = {
    enable = true;
    mouse = true;
    disableConfirmationPrompt = true;
    extraConfig = ''
      # unbind C-b
      # set -g prefix C-Space
      # bind C-Space send-prefix

      bind '"' split-window -v -c "#{pane_current_path}" \; send-keys -R;
      bind % split-window -h -c "#{pane_current_path}" \; send-keys -R;

      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g status-position top
      # set-option -g @plugin 'sainnhe/tmux-fzf'

      run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux
      run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
      # run-shell ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/tmux-fzf.tmux
      run-shell ${pkgs.tmuxPlugins.nord}/share/tmux-plugins/nord/nord.tmux
      run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    # useTheme = "material";
  };

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

    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [ 
    #     "git"
    #    ];
    #   theme = "robbyrussell";
    # };

    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview '[ -d $realpath ] && ls $realpath || [ -f $realpath ] && bat $realpath'
      
      eval "$(fzf --zsh)"
      eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config ${./zen-omp/zen.toml})"

      alias ls='ls --color'
      alias sn='sudo nano'
      
      fastfetch

      tmux attach-session || \
      tmux \
        new-session -s "Main" \; \
        split-window "gotop ; read" \; \
        select-layout "$(cat nixos/homeManager/modules/terminal/tmux-default-layout)" \; \
        select-pane -t 0
    ''; 
    
    #shellAliases = {};
  };
}

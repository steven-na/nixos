{ lib, config, pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.ripgrep
  ];

  programs.neovim = 
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
      {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
      ];

      plugins = with pkgs.vimPlugins; [
        {
          plugin = nord-nvim;
          config = ''
          let mapleader = " "  
          let g:nord_disable_background = v:true
          colorscheme nord
          '';
        }
        {
          plugin = mason-nvim;
          config = toLuaFile ./plugin/mason.lua;
        }
        {
          plugin = mason-lspconfig-nvim;
          config = toLuaFile ./plugin/masonLSP.lua;
        }
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./plugin/lsp.lua;
        }
        {
          plugin = lualine-nvim;
          config = toLua "require(\"lualine\").setup()";
        }
        {
          plugin = telescope-nvim;
          config = toLuaFile ./plugin/telescope.lua;
        }

        telescope-fzf-native-nvim

        lualine-nvim
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
          ]));
          config = toLuaFile ./plugin/treesitter.lua;
        }
        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./plugin/neo-tree.lua;
        }

        vim-nix
      ];
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
      '';
    };
}

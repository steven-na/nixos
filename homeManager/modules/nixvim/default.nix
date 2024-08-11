{inputs, pkgs, ...}:
{
  programs.nixvim = {
    enable = true;
    colorschemes.base16 = {
      enable = true;
      colorscheme = "nord";
    };

    plugins = {
      lsp = {
        enable = true;
        servers = {
          rust-analyzer.enable = true;
        };
      };
      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];
      };
    };
  };
}

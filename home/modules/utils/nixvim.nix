{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.myHome.modules.utils.nixvim;
in
{
  options.myHome.modules.utils.nixvim.enable = lib.mkEnableOption "utils/nixvim";

  # Pulls the nixvim flake input. This module is NOT part of the utils
  # registry: it's imported explicitly only by hosts/users that want it,
  # so unused hosts never fetch or evaluate nixvim.
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      enableMan = false;

      colorschemes.catppuccin.enable = true;
      plugins.lualine.enable = true;
      globals.mapleader = " ";

      opts = {
        number = true;
        relativenumber = true;
      };

      plugins.neo-tree = {
        enable = true;
        settings.enable_git_status = true;
      };

      plugins.lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
        };
      };

      plugins.cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };

      plugins.cmp-nvim-lsp.enable = true;

      keymaps = [
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Neotree toggle<cr>";
          options = {
            desc = "Toggle Neo-tree";
            silent = true;
          };
        }
      ];
    };
  };
}

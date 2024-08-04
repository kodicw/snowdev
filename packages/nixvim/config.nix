{
  opts = {
    number = true;
    relativenumber = true;
    cursorline = true;
    shell = "/run/current-system/sw/bin/sh";
  };
  keymaps = import ./keymaps.nix;
  globals = {
    mapleader = " ";
  };
  viAlias = true;
  vimAlias = true;
  clipboard.register = "unnamedplus";
  plugins = import ./plugins.nix;
  colorschemes.oxocarbon.enable = true;
  clipboard.providers.wl-copy.enable = true;
}



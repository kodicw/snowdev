{
  opts = {
    number = true;
    relativenumber = true;
    cursorline = true;
  };
  keymaps = import ./keymaps.nix;
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  plugins = import ./plugins.nix;
  colorschemes.oxocarbon.enable = true;
  clipboard.providers.wl-copy.enable = true;
}

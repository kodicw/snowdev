{
  enable = true;
  inlayHints = true;
  servers = {
    nushell = {
      enable = true;
      autostart = true;
      filetypes = [ "nu" ];
    };
    html = {
      enable = true;
      autostart = true;
    };

    htmx = {
      enable = true;
      autostart = true;
    };

    yamlls = {
      enable = true;
      autostart = true;
    };

    jsonls = {
      enable = true;
      autostart = true;
    };

    nil-ls.enable = true;
    ts-ls.enable = true;

    pyright = {
      enable = true;
      autostart = true;
    };

    ruff-lsp = {
      enable = true;
      autostart = true;
    };

    nixd = {
      enable = true;
      autostart = true;
    };

    zls = {
      enable = true;
      autostart = true;
    };

    gleam.enable = true;
    gopls.enable = true;
  };
}

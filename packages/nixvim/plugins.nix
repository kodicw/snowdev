{
  lsp-lines.enable = true;
  helm.enable = true;
  # orgmode.enable = true;
  ollama = {
    enable = true;
    model = "gemma:2b";
    prompts = {
      "Correct!" = {
        action = "replace";
        prompt = ''
          Make corrections to my notes.
          Only return corected notes.
          Notes: ```md
          $sel
          ```
        '';
      };
    };
  };
  chadtree = {
    enable = true;
  };
  nix.enable = true;
  image = {
    enable = true;
  };
  noice.enable = true;
  # magma-nvim.enable = true; # new plugins start here
  # navbuddy.enable = true;
  # neoclip.enable = true;
  # neorg.enable = true;
  # friendly-snippets.enable = true; # new plugins end here
  todo-comments.enable = true;
  toggleterm.enable = true;
  neogit.enable = true;
  dashboard = {
    enable = true;
    settings = {
      config.header = [
        "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
        "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
        "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
        "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
        "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
        "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
      ];
    };
  };
  dap.enable = true;
  multicursors.enable = true;
  endwise.enable = true;
  mini = {
    enable = true;
    modules = {
      comment = { };
    };
  };
  bufferline.enable = true;
  copilot-lua.suggestion.enabled = false;
  copilot-lua.panel.enabled = false;
  luasnip.enable = true;
  treesitter.enable = true;
  lspkind.enable = true;
  lint.enable = true;
  wtf.enable = true;
  surround.enable = true;

  oil = {
    enable = true;
    settings = {
      skip_confirm_for_simple_edits = true;
      delete_to_trash = true;
      # view_options = {
      #   show_hidden = false;
      # };
    };
  };

  lualine.enable = true;
  notify.enable = true;
  notify.level = "error";
  lsp-format.enable = true;
  cmp = {
    autoEnableSources = true;
    enable = true;
    settings = {
      completion.autoImport = true;
      snippet.expand = "luasnip";
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "treesitter"; }
        { name = "calc"; }
        { name = "dictionary"; }
        { name = "emoji"; }
        { name = "copilot"; }
        { name = "snippy"; }
        { name = "spell"; }
      ];
      mapping = {
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<S-CR>" = "cmp.mapping.confirm({ select = true })";
      };
    };
  };
  telescope = {
    enable = true;
    settings.defaults.file_ignore_patterns = [ "^.git/" ];
    keymaps."<leader>e" = "find_files";
  };
  which-key.enable = true;
  lsp = import ./lsp.nix;
}


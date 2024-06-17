{
  opts = {
    number = true;
    relativenumber = true;
    cursorline = true;
  };
  keymaps = [
    {
      action = "<cmd>CHADopen<CR>";
      key = "<leader>l";
      options = {
        desc = "Open CHADTree";
      };
    }
    {
      action = "<cmd>Neogit<CR>";
      key = "<leader>g";
      options = {
        desc = "Git UI";
      };
    }
    {
      action = "<cmd>Oil<CR>";
      key = "<leader>f";
      options = {
        desc = "Open oil";
      };
    }
    {
      action = "<cmd>MCunderCursor<CR>";
      key = "<leader>c";
      options = {
        desc = "Start multicursor";
      };
    }
    {
      action = "<cmd>ToggleTerm<CR>";
      key = "<leader>t";
      options = {
        desc = "Toggle terminal";
      };
    }
  ];
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  plugins = {
    chadtree = {
      enable = true;
    };
    nix.enable = true;
    image = {
      enable = true;
    };
    noice.enable = true;
    todo-comments.enable = true;
    toggleterm.enable = true;
    neogit.enable = true;
    dashboard = {
      enable = true;
      settings = {
        header = [
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
    oil.enable = true;
    lualine.enable = true;
    notify.enable = true;
    notify.level = "info";
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
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
      };
    };
    telescope = {
      enable = true;
      settings.defaults.file_ignore_patterns = [ "^.git/" ];
      keymaps."<leader>e" = "find_files";
    };
    which-key.enable = true;
    lsp = {
      enable = true;
      servers = {
        nushell = {
          enable = true;
          autostart = true;
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
        tsserver.enable = true;
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
    };
  };
  colorschemes.onedark.enable = true;
  clipboard.providers.wl-copy.enable = true;
}

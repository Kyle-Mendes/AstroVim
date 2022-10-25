local config = {
  options = {
    opt = {
      clipboard = "",
      wrap = true,
    },
    g = {
      italic = true,
      catppuccin_flavour = "frappe",
      catppuccin_styles = {
        comments = {"italic"},
        functions = {"italic"},
        keywords = {"bold"},
        strings = "NONE",
        variables = "NONE",
      },
      catppuccin_custom_highlights = function(colors)
        return {
          rainbowcol1 = colors.flamingo,
        }
      end,
    }
  },

  mappings = {
    n = {
      ["<leader>,"] = {":noh<CR>", desc = "noh"},
      ["<leader>xl"] = {":colorscheme melange<CR> :set background=light<CR>", desc = "light melange"},
      ["<leader>xm"] = {":colorscheme melange<CR> :set background=dark<CR>", desc = "dark melange"},
      ["<leader>xe"] = {":colorscheme everforest<CR> :set background=dark<CR>", desc = "dark everforest"},
      ["<leader>xc"] = {":colorscheme catppuccin<CR> :set background=dark<CR>", desc = "dark catpuccin"},
      ["<leader>xr"] = {":colorscheme rose-pine<CR>", desc = "dark rose"},
      ["<C-e>"] = function()
        local result = vim.treesitter.get_captures_at_cursor()
        print(vim.inspect(result))
      end,
    }
  },

  plugins = {
    init = {
      {"machakann/vim-sandwich"},
      {"lambdalisue/gina.vim"},
      {"habamax/vim-godot"},
      -- Tree Sitter
      {"David-Kunz/markid"},
      {"RRethy/nvim-treesitter-endwise"},
      -- Themes
      {"savq/melange"},
      {"EdenEast/nightfox.nvim"},
      {"sainnhe/everforest"},
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup({
            flavour = "latte" -- mocha, macchiato, frappe, latte
          })
          vim.cmd('colorscheme catppuccin')
        end
      },
      -- {
      --   "catppuccin/nvim",
      --   as = "catppuccin",
      --   config = function()
      --     require("catppuccin").setup{
      --     flavor = 'mocha',
      --     styles = {
      --       comments = "italic",
      --       functions = "italic",
      --       keywords = "italic",
      --       strings = "NONE",
      --       variables = "NONE",
      --     },
      --     color_overrides = {
      --       all = {
      --         rainbowcol1 = 'teal',
      --         rainbowcol2 = 'teal',
      --         rainbowcol3 = 'teal',
      --         rainbowcol4 = 'teal',
      --         rainbowcol5 = 'teal',
      --         rainbowcol6 = 'teal',
      --       }
      --     },
      --     custom_highlights = function(colors)
      --       return {
      --         rainbowcol1 = colors.teal,
      --         rainbowcol2 = colors.teal,
      --         rainbowcol3 = colors.teal,
      --         rainbowcol4 = colors.teal,
      --         rainbowcol5 = colors.teal,
      --         rainbowcol6 = colors.teal,
      --       }
      --     end,
      --     integrations = {
      --       ts_rainbow = true
      --       -- {
      --       --   enabled = true,
      --       --   colors = {
      --       --     rainbowcol1 = { fg = "teal" },
      --       --     rainbowcol2 = { fg = "teal" },
      --       --     rainbowcol3 = { fg = "teal" },
      --       --     rainbowcol4 = { fg = "lavendar" },
      --       --     rainbowcol5 = { fg = "rosewater" },
      --       --     rainbowcol6 = { fg = "peach" },
      --       --     rainbowcol7 = { fg = "teal" },
      --       --   }
      --       -- },
      --     },
      --   }
      --   vim.api.nvim_command "colorscheme catppuccin"
      -- end,
      -- },
      {
        "rose-pine/neovim",
        as = "rose-pine",
      },
      -- Languages
      -- {"ziglang/zig.vim"},
      -- Overrides
      ["declancm/cinnamon.nvim"] = {disable = true},
    },
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = { "lua" },
      endwise = {
        enabled = true
      },
      markid = { endabled = true},
    },
    feline = function(config)
      local file_info = {
        provider = {
          name = "file_info",
          opts = {
            type = 'base_only',
            unique = true,
          }
        },
        short_provider = {
          name = "file_info",
          opts = {
            type = 'base_only',
            unique = true,
          }
        },
      }
      table.insert(config.components.active[1], 7, file_info)
      return config
    end,
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup functino call
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      }
      -- set up null-ls's on_attach function
      -- NOTE: You can remove this on attach function to disable format on save
      config.on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table to use in require("null-ls").setup(config)
    end,
  },

  lsp = {
    servers = {
      'gdscript',
    },
    ["server-settings"] = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          extraPaths = {'~/.virtualenvs/discord_api/lib/python3.7/site-packages', '/Users/kylemendes/Projects/discord/discord/discord_common/py'}
        }
      },
    },
  },

  polish = function()
    require("catppuccin").setup {
      flavour = "frappe",
      integrations = {
        ts_rainbow = true,
      },
      color_overrides = {
        frappe = {
          base = '#232136',
		      surface = '#2a273f',
		      overlay = '#393552',
		      muted = '#6e6a86',
		      subtle = '#908caa',
		      text = '#e0def4',
		      love = '#eb6f92',
		      gold = '#f6c177',
		      rose = '#ea9a97',
		      pine = '#3e8fb0',
		      foam = '#9ccfd8',
		      iris = '#c4a7e7',
		      highlight_low = '#2a283e',
		      highlight_med = '#44415a',
		      highlight_high = '#56526e',
		      none = 'NONE',
        }
      },
    }
    local unmap = vim.api.nvim_del_keymap
    unmap("v", "<")
    unmap("v", ">")
  end,

  default_theme = {
    diagnostics_style = { italic = true },
  },

  melange = {
    diagnostics_style = { italic = true },
  },
  colorscheme = 'catppuccin',
}

return config

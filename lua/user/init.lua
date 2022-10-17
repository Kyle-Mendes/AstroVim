local config = {
  options = {
    opt = {
      wrap = true,
    },
    g = {},
  },

  mappings = {
    n = {
      ["<leader>,"] = {":noh<CR>", desc = "noh"},
      ["<leader>xl"] = {":colorscheme melange<CR> :set background=light<CR>", desc = "light melange"},
      ["<leader>xm"] = {":colorscheme melange<CR> :set background=dark<CR>", desc = "dark melange"},
      ["<leader>xd"] = {":colorscheme onedark<CR> :set background=dark<CR>", desc = "dark default"},
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

  default_theme = {
    diagnostics_style = { italic = true },
  },

  melange = {
    diagnostics_style = { italic = true },
  },
}

return config

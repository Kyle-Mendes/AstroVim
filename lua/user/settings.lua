local config = {

  -- Set colorscheme
  colorscheme = "onedark",

  -- tabstop = 4,
  -- shiftwidth = 4,

  -- Add plugins
  plugins = {
  {"machakann/vim-sandwich"},
  {"lambdalisue/gina.vim"},
  {"RRethy/nvim-treesitter-endwise"},
  {"savq/melange"},
  {"habamax/vim-godot"},

    -- { "andweeb/presence.nvim" },
    -- {
    -- "ray-x/lsp_signature.nvim",
    -- event = "BufRead",
    -- config = function()
    -- require("lsp_signature").setup()
    -- end,
    -- },
  },

  overrides = {
    treesitter = {
      ensure_installed = { "lua" },
      endwise = {
        enabled = true
      }
    },
    lualine = {
      sections = {
        lualine_a = {
          { "filename", file_status = true, path = 1, full_path = true, shorten = false },
        },
      }
    }
  },

  -- Diagnostics option
  diagnostics = {
    enable = true,
    text = "none",
  },
  -- On/off virtual diagnostics text
  virtual_text = true,

  -- Disable default plugins
  enabled = {
    bufferline = true,
    nvim_tree = true,
    lualine = true,
    lspsaga = true,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    dashboard = true,
    which_key = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
  },

  packer_file = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",

  polish = function()
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_set_keymap
    local set = vim.opt
    -- Set options
    set.relativenumber = true

    set.clipboard = ""

    -- Remap space as leader key
    map("", "<Space>", "<Nop>", opts)
    -- vim.g.mapleader = " "
    -- vim.g.maplocalleader = " "

    set.list = true
    -- set.listchars = "trail:·,tab:>"
    set.listchars:append("trail:·")
    -- set.listchars:append("tab:>")
    set.termguicolors = true
    -- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
    -- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
    -- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
    -- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
    -- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
    -- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

    require("indent_blankline").setup {
      show_end_of_line = true,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
    }

    -- Set key bindings
    map("n", "<C-s>", ":w!<CR>", opts)

    -- Personal
    map("n", "<C-s>", ":w!<CR>", opts)
    map("n", "<leader>,", ":noh<CR>", opts)
    map("n", "<S-t>", ":ToggleTerm size=6 direction=horizontal<CR>", opts)
    map("n", "<leader>xl", ":colorscheme melange<CR> :set background=light<CR>", opts)
    map("n", "<leader>xm", ":colorscheme melange<CR> :set background=dark<CR>", opts)
    map("n", "<leadr>xd", ":colorscheme onedark<CR> :set background=dark<CR>", opts)

    -- Telescope
    map("n", "<leader>gf", "<cmd>Telescope git_files<CR>", opts)

    local _, nvim_tree = pcall(require, "nvim-tree")
    nvim_tree.setup {
      update_focused_file = {
        enable      = true,
        update_cwd  = false,
        ignore_list = {}
      },
    }

    -- Set autocommands
    vim.cmd [[
      augroup packer_conf
        autocmd!
        autocmd bufwritepost plugins.lua source <afile> | PackerSync
      augroup end
      augroup formatting
        autocmd bufwritepre * :%s/\s\+$//e
      augroup end
    ]]
  end,
}

-- -- Godot
-- require'lspconfig'.gdscript.setup{}

return config

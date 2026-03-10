return {
  -- add flexoki
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    priority = 1000,
  },

  -- add tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night", -- 'storm', 'moon', 'night', 'day'
    },
  },

  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}

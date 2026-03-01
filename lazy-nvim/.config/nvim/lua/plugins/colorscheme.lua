return {
  -- add flexoki
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    priority = 1000,
  },

  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "flexoki-dark",
    },
  },
}

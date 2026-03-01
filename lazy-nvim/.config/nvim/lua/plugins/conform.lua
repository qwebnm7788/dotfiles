return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      lua = { "stylua" },
      -- python = { "isort", "black" },
      -- javascript = { { "prettierd", "prettier" } },
    },
    -- Set up format-on-save
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}

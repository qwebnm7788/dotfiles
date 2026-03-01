return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "gopls",
      "golangci-lint",
      "goimports",
      "gofumpt",
      "vtsls",
      "prettier",
    },
  },
}

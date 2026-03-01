return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- add servers here
        lua_ls = {},
        vtsls = {},
        gopls = {},
      },
    },
    init = function()
      -- Set Go environment variables for GUI nvim
      if not os.getenv("GOROOT") then
        local handle = io.popen("go env GOROOT 2>/dev/null")
        if handle then
          local goroot = handle:read("*l")
          handle:close()
          if goroot and goroot ~= "" then
            vim.env.GOROOT = goroot
          end
        end
      end
      if not os.getenv("GOPATH") then
        vim.env.GOPATH = vim.fn.expand("~/go")
      end
      vim.env.GO111MODULE = "on"

      -- Neovim 0.11+ uses vim.lsp.config with on_dir callback
      -- TypeScript (vtsls)
      vim.lsp.config("vtsls", {
        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, { "package.json", "tsconfig.json", ".git" })
          if root then
            on_dir(root)
          end
        end,
      })

      -- Go (gopls)
      vim.lsp.config("gopls", {
        root_dir = function(bufnr, on_dir)
          -- With go.work at the root, this will find the workspace root correctly.
          local root = vim.fs.root(bufnr, { "go.work", "go.mod", ".git" })
          if root then
            on_dir(root)
          end
        end,
        settings = {
          gopls = {
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })
    end,
  },
}

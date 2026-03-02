return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
      },
      root_patterns = { ".git", "pubspec.yaml" },
      fvm = false,
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = "ErrorMsg",
        prefix = "// ",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabedit",
      },
      lsp = {
        color = {
          enabled = true,
          background = false,
          foreground = false,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          dart = {
            completeFunctionCalls = true,
            lineLength = 120,
          },
        },
        on_attach = function(client, bufnr)
          -- Standard LSP keybindings
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
          map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
          map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List workspace folders")
          map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "gr", vim.lsp.buf.references, "Go to references")
          map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, "Format")

          -- Flutter-specific keybindings
          map("n", "<leader>fc", "<cmd>FlutterRun<cr>", "Flutter run")
          map("n", "<leader>fq", "<cmd>FlutterQuit<cr>", "Flutter quit")
          map("n", "<leader>fr", "<cmd>FlutterHotReload<cr>", "Flutter hot reload")
          map("n", "<leader>fR", "<cmd>FlutterHotRestart<cr>", "Flutter hot restart")
          map("n", "<leader>fd", "<cmd>FlutterDevTools<cr>", "Flutter dev tools")
          map("n", "<leader>fp", "<cmd>FlutterPubGet<cr>", "Flutter pub get")
          map("n", "<leader>fu", "<cmd>FlutterPubUpgrade<cr>", "Flutter pub upgrade")
          map("n", "<leader>fl", "<cmd>FlutterListDevices<cr>", "Flutter list devices")
          map("n", "<leader>fs", "<cmd>FlutterEmulators<cr>", "Flutter emulators")
          map("n", "<leader>fo", "<cmd>FlutterOutlineToggle<cr>", "Flutter outline toggle")
          map("n", "<leader>fv", "<cmd>FlutterVisualDebug<cr>", "Flutter visual debug")
          -- Test keybindings
          map("n", "<leader>ft", "<cmd>FlutterTest<cr>", "Flutter test all")
          map("n", "<leader>fT", "<cmd>FlutterTestFile<cr>", "Flutter test file")
          map("n", "<leader>fn", "<cmd>FlutterTestNearest<cr>", "Flutter test nearest")
        end,
      },
    },
    config = function(_, opts)
      require("flutter-tools").setup(opts)
    end,
  },
}

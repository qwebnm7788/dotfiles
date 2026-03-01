return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      -- 가로 분할 형태로 터미널을 엽니다. (세로를 원하시면 "vertical"로 변경 가능)
      direction = "horizontal",
      size = 15,
      -- Ctrl + \ 키로 터미널을 열고 닫을 수 있습니다.
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,   -- 입력 모드에서도 단축키 사용 가능
      terminal_mappings = true, -- 터미널 모드에서도 단축키 사용 가능
      persist_size = true,
      persist_mode = true,      -- 터미널을 다시 열었을 때 이전 모드(입력/일반) 유지
      close_on_exit = true,     -- 프로세스 종료 시 창 닫기
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- 터미널 내에서 창 이동 및 모드 전환을 더 편하게 하기 위한 단축키 설정
      function _G.set_terminal_keymaps()
        local opt = { buffer = 0 }
        -- Esc 두 번으로 터미널 일반 모드 진입
        vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opt)
        -- 터미널 모드에서도 Ctrl + h,j,k,l 로 창 이동 가능
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opt)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opt)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opt)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opt)
      end

      -- 터미널이 열릴 때마다 위의 단축키들을 적용합니다.
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}

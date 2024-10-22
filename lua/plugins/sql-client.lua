return {
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",
  init = function()
    -- Налаштування DBUI
    vim.g.db_ui_notification_width = 10 -- Ширина сповіщень
    vim.g.db_ui_winwidth = 10          -- Ширина DBUI
    vim.g.db_ui_win_position = 'right'  -- Позиція DBUI
  end,
}

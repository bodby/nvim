local plugin = require "telescope"

plugin.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = "move_selection_next",
        ["<C-p>"] = "move_selection_previous",
        -- ["<Tab>"] = "toggle_selection",
        ["<CR>"]  = "select_default",
        ["<Esc>"] = "close"
      }
    },
    prompt_prefix   = " ",
    entry_prefix    = " ",
    selection_caret = " ",
    hl_result_eol   = true,
    multi_icon      = "+",
    border          = true,
    preview         = { hide_on_startup = true },

    borderchars = {
      -- prompt = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      -- results = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      -- preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    },
    get_status_text = function(_)
      return ""
    end,

    results_title         = false,
    prompt_title          = false,
    dynamic_preview_title = true,
    layout_strategy       = "horizontal",
    sorting_strategy      = "descending",
    layout_config = {
      height          = 0.6,
      width           = 0.6,
      prompt_position = "bottom"
    }
  },
  ["zf-native"] = {
    file = {
      enable            = true,
      highlight_results = false,
      match_filename    = true,
      initial_sort      = nil,
      smart_case        = true
    },
    generic = {
      enable            = true,
      highlight_results = false,
      match_filename    = false,
      initial_sort      = nil,
      smart_case        = true
    }
  }
})

plugin.load_extension "zf-native"

vim.keymap.set("n", "<Leader>ff", function()
  require("telescope.builtin").find_files({ prompt_title = false })
end)

vim.keymap.set("n", "<Leader>fr", function()
  require("telescope.builtin").oldfiles({ prompt_title = false })
end)

vim.keymap.set("n", "<Leader>fb", function()
  require("telescope.builtin").buffers({ prompt_title = false })
end)

vim.keymap.set("n", "<Leader>fg", function()
  require("telescope.builtin").live_grep({
    prompt_title        = false,
    grep_open_files     = false,
    disable_coordinates = true
  })
end)

vim.keymap.set("v", "<leader>fg", function()
  require("telescope.builtin").grep_string({
    prompt_title        = false,
    grep_open_files     = false,
    disable_coordinates = true
  })
end)

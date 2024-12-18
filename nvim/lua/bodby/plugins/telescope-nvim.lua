local telescope = require "telescope"
local map = vim.keymap.set

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = "move_selection_next",
        ["<C-p>"] = "move_selection_previous",
        -- ["<Tab>"] = "toggle_selection",
        ["<CR>"] = "select_default",
        ["<Esc>"] = "close"
      }
    },
    prompt_prefix = "> ",
    entry_prefix = " ",
    selection_caret = " ",
    hl_result_eol = true,
    multi_icon = "+",
    border = true,
    borderchars = {
      prompt = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      results = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      -- results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    },
    preview = {
      hide_on_startup = true
    },
    get_status_text = function(_)
      return ""
    end,
    results_title = false,
    prompt_title = false,
    dynamic_preview_title = true,
    layout_strategy = "horizontal",
    sorting_strategy = "descending",
    layout_config = {
      height = 0.6, -- vim.o.lines.
      width = 0.6, -- vim.o.columns - 2.
      prompt_position = "bottom"
      -- preview_height = 0.6,
    }
  },
  ["zf-native"] = {
    file = {
      enable = true,
      highlight_results = false,
      match_filename = true,
      initial_sort = nil,
      smart_case = true
    },
    generic = {
      enable = true,
      highlight_results = false,
      match_filename = false,
      initial_sort = nil,
      smart_case = true
    }
  }
})

telescope.load_extension "zf-native"

map("n", "<Leader>ff", function()
  require("telescope.builtin").find_files({
    prompt_title = false
  })
end)

map("n", "<Leader>fr", function()
  require("telescope.builtin").oldfiles({
    prompt_title = false
  })
end)

map("n", "<Leader>fb", function()
  require("telescope.builtin").buffers({
    prompt_title = false
  })
end)

map("n", "<Leader>fg", function()
  require("telescope.builtin").live_grep({
    prompt_title = false,
    grep_open_files = false,
    disable_coordinates = true
  })
end)

map("v", "<leader>fg", function()
  require("telescope.builtin").grep_string({
    prompt_title = false,
    grep_open_files = false,
    disable_coordinates = true
  })
end)

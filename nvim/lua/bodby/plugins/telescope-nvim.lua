local telescope = require "telescope"
local map = vim.keymap.set

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = "move_selection_next",
        ["<C-p>"] = "move_selection_previous",
        ["<Tab>"] = "toggle_selection",
        ["<CR>"] = "select_default",
        ["<Esc>"] = "close"
      }
    },
    scroll_strategy = "cycle",
    prompt_prefix = "",
    entry_prefix = " ",
    selection_caret = " ",
    hl_result_eol = true,
    multi_icon = " *",
    border = false,
    borderchars = { "", "", "", "", "", "", "", "" },
    preview = {
      hide_on_startup = true
    },
    results_title = "",
    prompt_title = "",
    layout_strategy = "bottom_pane",
    sorting_strategy = "ascending",
    layout_config = {
      height = 16, -- vim.o.lines.
      width = nil, -- vim.o.columns - 2.
      prompt_position = "bottom",
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
  local themes = require "telescope.themes"

  require("telescope.builtin").find_files({
    prompt_title = "",
  })
end)
map("n", "<Leader>fr", function()
  local themes = require("telescope.themes")

  require("telescope.builtin").oldfiles({
    prompt_title = ""
  })
end)
map("n", "<Leader>fb", function()
  local themes = require("telescope.themes")

  require("telescope.builtin").buffers({
    prompt_title = ""
  })
end)
map("n", "<Leader>fg", function()
  local themes = require("telescope.themes")

  require("telescope.builtin").live_grep({
    prompt_title = "",
    grep_open_files = false,
    disable_coordinates = true
  })
end)
utils.map("v", "<leader>fg", function()
  local themes = require("telescope.themes")

  require("telescope.builtin").grep_string({
    prompt_title = "",
    grep_open_files = false,
    disable_coordinates = true
  })
end)

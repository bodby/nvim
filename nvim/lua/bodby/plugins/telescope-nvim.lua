local plugin     = require "telescope"
local strategies = require "telescope.pickers.layout_strategies"

strategies.flex_margins = function(picker, max_columns, max_lines, layout_config)
  local layout = strategies.flex(picker, max_columns, max_lines, layout_config)

  layout.preview.col   = layout.preview.col + 1
  layout.preview.width = layout.preview.width - 2
  layout.preview.height = layout.preview.height - 1

  layout.results.col    = layout.results.col + 1
  layout.results.width  = layout.results.width - 2
  layout.results.height = layout.results.height - 2

  layout.prompt.col   = layout.prompt.col + 1
  layout.prompt.width = layout.prompt.width - 2
  layout.prompt.line  = layout.prompt.line - 1

  return layout
end

plugin.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-n>"]     = "move_selection_next",
        ["<C-p>"]     = "move_selection_previous",
        ["<C-u>"]     = "preview_scrolling_up",
        ["<C-d>"]     = "preview_scrolling_down",
        ["<CR>"]      = "select_default",
        ["<Esc>"]     = "close"
      }
    },
    prompt_prefix   = "",
    entry_prefix    = "",
    selection_caret = "",
    hl_result_eol   = true,
    multi_icon      = "",
    border          = true,

    preview         = {
      hide_on_startup = false,
      ls_short        = true,
      msg_bg_fillchar = " "
    },

    borderchars = {
      prompt  = { " ", " ", " ", " ", " ", " ", " ", " " },
      results = { " ", " ", " ", " ", " ", " ", " ", " " },
      preview = { " ", " ", " ", " ", " ", " ", " ", " " },

      -- https://github.com/neovide/neovide/issues/2491
      -- prompt  = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      -- results = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      -- preview = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
    },

    get_status_text = function(_)
      return ""
    end,

    results_title    = "",
    prompt_title     = "",
    preview_title    = "",
    layout_strategy  = "flex_margins",
    sorting_strategy = "descending",

    layout_config = {
      height          = 0.8,
      width           = 0.8,
      prompt_position = "bottom",

      horizontal = { preview_width = 0.55 }
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
  require("telescope.builtin").find_files({
    prompt_title  = "",
    preview_title = ""
  })
end)

vim.keymap.set("n", "<Leader>fv", function()
  require("telescope.builtin").find_files({
    prompt_title  = "",
    preview_title = "",
    cwd           = "~/vault",
    search_dirs   = { "lists", "notes" }
  })
end)

vim.keymap.set("n", "<Leader>fr", function()
  require("telescope.builtin").oldfiles({
    prompt_title  = "",
    preview_title = ""
  })
end)

vim.keymap.set("n", "<Leader>fb", function()
  require("telescope.builtin").buffers({
    prompt_title  = "",
    preview_title = "",
    bufnr_width   = 4
  })
end)

vim.keymap.set("n", "<Leader>fg", function()
  require("telescope.builtin").live_grep({
    prompt_title        = "",
    preview_title       = "",
    grep_open_files     = false,
    disable_coordinates = true
  })
end)

vim.keymap.set("v", "<leader>fg", function()
  require("telescope.builtin").grep_string({
    prompt_title        = "",
    preview_title       = "",
    grep_open_files     = false,
    disable_coordinates = true
  })
end)

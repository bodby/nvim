local plugin     = require "telescope"
local strategies = require "telescope.pickers.layout_strategies"

-- Telescope has documentation worse than Nix.
-- Lua was not designed for this much code.
strategies.horizontal_alt = function(picker, max_columns, max_lines, layout_config)
  local layout = strategies.horizontal(picker, max_columns, max_lines, layout_config)

  -- Why do I have to create a custom layout to get rid of the preview title?
  -- FIXME: Open issue because 'layout.preview.title' breaks project pickers.
  -- layout.preview.title = ""
  layout.prompt.title  = ""
  layout.results.title = ""

  -- layout.results.borderchars = { "─", "│", "─", "│", "╭", "╮", "┤", "├" }
  -- layout.results.line   = layout.results.line
  -- layout.results.height = layout.results.height + 1

  return layout
end

plugin.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = "move_selection_next",
        ["<C-p>"] = "move_selection_previous",
        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",
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
    preview         = {
      hide_on_startup = false,
      ls_short        = true,
      msg_bg_fillchar = " "
    },

    borderchars = {
      -- prompt = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      -- results = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
      results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
      -- preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    },

    get_status_text = function(_)
      return ""
    end,

    results_title         = false,
    prompt_title          = false,
    dynamic_preview_title = true,
    layout_strategy       = "horizontal_alt",
    sorting_strategy      = "descending",
    layout_config = {
      height          = 0.8,
      width           = 0.8,
      prompt_position = "bottom",
      preview_width   = 0.5
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
    prompt_title = false
  })
end)

-- vim.keymap.set("n", "<Leader>fv", function()
--   require("telescope.builtin").find_files({
--     cwd          = "~/vault",
--     search_dirs  = { "lists", "notes" },
--     prompt_title = false
--   })
-- end)

vim.keymap.set("n", "<Leader>fr", function()
  require("telescope.builtin").oldfiles({
    prompt_title = false
  })
end)

vim.keymap.set("n", "<Leader>fb", function()
  require("telescope.builtin").buffers({
    prompt_title = false,
    bufnr_width  = 4
  })
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

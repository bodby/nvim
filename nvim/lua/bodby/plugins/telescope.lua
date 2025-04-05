local builtin = require('telescope.builtin')
local shared = require('bodby.shared')
local with_args = shared.lib.with_args
local border = shared.ui.border

--- @type Plugin
return {
  mappings = {
    ['<Leader>fr'] = {
      modes = 'n',
      callback = function()
        require('telescope.builtin').oldfiles()
      end,
    },
    -- TODO: Symbols style (preferrably using the 'ui' table in shared.lua).
    ['<Leader>fw'] = { modes = 'n', callback = builtin.lsp_workspace_symbols },
    ['<Leader>ff'] = {
      modes = 'n',
      callback = with_args(builtin.find_files, { hidden = true }),
    },

    ['<Leader>fg'] = {
      modes = 'n',
      callback = with_args(builtin.live_grep, {
        grep_open_files = false,
        disable_coordinates = true,
      }),
    },
  },

  opts = {
    defaults = {
      mappings = {
        i = {
          ['<C-n>'] = 'move_selection_next',
          ['<C-p>'] = 'move_selection_previous',
          ['<C-u>'] = 'preview_scrolling_up',
          ['<C-d>'] = 'preview_scrolling_down',
          ['<CR>'] = 'select_default',
          ['<Esc>'] = 'close',
        },
      },

      prompt_prefix = '',
      entry_prefix = '',
      selection_caret = '* ',
      hl_result_eol = true,
      multi_icon = '+ ',
      border = true,

      preview = { msg_bg_fillchar = ' ' },

      borderchars = {
        prompt = border.characters,
        results = border.characters,
        preview = border.characters,
      },

      file_ignore_patterns = { '^./.git/', '^.git/' },
      get_status_text = function(_)
        return ''
      end,

      layout_strategy = 'custom',
      sorting_strategy = 'descending',

      layout_config = {
        height = 0.8,
        width = 0.8,
        prompt_position = 'bottom',
      },
    },

    ['zf-native'] = {
      file = {
        enable = true,
        highlight_results = false,
        match_filename = true,
        initial_sort = nil,
        smart_case = true,
      },

      generic = {
        enable = true,
        highlight_results = false,
        match_filename = false,
        initial_sort = nil,
        smart_case = true,
      },
    },
  },

  post = function()
    require('telescope').load_extension('zf-native')
    local strategies = require('telescope.pickers.layout_strategies')

    strategies.custom = function(picker, max_columns, max_lines, layout_config)
      local layout =
        strategies.flex(picker, max_columns, max_lines, layout_config)

      if layout.preview then
        layout.preview.col = layout.preview.col + 1
        layout.preview.width = layout.preview.width - 2
        layout.preview.height = layout.preview.height - 1
      end

      layout.results.col = layout.results.col + 1
      layout.results.width = layout.results.width - 2
      layout.results.height = layout.results.height - 2

      layout.prompt.col = layout.prompt.col + 1
      layout.prompt.width = layout.prompt.width - 2
      layout.prompt.line = layout.prompt.line - 1

      return layout
    end
  end,
}

local gitsigns = require('gitsigns')

--- @type Plugin
return {
  event = 'BufEnter',
  mappings = {
    ['<Leader>g'] = {
      modes = 'n',
      callback = function()
        gitsigns.toggle_signs()
      end,
    },
  },
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '-' },
      topdelete = { text = '-' },
      changedelete = { text = '~' },
      untracked = { text = '?' },
    },
    signs_staged_enable = false,
    signcolumn = false,
  },
}

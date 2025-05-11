local gitsigns = require('gitsigns')

--- @type Plugin
return {
  event = 'BufEnter',
  mappings = {
    ['n'] = {
      ['<Leader>g'] = gitsigns.toggle_signs,
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

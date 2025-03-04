-- TODO: Should I have the sign column on by default?

--- @type plugin_config
return {
  event = "BufEnter",
  mappings = {
    {
      lhs = "<Leader>g",
      modes = "n",
      callback = function()
        local gitsigns = require("gitsigns")
        gitsigns.toggle_deleted()
        gitsigns.toggle_signs()

        -- Hopefully fixes the deleted line sometimes not disappearing.
        vim.schedule(function()
          vim.cmd "redraw!"
        end)
      end
    }
  },

  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "-" },
      topdelete = { text = "-" },
      changedelete = { text = "~" },
      untracked = { text = "?" }
    },

    signs_staged_enable = false,
    signcolumn = false,
    numhl = false,
    linehl = false,
    word_diff = false
  }
}

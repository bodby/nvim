local top_margin = 0.35
local header_margin = vim.fn.max({
  2, vim.fn.floor(vim.fn.winheight(0) * top_margin)
})

-- Components.
local header = {
  type = "text",
  opts = {
    position = "center",
    hl = "DashboardLogo"
  },
  val = {
    "           ▄ ▄                   ",
    "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
    "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
    "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
    "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
    "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
    "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
    "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
    "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    "
  }
}

local footer = {
  type = "text",
  opts = {
    position = "center",
    hl = "DashboardFooter"
  },
  val = {
    '"This quote is often falsely attributed to Mark Twain"',
    "- Mark Twain"
  }
}

local function button(shortcut, text, cmd)
  local opts = {
    position = "center",
    shortcut = shortcut,
    cursor = 16,
    width = 48,
    shrink_margin = true,
    align_shortcut = "right",
    hl = {
      { "DashboardDesc", 0, -1 }
    },
    hl_shortcut = "DashboardKey",
    keymap = {
      "n",
      shortcut,
      cmd,
      {
        noremap = true,
        silent = true,
        nowait = true
      }
    }
  }

  local function on_press()
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "t", false)
  end

  return {
    type = "button",
    val = text,
    on_press = on_press,
    opts = opts
  }
end

local shortcuts = {
  type = "group",
  val = {
    button("e", "New file", ":enew<CR>"),
    button("f", "Find file", ":Telescope find_files<CR>"),
    button("r", "Recent file", ":Telescope oldfiles<CR>"),
    button("q", "Quit", ":qa<CR>")
  },
  opts = { spacing = 1 }
}

require("alpha").setup({
  layout = {
    { type = "padding", val = header_margin },
    header,
    { type = "padding", val = 2 },
    shortcuts,
    footer
  },
  opts = {
    margin = 8,
    noautocmd = false
  }
})

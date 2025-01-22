local finders       = require "telescope.finders"
local pickers       = require "telescope.pickers"
local entry_display = require "telescope.pickers.entry_display"
local actions       = require "telescope.actions"
local action_state  = require "telescope.actions.state"
local themes        = require "telescope.themes"

local displayer = function(entry)
  entry_display.create({
    separator = ":",
    items = {
      { width = 20 },
      { remaining = true }
    }
  })({
    entry.name,
    { entry.value, "Comment" },
    "EEEEE"
  })
end

local project_entry = function(entry)
  local name = vim.fn.fnamemodify(entry, ":t")

  return {
    name = name,
    value = entry,
    display = displayer,
    ordinal = 1
  }
end

local header_margin = vim.fn.max({
  2, vim.fn.floor(vim.fn.winheight(0) * 0.385)
})

local header = {
  type = "text",
  val = "78 101 111 118 105 109",
  -- val = {
  --   "           ▄ ▄                   ",
  --   "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
  --   "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
  --   "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
  --   "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
  --   "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
  --   "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
  --   "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
  --   "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    "
  -- },

  opts = {
    position = "center",
    hl       = "AlphaHeader"
  }
}

local footer = {
  type = "text",
  val  = "Sent from my iPhone",

  opts = {
    position = "center",
    hl       = "AlphaFooter"
  }
}

local button = function(shortcut, text, action)
  local opts = {
    position       = "center",
    shortcut       = shortcut,
    cursor         = 0,
    width          = 48,
    shrink_margin  = true,
    align_shortcut = "right",
    hl = {
      { "AlphaButtons",     0,  2 },
      { "AlphaHeaderLabel", 2, -1 }
    },
    hl_shortcut = "AlphaShortcut",
    keymap = {
      "n",
      shortcut,
      action,
      {
        noremap = true,
        silent  = true,
        nowait  = true
      }
    }
  }

  local function on_press()
    -- local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    -- vim.api.nvim_feedkeys(keys, "t", false)
    action()
  end

  return {
    type     = "button",
    val      = "* " .. text,
    opts     = opts,
    on_press = on_press
  }
end

local project_button = function()
  -- TODO: Don't hardcode /home/bodby and expand ~.
  if vim.fn.isdirectory "/home/bodby/dev" ~= 0 then
    return button("p", "Projects", function()
      local entries = { }

      for proj, _ in vim.fs.dir("~/dev") do
        table.insert(entries, proj)
      end

      picker = pickers.new({
        prompt_title = "Projects",
        finder = finders.new_table(themes.get_dropdown(), {
          results = entries,
          entry_maker = project_entry,

          attach_mappings = function(_, map)
            actions.select_default:replace(function(bufnr)
              local selection = action_state.get_selected_entry()
              actions.close(bufnr)
              vim.cmd "echo AAAAA"
              vim.fn.chdir(selection.value)
            end)
            return true
          end
        })
      })

      picker:find()
    end)
  end
end

local shortcuts = {
  type = "group",
  val = {
    button("e", "New file", function()
      vim.cmd "enew"
    end),

    button("f", "Find files", function()
      require("telescope.builtin").find_files({
        prompt_title = false
      })
    end),

    button("r", "Recent", function()
      require("telescope.builtin").oldfiles({
        prompt_title = false
      })
    end),

    button("v", "Vault", function()
      require("telescope.builtin").find_files({
        cwd          = "~/vault",
        search_dirs  = { "lists", "notes" },
        prompt_title = false
      })
    end),

    project_button(),

    button("q", "Quit", function()
      vim.cmd "qa"
    end)
  },

  opts = { spacing = 1 }
}

-- I opted to go with Telescope to be able to cd into any directory in ~/dev.
-- It works really nicely for my use case.
-- local projects = function(max_entries)
--   return {
--     type = "group",
--     val = function()
--       local all      = { }
--       local filtered = { }
--
--       for proj in vim.fs.dir("~/dev") do
--         table.insert(all, proj)
--       end
--
--       for i, entry in ipairs(all) do
--         if i > max_entries then break end
--         table.insert(filtered, button(tostring(i), entry, function()
--           vim.cmd("cd " .. vim.fs.joinpath("~/dev/", entry))
--         end))
--       end
--
--       return filtered
--     end,
--
--     opts = { spacing = 1 }
--   }
-- end

require("alpha").setup({
  layout = {
    { type = "padding", val = header_margin },
    header,
    { type = "padding", val = 1 },
    shortcuts,
    -- { type = "padding", val = 1 },
    -- projects(4),
    footer
  },

  opts = {
    margin    = 8,
    noautocmd = false
  }
})

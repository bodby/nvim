local finders       = require "telescope.finders"
local pickers       = require "telescope.pickers"
local entry_display = require "telescope.pickers.entry_display"
local actions       = require "telescope.actions"
local action_state  = require "telescope.actions.state"
local sorters       = require "telescope.sorters"
local strategies    = require "telescope.pickers.layout_strategies"

local displayer = function(entry)
  return entry_display.create({
    separator = "",
    items = {
      { width = 20 },
      { remaining = true }
    }
  })({ entry.name, { entry.value, "Comment" } })
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

strategies.project_picker = function(picker, max_columns, max_lines, layout_config)
  local layout = strategies.vertical(picker, max_columns, max_lines, layout_config)

  layout.prompt.title  = ""
  layout.results.title = ""

  layout.prompt.line = layout.prompt.line + 1

  return layout
end

local title_picker_fix = function(opts)
  return vim.tbl_deep_extend("force", {
    theme           = "project_picker",
    layout_strategy = "project_picker",

    layout_config = {
      height = 0.4,
      width  = 0.4
    }
  }, opts)
end

local project_button = function(project_dir)
  -- TODO: Don't hardcode /home/bodby and expand ~.
  if vim.fn.isdirectory(project_dir) ~= 0 then
    return button("p", "Projects", function()
      local entries = { }

      for proj, _ in vim.fs.dir("~/dev") do
        table.insert(entries, proj)
      end

      pickers.new(title_picker_fix({
        prompt_title  = "",
        preview_title = "",

        sorter = sorters.get_fuzzy_file(),
        finder = finders.new_table({
          results = entries,
          -- FIXME: WHY DOES THIS BREAK?
          -- entry_maker = project_entry
        }),
        attach_mappings = function(_, map)
          map("i", "<CR>", function(bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(bufnr)
            vim.fn.chdir(vim.fs.joinpath("~/dev", selection.value))
            vim.cmd "AlphaRedraw"
          end)

          return true
        end
      })):find()
    end)
  end
end

local vault_button = function()
  if vim.fn.isdirectory "/home/bodby/vault" ~= 0 then
    return button("v", "Vault", function()
      require("telescope.builtin").find_files({
        prompt_title  = "",
        preview_title = "",
        cwd           = "~/vault",
        search_dirs   = { "lists", "notes" }
      })
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
        prompt_title  = "",
        preview_title = ""
      })
    end),

    button("r", "Recent", function()
      require("telescope.builtin").oldfiles({
        prompt_title  = "",
        preview_title = ""
      })
    end),

    vault_button(),

    project_button("/home/bodby/dev"),

    button("q", "Quit", function()
      vim.cmd "qa"
    end)
  },

  opts = { spacing = 1 }
}

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

local current_dir = {
  type = "text",
  val = function()
    return vim.fn.getcwd()
  end,
  opts = {
    position = "center",
    hl       = "AlphaHeaderLabel"
  }
}

require("alpha").setup({
  layout = {
    { type = "padding", val = header_margin },
    header,
    { type = "padding", val = 1 },
    shortcuts,
    current_dir,
    { type = "padding", val = 1 },
    footer
  },

  opts = {
    margin    = 8,
    noautocmd = false
  }
})

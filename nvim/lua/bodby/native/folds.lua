local highlighter = require "vim.treesitter.highlighter"

-- WIP: Will add back Treesitter highlights to the folds with some text decoration afterwards.
--      Also considering adding the range/start and end of the fold.
local M = { }

function M.setup()
  -- NOTE: The value of 'foldtext' is an expression and not a regular string, so I don't need to
  --       prepend '%!v:lua' and can instead use 'v:lua'.
  vim.o.foldtext = "v:lua.require('bodby.native.folds').text()"
end

-- https://github.com/kevinhwang91/nvim-ufo/blob/main/lua/ufo/render/treesitter.lua
local function get_treesitter_hls(buffer, start, last)
  local data = highlighter.active[buffer]
  if not data then
    return { }
  end

  local result = { }

  local row1, col1 = start[1], start[2]
  local row2, col2 = last[1],  last[2]

  --- @param ts_tree TSTree
  --- @param tree LanguageTree
  data.tree:for_each_tree(function(ts_tree, tree)
    if not ts_tree then
      return
    end

    local root = ts_tree:root()
    local start_row, _, end_row, _ = root:range()
    if end_row < row1 or start_row > row2 then
      return
    end

    --- @type Query
    local query = data:get_query(tree:lang())
    if not query:query() then
      return
    end

    local iter = query:query():iter_captures(root, data.bufnr, row1, row2 + 1)
    for capture, node, meta, _ in iter do
      if not capture then
        break
      end

      local highlight = query:get_hl_from_capture(capture)
      local priority  = tonumber(meta) or 100
      local conceal   = meta.conceal

      local row3, col3, row4, col4 = node:range()
      if row1 <= row4 and row2 >= row3 then
        if row3 < row1 or (row3 == row1 and col3 < col1) then
          row3, col3 = row1, col1
        end

        if row4 > row2 or (row4 == row2 and col4 > col2) then
          row4, col4 = row2, col2
        end

        table.insert(result, { row3, col3, row4, col4, highlight, priority, conceal })
      end
    end
  end)

  return result
end

function M.text()
  -- This works fine for the most part. Gets rid of leading whitespace.
  -- TODO: Make this hide 'end_text' if the end of 'foldstart' isn't a matching bracket/brace.
  local end_text = string.gsub(vim.fn.getline(vim.v.foldend), "^%s+", "")

  return {
    { vim.fn.getline(vim.v.foldstart), "Folded" },
    { " ... ", "FoldedDeco" },
    { end_text, "Folded" },
  }
end

local row, col = unpack(vim.api.nvim_win_get_cursor(0))
local buffer = vim.api.nvim_get_current_buf()

local what = get_treesitter_hls(buffer, { row - 1, 0 }, { row - 1, col })

for _, hl in ipairs(what) do
  -- FIXME: Why are all of these empty tables except for punctuation?
  --        If you want to test this, position your cursor at the end of the line you want to
  --        see the highlights of.
  print(vim.inspect(vim.api.nvim_get_hl(0, { id = hl[5], create = true })))
end

return M

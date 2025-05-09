local lib = require('bodby.shared').lib
local mappings = require('bodby.mappings')

local M = {
  template_dir = '/home/bodby/vault/templates',
  note_dir = '/home/bodby/vault/notes/inbox',
  date_format = '%Y-%m-%d',
}

--- @param name string
--- @return string
local function file_name_from(name)
  return name:gsub('%s', '-'):gsub('[^%a-]', ''):lower()
end

--- @param content string[]
--- @param name string
local function open(content, name)
  vim.cmd.enew()
  local buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_text(buffer, 0, 0, 0, 0, content)
  vim.api.nvim_buf_set_name(buffer, vim.fs.joinpath(M.note_dir, name))
  vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buffer })
end

--- @param path string
--- @return string[]?
local function read(path)
  local file = io.open(path, 'r')
  if not file then
    return nil
  end

  local content = file:read('*a')
  file:close()
  return vim.split(content, '\n')
end

--- @param template string
--- @param fields table<string, string>
--- @param name string
--- @return boolean
local function create(template, fields, name)
  local content = read(template)
  if not content then
    return false
  end

  for i, _ in ipairs(content) do
    for k, v in pairs(fields) do
      content[i] = content[i]:gsub(k, v)
    end
  end

  open(content, name .. '.md')
  return true
end

--- @param template string
function M.create_note(template)
  --- @param title? string
  local function with_name(title)
    vim.ui.input({
      prompt = 'Enter note file name: ',
      default = file_name_from(title),
    }, function(name)
      local fields = {
        ['{{date}}'] = os.date(M.date_format),
        ['{{title}}'] = title,
      }
      if not lib.nil_str(title) then
        create(
          vim.fs.joinpath(M.template_dir, template .. '.md'),
          fields,
          name
        )
      end
    end)
  end

  vim.ui.input({
    prompt = 'Enter note title: ',
  }, with_name)
end

--- Set up note creation mappings.
function M.setup()
  -- TODO: Typst document mapping.
  mappings.map('n', '<Leader>nn', lib.with_args(M.create_note, 'note'))
end

return M

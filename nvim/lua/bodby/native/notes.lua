local lib = require('bodby.shared').lib
local mappings = require('bodby.mappings')

local M = {
  template_dir = '/home/bodby/vault/templates',
  note_dir = '/home/bodby/vault/notes/inbox',
  date_format = '%Y-%m-%d',
}

--- Get a usable kebab case file name with no extension from a note title.
--- @param title string
--- @return string
local function file_name_from(title)
  return title:gsub('%s', '-'):gsub('[^%a-]', ''):lower()
end

--- @param name string
--- @return { extension: string, filetype: string }
local function get_extension(name)
  local filetypes = {
    ['md'] = 'markdown',
    ['typ'] = 'typst',
  }

  local ext = name:match('%..*'):sub(2)
  return {
    extension = ext,
    filetype = filetypes[ext] or ext,
  }
end

--- @param content string[]
--- @param name string
--- @param filetype string
local function open(content, name, filetype)
  vim.cmd.enew()
  local buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_text(buffer, 0, 0, 0, 0, content)
  vim.api.nvim_buf_set_name(buffer, vim.fs.joinpath(M.note_dir, name))
  vim.api.nvim_set_option_value('filetype', filetype, { buf = buffer })
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

  local ext = get_extension(template)
  open(content, name .. '.' .. ext.extension, ext.filetype)
  return true
end

--- @param template string
function M.create_note(template)
  --- @param title? string
  local function with_name(title)
    if lib.nil_str(title) then
      return
    end

    vim.ui.input({
      prompt = 'Enter note file name: ',
      default = file_name_from(title),
    }, function(name)
      if not lib.nil_str(name) then
        local fields = {
          ['{{date}}'] = os.date(M.date_format),
          ['{{title}}'] = title,
        }

        local ok =
          create(vim.fs.joinpath(M.template_dir, template), fields, name)
        if not ok then
          vim.notify(
            'Could not find template '
              .. template
              .. ' in '
              .. M.template_dir,
            4
          )
        end
      end
    end)
  end

  vim.ui.input({
    prompt = 'Enter note title: ',
  }, with_name)
end

--- Set up note creation mappings.
function M.setup()
  mappings.map({
    ['n'] = {
      ['<Leader>nn'] = lib.with_args(M.create_note, 'note.md'),
    },
  })
end

return M

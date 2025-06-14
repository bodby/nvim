local lib = require('bodby.shared').lib
local mappings = require('bodby.mappings')

local api = vim.api

local M = {
  template_dir = vim.fs.joinpath(vim.env.HOME, 'vault/templates'),
  default_dir = vim.fs.joinpath(vim.env.HOME, 'vault/inbox'),
  date_format = '%Y-%m-%d',
}

--- Get a usable kebab case file name with no extension from a note title.
--- @param title string
--- @return string
local function file_name_from(title)
  return lib.trim(title):gsub('%s', '-'):gsub('[^%a-]', ''):lower()
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
--- @param root string
local function open(content, name, filetype, root)
  local path = vim.fs.joinpath(root, name)
  vim.cmd.edit(path)

  if not vim.uv.fs_stat(path) then
    local buffer = api.nvim_get_current_buf()
    api.nvim_buf_set_lines(buffer, 0, 1, false, content)
    api.nvim_set_option_value('filetype', filetype, { buf = buffer })
  end
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
  return vim.split(content, '\n', { trimempty = true })
end

--- @param template string
--- @param fields table<string, string>
--- @param name string
--- @param root string
--- @return boolean
local function create(template, fields, name, root)
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
  open(content, name .. '.' .. ext.extension, ext.filetype, root)
  return true
end

--- @param template string
--- @param root? string
function M.create_note(template, root)
  --- @param title? string
  local function with_name(title)
    if lib.nil_str(title) then
      return
    end

    vim.ui.input({
      prompt = 'File name: ',
      default = file_name_from(title),
    }, function(name)
      if not lib.nil_str(name) then
        local fields = {
          ['{{date}}'] = os.date(M.date_format),
          ['{{title}}'] = lib.trim(title),
        }

        local ok = create(
          vim.fs.joinpath(M.template_dir, template),
          fields,
          name,
          root or M.default_dir
        )
        if not ok then
          vim.notify(
            'Could not find template ' .. template .. ' in ' .. M.template_dir,
            4
          )
        end
      end
    end)
  end

  vim.ui.input({
    prompt = 'Title: ',
  }, with_name)
end

--- Set up note creation mappings.
function M.setup()
  mappings.map({
    ['n'] = {
      ['<Leader>nn'] = lib.with_args(M.create_note, 'default.md'),
      ['<Leader>np'] = lib.with_args(
        M.create_note,
        'default.typ',
        vim.fs.joinpath(vim.env.HOME, 'vault/notes/papers')
      ),
    },
  })
end

return M

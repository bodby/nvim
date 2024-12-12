-- Default commentstrings don't have spaces after the comment characters. :(
local filetypes = {
  lua = "-- %s",
  zig = "// %s",
  cpp = "// %s",
  c = "// %s",
  kdl = "// %s",
  rasi = "// %s",
  json = "// %s",
  jsonc = "// %s",
  ocaml = "(* %s *)",
  rust = "// %s",
  html = "<!-- %s -->",
  css = "/* %s */"
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if filetypes[vim.bo.filetype] ~= nil then
      vim.bo.commentstring = filetypes[vim.bo.filetype]
    end
  end
})

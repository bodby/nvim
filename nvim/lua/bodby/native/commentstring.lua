local prefixes = {
  lua = "-- %s",
  zig = "// %s",
  cpp = "// %s",
  c = "// %s",
  kdl = "// %s",
  rasi = "// %s",
  ocaml = "(* %s *)",
  rust = "// %s",
  html = "<!-- %s -->",
  css = "/* %s */"
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if prefixes[vim.bo.filetype] ~= nil then
      vim.bo.commentstring = prefixes[vim.bo.filetype]
    end
  end
})

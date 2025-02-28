-- Default commentstrings don't have spaces after the comment characters. :(
local filetypes = {
  lua     = "-- %s",
  cabal   = "-- %s",
  haskell = "-- %s",
  zig     = "// %s",
  cpp     = "// %s",
  c       = "// %s",
  kdl     = "// %s",
  rasi    = "// %s",
  json    = "// %s",
  jsonc   = "// %s",
  ocaml   = "(* %s *)",
  query   = "; %s",
  bib     = "% %s",
  tex     = "% %s",
  latex   = "% %s",
  rust    = "// %s",
  html    = "<!-- %s -->",
  css     = "/* %s */"
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    local buffer = event.buf
    if filetypes[vim.bo[buffer].filetype] ~= nil then
      vim.bo[buffer].commentstring = filetypes[vim.bo[buffer].filetype]
    end
  end
})

{
  mkShellNoCC,
  luajit,
  lua-language-server,
  stylua,
  nixd,
  nixfmt-rfc-style,
}:
mkShellNoCC {
  name = "nvim";
  packages = [
    luajit
    lua-language-server
    stylua
    nixd
    nixfmt-rfc-style
  ];
}

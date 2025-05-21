{
  mkShellNoCC,
  luajit,
  lua-language-server,
  stylua,
  nixd,
  nixfmt-rfc-style,
  statix,
  nurl,
}:
mkShellNoCC {
  name = "nvim";
  packages = [
    luajit
    lua-language-server
    stylua

    nixd
    nixfmt-rfc-style
    statix
    nurl
  ];
}

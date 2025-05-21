{
  mkShellNoCC,
  luajit,
  lua-language-server,
  stylua,
  nixd,
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
    statix
    nurl
  ];
}

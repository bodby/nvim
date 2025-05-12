{
  mkShellNoCC,
  luajit,
  lua-language-server,
  stylua,
  luajitPackages,
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
    luajitPackages.luacheck
    luajitPackages.busted

    nixd
    statix
    nurl
  ];
}

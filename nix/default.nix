{
  plugins ? [ ],
  packages ? [ ],
  extraLuaPackages ? _: [ ],
  viAlias ? true,
  vimAlias ? true,

  lib,
  neovim-unwrapped,
  symlinkJoin,
  wrapNeovimUnstable,
  neovimUtils,
  ...
}:
let
  inherit (neovim-unwrapped.lua.pkgs) luaLib;
  inherit (lib) fileset optionals;
  runtimepath = symlinkJoin {
    name = "nvim";
    paths = [
      (fileset.toSource {
        root = ../nvim;
        fileset = fileset.difference ../nvim ../nvim/init.lua;
      })
    ];
  };
  packages' = symlinkJoin {
    name = "nvim-packages";
    paths = packages;
  };
  luaPackages = neovim-unwrapped.lua.withPackages extraLuaPackages;
in
wrapNeovimUnstable neovim-unwrapped {
  inherit viAlias vimAlias;

  withPython3 = false;
  withRuby = false;
  withNodeJs = false;
  withPerl = false;

  plugins = neovimUtils.normalizePlugins plugins;
  luaRcContent = /* lua */ ''
    vim.loader.enable()
    vim.o.rtp = '${runtimepath},' .. vim.o.rtp .. ',${runtimepath}/after'
    ${builtins.readFile ../nvim/init.lua}
  '';
  wrapperArgs = optionals (packages != [ ]) [
    "--prefix"
    "PATH"
    ":"
    "${packages'}/bin"
  ]
  ++ optionals (luaPackages != null) [
    "--prefix"
    "LUA_PATH"
    ";"
    (luaLib.genLuaPathAbsStr luaPackages)
    "--prefix"
    "LUA_CPATH"
    ";"
    (luaLib.genLuaCPathAbsStr luaPackages)
  ];
}

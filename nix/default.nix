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
  inherit (lib) fileset optionals;
  inherit (neovim-unwrapped.lua.pkgs.luaLib)
    genLuaPathAbsStr
    genLuaCPathAbsStr
    ;
  runtimepath = symlinkJoin {
    name = "nvim";
    paths = [
      (fileset.toSource {
        root = ../nvim;
        fileset = fileset.difference ../nvim ../nvim/init.lua;
      })
    ];
  };
  luaPackages = neovim-unwrapped.lua.withPackages extraLuaPackages;
  packages' = symlinkJoin {
    name = "nvim-packages";
    paths = packages;
  };
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
    (genLuaPathAbsStr luaPackages)
    "--prefix"
    "LUA_CPATH"
    ";"
    (genLuaCPathAbsStr luaPackages)
  ];
}

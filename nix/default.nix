{
  lib,
  neovim-unwrapped,
  symlinkJoin,
  wrapNeovimUnstable,
  neovimUtils,
  callPackage,
}:
let
  inherit (lib) fileset;
  inherit (neovim-unwrapped.lua.pkgs.luaLib)
    genLuaPathAbsStr
    genLuaCPathAbsStr
    ;

  inherit (callPackage ./plugins.nix { })
    plugins
    packages
    extraLuaPackages
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
  viAlias = true;
  vimAlias = true;

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

  wrapperArgs = lib.optionals (packages != [ ]) [
    "--prefix"
    "PATH"
    ":"
    "${packages'}/bin"
  ]
  ++ lib.optionals (luaPackages != null) [
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

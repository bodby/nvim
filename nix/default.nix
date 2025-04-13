{
  plugins ? [ ],
  packages ? [ ],
  extraLuaPackages ? _: [ ],
  viAlias ? true,
  vimAlias ? true,

  lib,
  neovim-unwrapped,
  stdenvNoCC,
  wrapNeovimUnstable,
  neovimUtils,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (neovim-unwrapped.lua.pkgs) luaLib;
  # TODO: Use buildEnv instead.
  runtimepath = stdenvNoCC.mkDerivation {
    name = "nvim";
    src = ../nvim;
    buildPhase = ''
      mkdir -p "$out"/lua "$out"/after "$out"/snippets "$out"/colors
    '';
    installPhase = ''
      cp -r lua after snippets colors "$out"
    '';
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
    (lib.strings.makeBinPath packages)
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

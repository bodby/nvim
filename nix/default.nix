{
  lib,
  neovim-unwrapped,
  symlinkJoin,
  wrapNeovimUnstable,
  neovimUtils,
  callPackage,
}:
let
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
      (lib.fileset.toSource {
        root = ../nvim;
        fileset = lib.fileset.difference ../nvim ../nvim/init.lua;
      })
    ];
  };

  luaPackages = neovim-unwrapped.lua.withPackages extraLuaPackages;

  wrapper =
    args:
    (wrapNeovimUnstable neovim-unwrapped (
      {
        withPython3 = false;
        withRuby = false;
        withNodeJs = false;
        withPerl = false;

        plugins = neovimUtils.normalizePlugins plugins;
        luaRcContent = # lua
          ''
            vim.loader.enable()
            vim.o.rtp = '${runtimepath},' .. vim.o.rtp .. ',${runtimepath}/after'
            ${builtins.readFile ../nvim/init.lua}
          '';

        wrapperArgs = lib.optionals (luaPackages != null) [
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
      // args
    )).overrideAttrs
      (finalAttrs: {
        runtimeDeps = finalAttrs.runtimeDeps ++ packages;
      });
in
lib.makeOverridable wrapper {
  viAlias = true;
  vimAlias = true;
}

{
  pkgs ?
    let
      lock = (builtins.fromJSON (builtins.readFile ../flake.lock)).nodes.nixpkgs.locked;
      nixpkgs = fetchTarball {
        url = "${lock.url}/archive/${lock.rev}.tar.gz";
        sha256 = lock.narHash;
      };
    in
    import nixpkgs { },
}:
pkgs.callPackage (
  {
    lib,
    neovim-unwrapped,
    wrapNeovimUnstable,
    neovimUtils,
    callPackage,
  }:
  let
    runtimepath = lib.fileset.toSource {
      root = ../nvim;
      fileset = lib.fileset.difference ../nvim ../nvim/init.lua;
    };

    inherit (callPackage ./plugins.nix { })
      plugins
      packages
      luaPackages
      ;

    inherit (neovim-unwrapped) lua;
    luaPackages' = lua.withPackages luaPackages;

    inherit (lua.pkgs.luaLib)
      genLuaPathAbsStr
      genLuaCPathAbsStr
      ;

    wrapper =
      args:
      (wrapNeovimUnstable neovim-unwrapped (
        {
          plugins = neovimUtils.normalizePlugins plugins;
          luaRcContent =
            # lua
            ''
              vim.loader.enable()
              vim.o.rtp = '${runtimepath},' .. vim.o.rtp .. ',${runtimepath}/after'
              ${builtins.readFile ../nvim/init.lua}
            '';

          wrapperArgs = lib.optionals (luaPackages' != null) [
            "--prefix"
            "LUA_PATH"
            ";"
            (genLuaPathAbsStr luaPackages')

            "--prefix"
            "LUA_CPATH"
            ";"
            (genLuaCPathAbsStr luaPackages')
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

    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    withPerl = false;
  }
) { }

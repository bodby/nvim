{ inputs, name, ... }:
final: prev:
let
  pkgs = inputs.nixpkgs.legacyPackages.${final.system};
  nvimPackages = import ./nvim-pkgs.nix { inherit pkgs inputs; };

  mkNeovimConfig =
    with pkgs.lib;
    {
      appName ? null,
      nvim-unwrapped ? pkgs.neovim-unwrapped,
      plugins ? [ ],
      extraPackages ? [ ],
      extraLuaPackages ? p: [ ],
      viAlias ? false,
      vimAlias ? false,
    }:
    let
      # lib
      inherit (pkgs) stdenv;
      # Used by vimUtils.makeNeovimConfig.
      defaultPlugin = {
        plugin = null;
        config = null;
        optional = false;
        runtime = { };
      };

      mappedPlugins = map (x: defaultPlugin // (if x ? plugin then x else { plugin = x; })) plugins;

      nvimConfig = pkgs.neovimUtils.makeNeovimConfig {
        inherit viAlias vimAlias;
        extraPython3Packages = p: [ ];
        withPython3 = false;
        withRuby = false;
        withNodeJs = false;
        plugins = mappedPlugins;
      };

      nvimRtp = stdenv.mkDerivation {
        name = "nvim-rtp";
        src = ../nvim;

        buildPhase = ''
          mkdir -p $out/nvim
          mkdir -p $out/lua
          # ???
          rm init.lua
        '';

        installPhase = ''
          cp -r lua $out/lua
          rm -r lua

          if [ -d "after" ]; then
            cp -r after $out/after
            rm -r after
          fi

          if [ -n "$(ls -A)" ]; then cp -r -- * $out/nvim; fi
        '';
      };

      initLua =
        ''
          vim.loader.enable()
          vim.opt.rtp:prepend "${nvimRtp}/lua"
        ''
        + (builtins.readFile ../nvim/init.lua)
        + ''
          vim.opt.rtp:prepend "${nvimRtp}/nvim"
          vim.opt.rtp:prepend "${nvimRtp}/after"
        '';

      isCustomAppName = appName != null && appName != "nvim" && appName != "";

      # Custom bin name and extra packages (not Lua packages). Passed to `make`.
      extraMakeWrapperArgs =
        (optionalString isCustomAppName ''--set NVIM_APPNAME "${appName}"'')
        + (optionalString (extraPackages != [ ]) ''--suffix PATH ":" "${makeBinPath.extraPackages}"'');

      extraLuaPackages' = extraLuaPackages nvim-unwrapped.lua.pkgs;

      # Lua packages and Lua C packages. Passed to `make`.
      extraLuaWrapperArgs =
        optionalString (extraLuaPackages' != [ ])
          ''--suffix LUA_PATH ";" "${concatMapStringsSep ";" luaPackages.getLuaPath extraLuaPackages'}"'';

      extraLuaCWrapperArgs =
        optionalString (extraLuaPackages' != [ ])
          ''--suffix LUA_CPATH ";" "${concatMapStringsSep ";" luaPackages.getLuaCPath extraLuaPackages'}"'';

      # Where is the wrapNeovimUnstable package?
      nvim-wrapped = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
        nvimConfig
        // {
          luaRcContent = initLua;
          wrapperArgs =
            # I WROTE ARG AND NOT ARGS. AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.
            escapeShellArgs nvimConfig.wrapperArgs
            + " "
            + extraMakeWrapperArgs
            + " "
            + extraLuaCWrapperArgs
            + " "
            + extraLuaWrapperArgs;
          wrapRc = true;
        }
      );
    in
    nvim-wrapped.overrideAttrs (prev: {
      buildPhase =
        prev.buildPhase
        + optionalString isCustomAppName ''
          mv $out/bin/nvim $out/bin/${escapeShellArgs appName}
        '';
      meta.mainProgram = if isCustomAppName then appName else prev.meta.mainProgram;
    });
in
{
  ${name} = mkNeovimConfig {
    plugins = nvimPackages.plugins;
    # extraPackages = nvimPackages.packages;
  };
}

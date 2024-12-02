{ inputs, pkgs, ... }:
final: prev:
let
  nvimPackages = import ./nvim-pkgs.nix {
    inherit pkgs inputs;
    system = final.system;
  };

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
      inherit (pkgs) stdenv;
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
          mkdir -p $out/lua
          mkdir -p $out/colors
        '';

        installPhase = ''
          cp -r lua $out/lua
          cp -r after $out/after
          cp -r colors $out/colors
        '';
      };

      # TODO: Add all parsers to a single "parsers" dir so the runtimepath doesn't become huge.
      initLua =
        ''
          vim.loader.enable()
          vim.opt.rtp:prepend "${nvimRtp}/lua"
          vim.opt.rtp:prepend "${nvimRtp}/colors"
        ''
        + (builtins.readFile ../nvim/init.lua)
        + ''
          vim.opt.rtp:prepend "${nvimRtp}/after"
          vim.opt.rtp:prepend "${concatMapStringsSep "," (p: p + "/bin") nvimPackages.parsers}"
        '';

      isCustomAppName = appName != null && appName != "nvim" && appName != "";

      extraMakeWrapperArgs =
        (optionalString isCustomAppName ''--set NVIM_APPNAME "${appName}"'')
        + (optionalString (extraPackages != [ ]) ''--suffix PATH ":" "${makeBinPath extraPackages}"'');

      extraLuaPackages' = extraLuaPackages nvim-unwrapped.lua.pkgs;

      extraLuaWrapperArgs =
        optionalString (extraLuaPackages' != [ ])
          ''--suffix LUA_PATH ";" "${concatMapStringsSep ";" luaPackages.getLuaPath extraLuaPackages'}"'';

      extraLuaCWrapperArgs =
        optionalString (extraLuaPackages' != [ ])
          ''--suffix LUA_CPATH ";" "${concatMapStringsSep ";" luaPackages.getLuaCPath extraLuaPackages'}"'';

      nvim-wrapped = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
        nvimConfig
        // {
          luaRcContent = initLua;
          wrapperArgs =
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
  nvim-btw = mkNeovimConfig {
    plugins = nvimPackages.plugins;
    extraPackages = nvimPackages.packages;
  };
}

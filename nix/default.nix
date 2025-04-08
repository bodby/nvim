{
  plugins ? [ ],
  packages ? [ ],
  extraLuaPackages ? p: [ ],
  viAlias ? true,
  vimAlias ? true,

  lib,
  neovimUtils,
  neovim-unwrapped,
  stdenvNoCC,
  wrapNeovimUnstable,
  ...
}:
let
  inherit (lib.strings) concatStringsSep optionalString concatMapStringsSep;
  config = neovimUtils.makeNeovimConfig {
    inherit viAlias vimAlias plugins;
    extraPython3Packages = p: [ ];
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
  };
  rtp = stdenvNoCC.mkDerivation {
    name = "nvim";
    src = ../nvim;
    buildPhase = ''
      mkdir -p $out/lua $out/after $out/snippets $out/colors
    '';
    installPhase = ''
      cp -r lua after snippets colors $out
    '';
  };

  luaPackages = neovim-unwrapped.lua.pkgs;
  makeWrapperArgs = concatStringsSep " " [
    (optionalString (packages != [ ])
      "--prefix PATH ':' '${lib.strings.makeBinPath packages}'")
  ];

  luaPath = type: env:
    let path' = concatMapStringsSep ";" type (extraLuaPackages luaPackages); in
    optionalString (extraLuaPackages != [ ]) "--suffix ${env} ';' '${path'}'";

  luaWrapperArgs = luaPath luaPackages.getLuaPath "LUA_PATH";
  luaCWrapperArgs = luaPath luaPackages.getLuaCPath "LUA_CPATH";
in
wrapNeovimUnstable neovim-unwrapped (config // {
  luaRcContent = /* lua */ ''
    vim.loader.enable()
    vim.g.root_path = '${rtp}'
    vim.o.rtp = '${rtp},' .. vim.o.rtp .. ',${rtp}/after'
    ${builtins.readFile ../nvim/init.lua}
  '';
  wrapRc = true;
  wrapperArgs = concatStringsSep " " [
    (lib.strings.escapeShellArgs config.wrapperArgs)
    makeWrapperArgs
    luaCWrapperArgs
    luaWrapperArgs
  ];
})

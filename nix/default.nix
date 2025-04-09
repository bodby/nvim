{
  plugins ? [ ],
  packages ? [ ],
  extraLuaPackages ? _: [ ],
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
  config = neovimUtils.makeNeovimConfig {
    inherit viAlias vimAlias extraLuaPackages;
    plugins = neovimUtils.normalizePlugins plugins;
    extraPython3Packages = _: [ ];
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    withPerl = false;
    luaRcContent = /* lua */ ''
      vim.loader.enable()
      -- FIXME: vim.split(',') instead and use [1]. Remove this after.
      vim.g.root_path = '${rtp}'
      vim.o.rtp = '${rtp},' .. vim.o.rtp .. ',${rtp}/after'
      ${builtins.readFile ../nvim/init.lua}
    '';
  };
  rtp = stdenvNoCC.mkDerivation {
    name = "nvim";
    src = ../nvim;
    buildPhase = ''
      mkdir -p "$out"/lua "$out"/after "$out"/snippets "$out"/colors
    '';
    installPhase = ''
      cp -r lua after snippets colors "$out"
    '';
  };

  # TODO: Append to runtimeDeps? See wrapNeovimUnstable source.
  makeWrapperArgs = lib.lists.optional (packages != [ ]) [
    "--prefix"
    "PATH"
    ":"
    (lib.strings.makeBinPath packages)
  ];
in
wrapNeovimUnstable neovim-unwrapped (config // {
  wrapperArgs = (lib.strings.concatMapStringsSep " " lib.strings.escapeShellArgs [
    config.wrapperArgs
    makeWrapperArgs
  ]);
})
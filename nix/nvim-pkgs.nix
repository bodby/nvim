{
  inputs,
  pkgs,
  system,
  ...
}:

let
  customPkgs = [
    # pkgs.blink-indent
    pkgs.blink-compat
    pkgs.degraded-nvim
    inputs.blink-cmp.packages.${system}.blink-cmp
  ];
in
{
  plugins =
    with pkgs.vimPlugins;
    [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.latex
      telescope-nvim
      # markview-nvim
      obsidian-nvim
      nvim-lspconfig
      nabla-nvim
      telescope-zf-native-nvim
      # material-nvim
      alpha-nvim
      gitsigns-nvim
    ]
    ++ customPkgs;

  packages = with pkgs; [
    ripgrep
    nixd
  ];
}

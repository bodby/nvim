{ inputs, pkgs, ... }:

let
  # Custom plugins not available in nixpkgs.
  customPkgs = [
    # pkgs.blink-indent
    # pkgs.blink-compat
    # pkgs.fine-cmdline
    inputs.blink-cmp.packages.${pkgs.system}.default
  ];
in
{
  plugins =
    with pkgs.vimPlugins;
    [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.latex
      telescope-nvim
      blink-cmp
      markview-nvim
      obsidian-nvim
      nvim-lspconfig
      nabla-nvim
      smartcolumn-nvim
      telescope-zf-native-nvim
      alpha-nvim
      gitsigns-nvim
    ]
    ++ customPkgs;
}

{
  inputs,
  pkgs,
  system,
  ...
}:

let
  # Custom plugins in nix/pkgs/.
  customPkgs = [
    # pkgs.blink-indent
    pkgs.blink-compat
    # pkgs.fine-cmdline
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
      # blink-cmp
      markview-nvim
      obsidian-nvim
      nvim-lspconfig
      nabla-nvim
      telescope-zf-native-nvim
      alpha-nvim
      gitsigns-nvim
    ]
    ++ customPkgs;

  packages = [ pkgs.ripgrep ];
}

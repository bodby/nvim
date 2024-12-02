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
      # nvim-treesitter.withAllGrammars
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

  parsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    lua
    nix
    markdown
    markdown_inline
    latex
    cpp
    c
    ocaml
    rust
    zig
    haskell
  ];

  packages = with pkgs; [
    ripgrep
    nixd
  ];
}

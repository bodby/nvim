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
  # TODO: Commented-out plugins.
  plugins =
    with pkgs.vimPlugins;
    [
      nvim-lspconfig
      (nvim-treesitter.withPlugins (p: with p; [
        comment
        bash
        c
        cpp
        jsonc
        json
        toml
        yaml
        hyprlang
        haskell
        markdown
        markdown_inline
        zig
        lua
        python
        nix
        html
        css
      ]))
      telescope-nvim
      telescope-zf-native-nvim
      # markview-nvim
      render-markdown-nvim
      # nabla-nvim
      # nvim-treesitter-parsers.latex
      # obsidian-nvim
      alpha-nvim
      # material-nvim
      gitsigns-nvim
    ]
    ++ customPkgs;

  packages = with pkgs; [
    ripgrep
    nixd
    ghc
    haskell-language-server
  ];
}

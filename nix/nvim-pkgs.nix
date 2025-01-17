{
  pkgs,
  ...
}:

let
  customPkgs = with pkgs; [
    # blink-indent
    blink-compat
    degraded-nvim
    blink-cmp-spell
    # inputs.blink-cmp.packages.${system}.blink-cmp
  ];
in
{
  # TODO: Configure commented plugins.
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
        rust
        ocaml
        lua
        python
        nix
        html
        css
      ]))
      telescope-nvim
      telescope-zf-native-nvim
      blink-cmp
      # markview-nvim
      render-markdown-nvim
      # nabla-nvim
      # Needed for nabla-nvim.
      # nvim-treesitter-parsers.latex
      # obsidian-nvim
      alpha-nvim
      # material-nvim
      # TODO: Don't need this; I only use it for my statusline.
      gitsigns-nvim
      smartcolumn-nvim
      virt-column-nvim
    ]
    ++ customPkgs;

  # NOTE: Other LSPs should be in devShells.
  packages = with pkgs; [
    ripgrep
    nixd
  ];
}

{
  pkgs,
  ...
}:

let
  customPkgs = with pkgs; [
    # degraded-nvim
    nvim-align
    hlargs-nvim
    # indentmini-nvim
    # blink-cmp-spell
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
        haskell
        markdown
        markdown_inline
        zig
        meson
        rust
        ocaml
        lua
        luadoc
        python
        nix
        html
        css
        javascript
      ]))

      telescope-nvim
      telescope-zf-native-nvim
      blink-cmp
      blink-compat
      render-markdown-nvim
      alpha-nvim

      # nabla-nvim
      # Needed for nabla-nvim.
      # nvim-treesitter-parsers.latex
      # obsidian-nvim

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

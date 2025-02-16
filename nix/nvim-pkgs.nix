{
  pkgs,
  ...
}:

let
  customPkgs = with pkgs; [
    # degraded-nvim
    nvim-align
    # hlargs-nvim
    # indentmini-nvim
    # blink-cmp-spell
  ];
in
{
  # TODO: Obsidian.
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
        # TODO: PR.
        # cabal
        markdown
        markdown_inline
        latex
        glsl
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

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
        # NOTE: Some of these are necessary because nvim-treesitter packages aren't the same as the
        #       ones vendored with Neovim. I had to add 'query' to fix ':InspectTree'.
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
        bibtex
        glsl
        zig
        meson
        rust
        ocaml
        lua
        luadoc
        vim
        vimdoc
        doxygen
        python
        nix
        html
        css
        javascript
        query
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
    # TODO: Should I have this only in a devShell?
    #       Currently in this repo only.
    # lua-language-server
  ];
}

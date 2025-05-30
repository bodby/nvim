{
  callPackage,
  vimPlugins,
  ripgrep,
}:
let
  inherit (builtins) attrValues;
in
{
  packages = [ ripgrep ];
  extraLuaPackages = _: [ ];
  plugins = attrValues {
    inherit (vimPlugins)
      telescope-nvim
      telescope-zf-native-nvim
      blink-cmp
      # alpha-nvim
      gitsigns-nvim
      ;

    parsers = vimPlugins.nvim-treesitter.withPlugins (
      p:
      attrValues {
        inherit (callPackage ./tree-sitter.nix { }) markdown markdown-inline;
        inherit (p)
          comment
          luadoc
          vimdoc
          doxygen
          gitignore
          gitcommit
          git_rebase
          jsonc
          json
          toml
          yaml
          bash
          c
          cpp
          haskell
          # latex
          # bibtex
          typst
          glsl
          zig
          meson
          rust
          lua
          vim
          python
          nix
          html
          css
          javascript
          query
          ;
      }
    );
  };
}

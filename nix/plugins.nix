{
  tree-sitter,
  fetchFromGitHub,
  vimPlugins,
  ripgrep,
  lib,
}:
let
  inherit (builtins) map attrValues;

  grammarWithFeatures = {
    language,
    version,
    src,
    location,
    features,
    ...
  } @ args:
  (tree-sitter.buildGrammar {
    inherit language version src;
    generate = true;
  } // builtins.removeAttrs args [
    "language"
    "location"
    "features"
  ]).overrideAttrs {
    configurePhase = lib.optionalString (location != null) ''
      cd ${location}
    ''
    + ''
      ${lib.concatStringsSep " " (map (x: "${x}=1") features)} tree-sitter generate
    '';
  };

  # No `passthru` for the original grammar packages. :(
  # The above function and below would be shorter if the packages did have `passthru`.
  markdownShared = language: location: {
    inherit language location;
    version = "2025-05-12";
    src = fetchFromGitHub {
      owner = "MDeiml";
      repo = "tree-sitter-markdown";
      rev = "413285231ce8fa8b11e7074bbe265b48aa7277f9";
      hash = "sha256-Oe2iL5b1Cyv+dK0nQYFNLCCOCe+93nojxt6ukH2lEmU=";
    };

    meta = {
      homepage = "https://github.com/MDeiml/tree-sitter-markdown";
    };

    features = [
      "EXTENSION_WIKI_LINK"
      "EXTENSION_TAGS"
    ];
  };
in {
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

    parsers = vimPlugins.nvim-treesitter.withPlugins (p:
      attrValues {
        inherit (p)
          comment
          luadoc
          vimdoc
          doxygen
          jsdoc
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
          ocaml
          lua
          vim
          python
          nix
          html
          css
          javascript
          query
          ;

        markdown = grammarWithFeatures
          (markdownShared "markdown" "tree-sitter-markdown");
        markdown-inline = grammarWithFeatures
          (markdownShared "markdown_inline" "tree-sitter-markdown-inline");
      });
  };
}

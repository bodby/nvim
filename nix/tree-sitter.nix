{
  lib,
  stdenv,
  nodejs,
  tree-sitter,
  fetchFromGitHub,
}:
let
  inherit (builtins) removeAttrs;
  inherit (lib) fix;

  markdownCommon = {
    version = "0.5.0";

    src = fetchFromGitHub {
      owner = "tree-sitter-grammars";
      repo = "tree-sitter-markdown";
      rev = "efb075cbd57ce33f694c2bb264b99cdba0f31789";
      hash = "sha256-Vz5bzIvJ0ZojK61RbU+uV59c5cyLA4M1Vw7H6O8JFrE=";
    };

    env = {
      EXTENSION_WIKI_LINK = true;
      EXTENSION_TAGS = true;
    };

    meta = {
      homepage = "https://github.com/tree-sitter-grammars/tree-sitter-markdown";
      license = lib.licenses.mit;
    };
  };
in
fix (self: {
  buildGrammar =
    {
      language,
      generate ? true,
      ...
    }@args:
    stdenv.mkDerivation (
      {
        pname = "${language}-grammar";

        stripDebugList = [ "parser" ];
        nativeBuildInputs = lib.optionals generate [
          nodejs
          tree-sitter
        ];

	      # TODO: Do I really need to convert these into strings?
        #       I previously merged an `env` arg with this but it seemed unnecessary.
        env = {
          CFLAGS = lib.escapeShellArgs [
            "-Isrc"
            "-O2"
          ];

          CXXFLAGS = lib.escapeShellArgs [
            "-Isrc"
            "-O2"
          ];
        };

        # Use `sourceRoot` if the grammar is in a subdirectory.
        configurePhase = lib.optionalString generate ''
          tree-sitter generate
        '';

        buildPhase = ''
          runHook preBuild
          if [[ -e src/scanner.c ]]; then
            $CC -fPIC -c src/scanner.c -o scanner.o $CFLAGS
          elif [[ -e src/scanner.cc ]]; then
            $CXX -fPIC -c src/scanner.cc -o scanner.o $CXXFLAGS
          fi

          $CC -fPIC -c src/parser.c -o parser.o $CFLAGS
          rm -rf parser
          $CXX -shared -o parser *.o
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir $out
          mv parser $out/
          if [[ -d queries ]]; then
            cp -r queries $out
          fi
          runHook postInstall
        '';

        passthru = {
          inherit language generate;
        };
      }
      // removeAttrs args [ "language" ]
    );

  markdown = self.buildGrammar (
    fix (
      self':
      markdownCommon
      // {
        language = "markdown";
        sourceRoot = "${self'.src.name}/tree-sitter-markdown";
      }
    )
  );

  markdown-inline = self.buildGrammar (
    fix (
      self':
      markdownCommon
      // {
        language = "markdown_inline";
        sourceRoot = "${self'.src.name}/tree-sitter-markdown-inline";
      }
    )
  );
})

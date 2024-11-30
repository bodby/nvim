{
  lib,
  buildVimPlugin,
  fetchFromGitHub,
}:

buildVimPlugin {
  pname = "blink.indent";
  version = "395770f";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.indent";
    rev = "395770f42c43ab97eb9d0c6bd9771e1b3b1af860";
    sha256 = "sha256-5C/ZY9jF7T+ypp5HHndDRI7yV4ZXi0bgPJUeyELq1lg=";
  };

  meta = {
    homepage = "https://github.com/Saghen/blink.indent";
    # Uh oh.
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

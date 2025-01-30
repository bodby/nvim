{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "github-nvim-theme";
  version = "c106c94";

  src = fetchFromGitHub {
    owner = "projekt0n";
    repo = "github-nvim-theme";
    rev = "c106c9472154d6b2c74b74565616b877ae8ed31d";
    sha256 = "sha256-/A4hkKTzjzeoR1SuwwklraAyI8oMkhxrwBBV9xb59PA=";
  };

  meta = {
    homepage = "https://github.com/projekt0n/github-nvim-theme";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "nvim-align";
  version = "8d44743";

  src = fetchFromGitHub {
    owner = "RRethy";
    repo = "nvim-align";
    rev = "8d447436f3a382c1e43532f1568c6e39d945e08d";
    sha256 = "sha256-RQD5ZdrLWWuosHQqR0TPCAN5C8azt0tIQBgnoOpvWu0=";
  };

  meta = {
    homepage = "https://github.com/RRethy/nvim-align";
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

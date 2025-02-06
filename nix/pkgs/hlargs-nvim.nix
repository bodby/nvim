{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "hlargs.nvim";
  version = "a5a7fda";

  src = fetchFromGitHub {
    owner = "m-demare";
    repo = "hlargs.nvim";
    rev = "a5a7fdacc0ac2f7ca9d241e0e059cb85f0e733bc";
    sha256 = "sha256-HIQrwlOP/iQoNpH7ETusb7PMaGKrkOrhHlNdQ+fYeCk=";
  };

  meta = {
    homepage = "https://github.com/m-demare/hlargs.nvim";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

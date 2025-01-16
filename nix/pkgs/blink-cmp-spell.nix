{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "blink-cmp-spell";
  version = "416d8ca";

  src = fetchFromGitHub {
    owner = "ribru17";
    repo = "blink-cmp-spell";
    rev = "416d8ca1bce6d5d16be47c4cee88d9326bf13ca5";
    sha256 = "sha256-Z8sjHCEeEpcbN5bvWTR15iazxUVlRzxrKyBd88AE2F4=";
  };

  meta = {
    homepage = "https://github.com/ribru17/blink-cmp-spell";
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

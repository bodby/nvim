{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "56fbe73";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "56fbe73599af0730b37fd3630d6140678d49c87f";
    sha256 = "sha256-pZoWgkmv+EjMFqxyE7o1UWYpsyGiDWMv1awfHYSd6Kc=";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

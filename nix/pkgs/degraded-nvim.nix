{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "2e3058c";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "2e3058cc04ff6e624fee79df6acddb5b90a2c65f";
    sha256 = "sha256-ZsQykqA/4A7PDGtWFLc0OyQ46PcLnlvCUWwOoS38By8=";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "ede676b";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "ede676b3b104d7d4731c78d47e6db7109e45b3d1";
    sha256 = "sha256-t0UQKxRouE+VIRHCVTE5mFXgeXc/5+EV+aszsDVJ2B0=";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

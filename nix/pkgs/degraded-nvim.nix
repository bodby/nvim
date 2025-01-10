{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "ce1fe5a";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "ce1fe5aeba61715eecb4bbc5807d3720ddfab422";
    sha256 = "sha256-R2yEmG/wA+wueERZTB3NxamNWurGfKXQ40IpCALSYrA=";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

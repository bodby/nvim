{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "70e5a2a";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "70e5a2a0c3d8308a9788b3c7c95f6b08a378ab89";
    sha256 = "sha256-UxU03Tx/VvPIJtIYgFYEa4XCm1aRgIX5/UtPhDYs/nE=";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

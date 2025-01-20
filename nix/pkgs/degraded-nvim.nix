{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "0c2bfa3";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "0c2bfa37af2fd47ae64f6bb41f6bc65019b08b86";
    sha256 = "sha256-ndhe7rGtQgKe4lVFtTCO4AZBV3BifHfViVmip+oytzs=";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

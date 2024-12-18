{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "095e1cc";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "095e1cc36a012f96eca1075f76854ed817fd67d9";
    # sha256 = "";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

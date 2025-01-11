{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "degraded-nvim";
  version = "523cbbd";

  src = fetchFromGitHub {
    owner = "bodby";
    repo = "degraded.nvim";
    rev = "523cbbda94e7fbc10620bf21db33dbcc61ff0aa0";
    sha256 = "sha256-byhhVH6w58L296hRe2KzWvQoFYStBfKCeDPSxymSjlM=";
  };

  meta = {
    homepage = "https://github.com/bodby/degraded.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

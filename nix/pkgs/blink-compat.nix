{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "blink.compat";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.compat";
    rev = "d375d838042dbef34114139839fdda16b2485d63";
    sha256 = "sha256-tFdkIkj8Lq+zBhF7mlh7emfpp0qs8GrinJbFWBJn+uE=";
  };

  meta = {
    homepage = "https://github.com/Saghen/blink.compat";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

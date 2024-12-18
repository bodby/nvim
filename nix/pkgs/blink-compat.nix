{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "blink.compat";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.compat";
    rev = "73249d35c8737b614bed64c2f33277387035f8ec";
    sha256 = "sha256-QW5QG7nqdHdyOodac06Cnq8/WKfbg3YyX/yPh87ENJQ=";
  };

  meta = {
    homepage = "https://github.com/Saghen/blink.compat";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

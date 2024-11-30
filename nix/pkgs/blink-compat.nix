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
    rev = "669a4b0d31a2a3c2ff38959e7885644ea0299e8e";
    sha256 = "sha256-vIv4dxoXiakunYHIr7X4acqjBRWBO/wAgTCZeXYdgx4=";
  };

  meta = {
    homepage = "https://github.com/Saghen/blink.compat";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

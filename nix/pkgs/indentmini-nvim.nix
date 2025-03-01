{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "indentmini.nvim";
  version = "59c2be5";

  src = fetchFromGitHub {
    owner = "nvimdev";
    repo = "indentmini.nvim";
    rev = "59c2be5387e3a3308bb43f07e7e39fde0628bd4d";
    sha256 = "sha256-RtNPlILvlEyIFfDK8NTq8LPZR5vIl6uBxeE3vftUS6g=";
  };

  meta = {
    homepage = "https://github.com/nvimdev/indentmini.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

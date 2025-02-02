{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "indentmini.nvim";
  version = "03c24a3";

  src = fetchFromGitHub {
    owner = "nvimdev";
    repo = "indentmini.nvim";
    rev = "03c24a3e76eb9d65ddbd080aa2bfb6d3d6c85058";
    sha256 = "sha256-qJgB/Ap2SM/vxlZ8F8kIS/AwtzkNPrvC0b30Rw/i8Tc=";
  };

  meta = {
    homepage = "https://github.com/nvimdev/indentmini.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

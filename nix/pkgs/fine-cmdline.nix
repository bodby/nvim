{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "fine-cmdline.nvim";
  version = "aec9efe";

  src = fetchFromGitHub {
    owner = "VonHeikemen";
    repo = "fine-cmdline.nvim";
    rev = "aec9efebf6f4606a5204d49ffa3ce2eeb7e08a3e";
    sha256 = "sha256-SMmOzDhkRBBPCuXXZFUxog6YWRQ2tdlJuJGjYlyNTgk=";
  };

  meta = {
    homepage = "https://github.com/VonHeikemen/fine-cmdline.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bodby ];
    platforms = lib.platforms.all;
  };
}

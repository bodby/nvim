final: prev: {
  blink-indent = prev.callPackage ./blink-indent.nix { };
  blink-compat = prev.callPackage ./blink-compat.nix { };
  fine-cmdline = prev.callPackage ./fine-cmdline.nix { };
  degraded-nvim = prev.callPackage ./degraded-nvim.nix { };
}

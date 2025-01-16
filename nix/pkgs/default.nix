final: prev: with prev; {
  blink-indent = callPackage ./blink-indent.nix { };
  blink-compat = callPackage ./blink-compat.nix { };
  fine-cmdline = callPackage ./fine-cmdline.nix { };
  degraded-nvim = callPackage ./degraded-nvim.nix { };
  blink-cmp-spell = callPackage ./blink-cmp-spell.nix { };
}

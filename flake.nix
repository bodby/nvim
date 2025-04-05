{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forall = fn: nixpkgs.lib.genAttrs systems (system:
        fn nixpkgs.legacyPackages.${system});
      call = file: forall (pkgs: {
        default = pkgs.callPackage file { };
      });
    in {
      packages = forall (pkgs:
        let
          inherit (pkgs) callPackage;
          plugins = callPackage ./nix/plugins.nix { };
        in {
          default = callPackage ./nix/default.nix plugins;
        });
      devShells = call ./nix/shell.nix;
    };
}

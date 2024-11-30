{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Plugins.
    blink-cmp = {
      url = "github:Saghen/blink.cmp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      name = "microwave-nvim";
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      nvim-overlay = import ./nix/nvim-overlay.nix {
        inherit inputs name;
      };
    in
    {
      formatter = nixpkgs.lib.genAttrs systems (
        system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style
      );

      packages = nixpkgs.lib.genAttrs systems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nvim-overlay ];
        };
      in
      {
        default = pkgs.${name};
        nvim = pkgs.${name};
      });

      # This is merged with // in my original flake.
      # Why do I need to merge if there's only one config?
      overlays.default = nvim-overlay;
    };
}

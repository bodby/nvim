{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # blink-cmp.url = "github:Saghen/blink.cmp";
    # blink-cmp.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      formatter = nixpkgs.lib.genAttrs systems (
        system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style
      );

      # TODO: Use mkNeovim function here instead of in package.nix to make customization easier.
      packages = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (import ./nix/pkgs)
              (import ./nix/package.nix { inherit inputs pkgs; })
            ];
          };
        in
        rec {
          default = nvim;
          # FIXME: Don't use an overlay.
          nvim = pkgs.nvim-btw;

          # FIXME: See if 'writeShellApplication' works here instead.
          gui = pkgs.writeShellApplication {
            name = "neovide-btw";
            # FIXME: JB Mono here?
            runtimeInputs = with pkgs; [
              neovide
              nvim-btw
              jetbrains-mono
            ];
            text = ''
              neovide --neovim-bin ${pkgs.nvim-btw}/bin/nvim
            '';
          };
        }
      );
    };
}

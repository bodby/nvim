{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

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
      # TODO: Use 'mkNeovim' here instead of in package.nix to make customization easier.
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

          gui = pkgs.writeShellApplication {
            name = "neovide-btw";
            runtimeInputs = with pkgs; [
              neovide
              nvim-btw
            ];
            # '--no-multigrid'
            text = ''
              neovide --fork --no-tabs --neovim-bin ${pkgs.nvim-btw}/bin/nvim
            '';
          };
        });

      devShells = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (import ./nix/pkgs)
              (import ./nix/package.nix { inherit inputs pkgs; })
            ];
          };
        in {
          default = pkgs.mkShell {
            packages = [ pkgs.lua-language-server ];
            inputsFrom = [ ];
          };
        });
    };
}

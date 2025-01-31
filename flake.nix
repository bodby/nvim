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

          bashScript =
            {
              name,
              content,
              deps,
            }:
            let
              script = (pkgs.writeShellScriptBin name content).overrideAttrs (
                finalAttrs: {
                  buildCommand = "${finalAttrs.buildCommand}\n patchShebangs $out";
                });
            in
            pkgs.symlinkJoin {
              inherit name;
              paths = deps ++ [ script ];
              buildInputs = [ pkgs.makeWrapper ];
              postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
            };

        in
        rec {
          default = nvim;
          nvim = pkgs.nvim-btw;

          gui = bashScript {
            name = "neovide";
            content = ''
              neovide --neovim-bin ${pkgs.nvim-btw}
            '';
            deps = with pkgs; [
              neovide
              nvim-btw
            ];
          };
        }
      );
    };
}

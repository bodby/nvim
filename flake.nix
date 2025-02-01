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
              text,
              paths,
            }:
            let
              paths' = paths ++ [ (pkgs.writeShellScriptBin name text) ];
            in
            pkgs.symlinkJoin {
              inherit name;
              paths = paths';
              buildInputs = [ pkgs.makeWrapper ];
              postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
            };

        in
        rec {
          default = nvim;
          # FIXME: Don't use an overlay.
          nvim = pkgs.nvim-btw;

          gui = bashScript {
            name = "neovide-btw";
            text = ''
              ${pkgs.neovide}/bin/neovide --neovim-bin ${pkgs.nvim-btw}
            '';
            # FIXME: JB Mono works here?
            paths = with pkgs; [
              neovide
              nvim-btw
              jetbrains-mono
            ];
          };
        }
      );
    };
}

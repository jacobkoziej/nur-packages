{
  description = "Jacob Koziej's Nix User Repository";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs:

    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      imports = [
        ./dev-shells.nix
      ];

      flake = {
        overlays = {
          default = import ./overlay.nix;
          pkgs = import ./pkgs;
        };
      };

      perSystem =
        {
          pkgs,
          system,
          ...
        }:

        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;

            overlays = [
              (import ./overlay.nix)
            ];
          };

          legacyPackages = import ./pkgs pkgs pkgs;

          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}

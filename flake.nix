{
  description = "Jacob Koziej's Nix User Repository";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs:

    inputs.flake-utils.lib.eachDefaultSystem (
      system:

      let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };

        default = import ./default.nix { inherit pkgs; };

      in
      {
        inherit default;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            mdformat
            shfmt
            toml-sort
            treefmt2
          ];
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}

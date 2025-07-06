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

        lib = pkgs.lib;

        default = import ./default.nix { inherit pkgs; };

      in
      {
        devShells.default = pkgs.mkShell (
          let
            pre-commit-bin = lib.getExe pkgs.pre-commit;

          in
          {
            packages = with pkgs; [
              commitlint-rs
              mdformat
              shfmt
              toml-sort
              treefmt
              yamlfmt
            ];

            shellHook = ''
              ${pre-commit-bin} install --allow-missing-config > /dev/null
            '';
          }
        );

        formatter = pkgs.nixfmt-rfc-style;

        legacyPackages = default.pkgs;
      }
    );
}

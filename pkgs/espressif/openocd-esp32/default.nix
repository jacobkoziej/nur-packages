{
  pkgs,
  version ? "0.12.0-esp32-20241016",
  system ? "linux-amd64",
}:

let
  base = import ./base.nix;
  sha256 = import ./sha256.nix;

  openocd-esp32 = base rec {
    inherit version;
    inherit system;
    hash = sha256.${version}.${system};
  };

in
pkgs.callPackage openocd-esp32 { }

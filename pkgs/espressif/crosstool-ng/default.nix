{
  pkgs,
  lib,
  version ? "14.2.0_20240906",
}:

let
  base = import ./base.nix;
  sha256 = import ./sha256.nix;
  system = builtins.currentSystem;

  xtensa-esp-elf = base rec {
    pname = "xtensa-esp-elf";
    inherit version;
    hash = sha256.${version}.${pname}.${system};
  };

in
lib.attrsets.recurseIntoAttrs {
  xtensa-esp-elf = pkgs.callPackage xtensa-esp-elf { };
}

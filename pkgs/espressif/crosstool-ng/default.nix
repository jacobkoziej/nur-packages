{
  pkgs,
  lib,
  version ? "14.2.0_20240906",
  homepage ? "https://github.com/espressif/crosstool-NG",
  release-prefix ? "releases/download/esp-",
  description ? "Crosstool-NG with support for Xtensa",
  fhs-pkgs ? (
    pkgs: with pkgs; [
      zlib
      zstd
    ]
  ),
}:

let
  base = import ../base.nix;
  sha256 = import ./sha256.nix;
  system = builtins.currentSystem;

  xtensa-esp-elf = base rec {
    pname = "xtensa-esp-elf";
    inherit version;
    inherit homepage;
    inherit release-prefix;
    inherit description;
    hash = sha256.${version}.${pname}.${system};
    inherit fhs-pkgs;
  };

in
lib.attrsets.recurseIntoAttrs {
  xtensa-esp-elf = pkgs.callPackage xtensa-esp-elf { };
}

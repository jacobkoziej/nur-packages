{
  pkgs,
  version ? "14.2_20240403",
  homepage ? "https://github.com/espressif/binutils-gdb",
  release-prefix ? "releases/download/esp-gdb-v",
  description ? "Unofficial mirror of sourceware binutils-gdb repository",
  fhs-pkgs ? (
    pkgs: with pkgs; [
      python39
      python310
      python311
      python312
    ]
  ),
}:

let
  base = import ../base.nix;
  sha256 = import ./sha256.nix;
  system = builtins.currentSystem;

  xtensa-esp-elf-gdb = base rec {
    pname = "xtensa-esp-elf-gdb";
    inherit version;
    inherit homepage;
    inherit release-prefix;
    inherit description;
    hash = sha256.${version}.${pname}.${system};
    inherit fhs-pkgs;
  };

in
{
  xtensa-esp-elf-gdb = pkgs.callPackage xtensa-esp-elf-gdb { };
}

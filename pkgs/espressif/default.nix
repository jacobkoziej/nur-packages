{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  binutils-esp32ulp = import ./binutils-esp32ulp { inherit pkgs; };
  binutils-gdb = import ./binutils-gdb { inherit pkgs; };
  crosstool-ng = import ./crosstool-ng { inherit pkgs; };
  esp-coredump = pkgs.callPackage ./esp-coredump.nix { };
  esp-idf-kconfig = pkgs.callPackage ./esp-idf-kconfig.nix { };
  idf-component-manager = pkgs.callPackage ./idf-component-manager.nix { };
  openocd-esp32 = import ./openocd-esp32 { inherit pkgs; };
}

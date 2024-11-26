{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  binutils-gdb = import ./binutils-gdb { inherit pkgs; };
  crosstool-ng = import ./crosstool-ng { inherit pkgs; };
  openocd-esp32 = import ./openocd-esp32 { inherit pkgs; };
}

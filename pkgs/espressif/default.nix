{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  binutils-gdb = import ./binutils-gdb { inherit pkgs lib; };
  crosstool-ng = import ./crosstool-ng { inherit pkgs lib; };
  openocd-esp32 = import ./openocd-esp32 { inherit pkgs; };
}

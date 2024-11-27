{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  binutils-esp32ulp = import ./binutils-esp32ulp { inherit pkgs; };
  binutils-gdb = import ./binutils-gdb { inherit pkgs; };
  crosstool-ng = import ./crosstool-ng { inherit pkgs; };
  openocd-esp32 = import ./openocd-esp32 { inherit pkgs; };
}

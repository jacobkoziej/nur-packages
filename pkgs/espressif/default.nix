{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  binutils-gdb = import ./binutils-gdb { inherit pkgs lib; };
  crosstool-ng = import ./crosstool-ng { inherit pkgs lib; };
}

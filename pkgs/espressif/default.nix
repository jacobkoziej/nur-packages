{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  crosstool-ng = import ./crosstool-ng { inherit pkgs lib; };
}

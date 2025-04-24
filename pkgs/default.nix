{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  espressif = import ./espressif { inherit pkgs lib; };
  raspberry-pi = import ./raspberry-pi { inherit pkgs lib; };
}

{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  analog-devices = import ./analog-devices { inherit pkgs lib; };
  espressif = import ./espressif { inherit pkgs lib; };
  raspberry-pi = import ./raspberry-pi { inherit pkgs lib; };
}

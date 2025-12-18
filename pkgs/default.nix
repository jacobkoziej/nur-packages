{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  analog-devices = import ./analog-devices { inherit pkgs lib; };
  raspberry-pi = import ./raspberry-pi { inherit pkgs lib; };
}

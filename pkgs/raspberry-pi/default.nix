{
  pkgs,
  lib,
}:

lib.attrsets.recurseIntoAttrs {
  openocd = import ./openocd { inherit pkgs; };
}

{
  pkgs,
  lib,
}:

lib.attrsets.recurseIntoAttrs {
  scopy = pkgs.callPackage ./scopy { };
}

{ pkgs, lib }:

lib.attrsets.recurseIntoAttrs {
  espressif = import ./espressif { inherit pkgs lib; };
}

# concatMapAttrs to get parent name
# filterAttrsRecursive
# foldAttrs
# mapAttrs' <- you can set the prefix to be the current set name

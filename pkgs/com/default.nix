{
  pkgs,
  ...
}:

let
  inherit (pkgs) lib;

  inherit (lib.attrsets) recurseIntoAttrs;

in
recurseIntoAttrs {
  github = import ./github { inherit pkgs; };
}

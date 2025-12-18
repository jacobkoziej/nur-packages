{
  pkgs,
  ...
}:

let
  inherit (pkgs) callPackage;

in
{
  scopy = callPackage ./scopy { };
}

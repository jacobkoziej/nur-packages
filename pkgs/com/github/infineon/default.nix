{
  pkgs,
  ...
}:

let
  inherit (pkgs) callPackage;

in
{
  openocd = callPackage ./openocd { };
}

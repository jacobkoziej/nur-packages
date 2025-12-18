{
  pkgs,
  ...
}:

let
  inherit (pkgs) callPackage;

in
{
  ti-openocd = callPackage ./ti-openocd { };
}

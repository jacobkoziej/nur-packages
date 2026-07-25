{
  pkgs,
  ...
}:

let
  inherit (pkgs) ocamlPackages;

in
{
  herdtools7 = ocamlPackages.callPackage ./herdtools7 { };
}

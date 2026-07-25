final: prev:

let
  inherit (prev) lib;

  inherit (lib) hasPrefix;
  inherit (lib) mapAttrs;
  inherit (lib) recurseIntoAttrs;

  ocamlPackagesOverlay = oself: osuper: {
    herdtools7 = oself.callPackage ../pkgs/com/github/herd/herdtools7 { };
  };

in
{
  ocaml-ng =
    prev.ocaml-ng
    // mapAttrs (
      name: value:
      if hasPrefix "ocamlPackages" name && value ? overrideScope then
        value.overrideScope ocamlPackagesOverlay
      else
        value
    ) prev.ocaml-ng;

  ocamlPackages = recurseIntoAttrs final.ocaml-ng.ocamlPackages;
  ocamlPackages_latest = recurseIntoAttrs final.ocaml-ng.ocamlPackages_latest;
}

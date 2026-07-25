final: prev:

let
  inherit (prev.lib) composeManyExtensions;

  overlays = [
    (import ./ocaml.nix)
    (import ./packages.nix)
  ];

in
composeManyExtensions overlays final prev

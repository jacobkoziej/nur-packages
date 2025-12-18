{
  pkgs,
  ...
}:

let
  inherit (pkgs) lib;

  inherit (lib.attrsets) recurseIntoAttrs;

in
recurseIntoAttrs {
  analogdevicesinc = import ./analogdevicesinc { inherit pkgs; };
  raspberrypi = import ./raspberrypi { inherit pkgs; };
}

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
  infineon = import ./infineon { inherit pkgs; };
  openocd-org = import ./openocd-org { inherit pkgs; };
  raspberrypi = import ./raspberrypi { inherit pkgs; };
  texasinstruments = import ./texasinstruments { inherit pkgs; };
  tmux = import ./tmux { inherit pkgs; };
}

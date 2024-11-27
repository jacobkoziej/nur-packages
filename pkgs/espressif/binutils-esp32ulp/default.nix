{
  pkgs,
  version ? "2.28.51-esp-20191205",
  system ? "linux-amd64",
}:

let
  base = import ./base.nix;
  sha256 = import ./sha256.nix;

  esp32ulp = base rec {
    pname = "esp32ulp";
    inherit version;
    inherit system;
    hash = sha256.${version}.${pname}.${system};
  };

in
{
  esp32ulp = pkgs.callPackage esp32ulp { };
}

{
  version,
  system,
  hash,
}:

{
  stdenv,
  lib,
  buildFHSUserEnv,
  fetchurl,
  makeWrapper,
}:

let
  pname = "openocd-esp32";

  homepage = "https://github.com/espressif/openocd-esp32";

  env = buildFHSUserEnv {
    name = "${pname}-env";
    inherit version;
    targetPkgs =
      pkgs: with pkgs; [
        libusb1
        libz
        udev
      ];
    runScript = "";
  };

in
stdenv.mkDerivation rec {
  inherit pname;
  inherit version;

  src = fetchurl {
    url = "${homepage}/releases/download/v${version}/${pname}-${system}-${version}.tar.gz";
    inherit hash;
  };

  buildInputs = [ makeWrapper ];

  phases = [
    "unpackPhase"
    "installPhase"
  ];

  installPhase = ''
    cp -r . $out

    mv "$out/bin" "$out/bin-unwrapped"
    mkdir "$out/bin"

    makeWrapper "${env}/bin/${env.name}" "$out/bin/$pname" --add-flags "$out/bin-unwrapped/openocd"
  '';

  meta = with lib; {
    description = "OpenOCD branch with ESP32 JTAG support";
    inherit homepage;
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ jacobkoziej ];
    platforms = [
      "x86_64-linux"
    ];
  };
}

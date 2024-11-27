{
  pname,
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
  homepage = "https://github.com/espressif/binutils-esp32ulp";

  env = buildFHSUserEnv {
    name = "${pname}-env";
    inherit version;
    targetPkgs = pkgs: [ ];
    runScript = "";
  };

in
stdenv.mkDerivation rec {
  inherit pname;
  inherit version;

  src = fetchurl {
    url = "${homepage}/releases/download/v${version}/binutils-${pname}-${system}-${version}.tar.gz";
    inherit hash;
  };

  buildInputs = [ makeWrapper ];

  phases = [
    "unpackPhase"
    "installPhase"
  ];

  installPhase = ''
    cp -r . $out

    bin_path="$out/bin"
    bin_unwrapped_path="$out/bin-unwrapped"

    mv "$bin_path" "$bin_unwrapped_path"
    mkdir "$bin_path"

    for file in "$bin_unwrapped_path/"*; do
      [[ -x "$file" ]] || continue

      program="$(basename "$file")"

      makeWrapper "${env}/bin/${env.name}" "$bin_path/$program" --add-flags "$file"
    done
  '';

  meta = with lib; {
    description = "Binutils fork with support for the ESP32 ULP co-processor";
    inherit homepage;
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ jacobkoziej ];
    platforms = [
      "x86_64-linux"
    ];
  };
}

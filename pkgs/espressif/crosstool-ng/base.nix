{
  pname,
  version,
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
  env = buildFHSUserEnv {
    name = "${pname}-env";
    inherit version;
    targetPkgs =
      pkgs: with pkgs; [
        zlib
        zstd
      ];
    runScript = "";
  };

in
stdenv.mkDerivation rec {
  inherit pname;
  inherit version;

  src = fetchurl {
    url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/${pname}-${version}-${builtins.currentSystem}-gnu.tar.gz";
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
    description = "Crosstool-NG with support for Xtensa";
    homepage = "https://github.com/espressif/crosstool-NG";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ jacobkoziej ];
    platforms = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}

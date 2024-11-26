{
  pname,
  version,
  homepage,
  release-prefix,
  description,
  hash,
  fhs-pkgs,
}:

{
  stdenv,
  lib,
  buildFHSUserEnv,
  fetchurl,
  makeWrapper,
}:

let
  currentSystem = builtins.currentSystem;

  env = buildFHSUserEnv {
    name = "${pname}-env";
    inherit version;
    targetPkgs = fhs-pkgs;
    runScript = "";
  };

in
stdenv.mkDerivation rec {
  inherit pname;
  inherit version;

  src = fetchurl {
    url = "${homepage}/${release-prefix}${version}/${pname}-${version}-${currentSystem}-gnu.tar.gz";
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
    inherit description;
    inherit homepage;
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ jacobkoziej ];
    platforms = [
      "x86_64-linux"
    ];
  };
}

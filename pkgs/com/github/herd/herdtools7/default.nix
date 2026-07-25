{
  buildDunePackage,
  fetchFromGitHub,
  fetchurl,
  lib,
  menhir,
  menhirLib,
  python3,
  qcheck,
  which,
  zarith,
}:

let
  armIsaA64Xml = fetchurl {
    url = "https://developer.arm.com/-/media/developer/products/architecture/armv9-a-architecture/2023-09/ISA_A64_xml_A_profile-2023-09.tar.gz";
    hash = "sha256-fyCSoUFvofi3hOlvvHzdZ7LOgfhEJpaCeWlPlvGxFZY=";
  };

in
buildDunePackage (finalAttrs: {
  pname = "herdtools7";
  version = "7.58";

  src = fetchFromGitHub {
    owner = "herd";
    repo = "herdtools7";
    tag = finalAttrs.version;
    hash = "sha256-0+tyzuEPji/mCsN6ez4C+iJz5IroV3zAjVsbgG6lPJo=";
  };

  minimalOCamlVersion = "4.08";

  nativeBuildInputs = [
    menhir
    which
  ];

  buildInputs = [
    menhirLib
    zarith
  ];

  postPatch = ''
    substituteInPlace asllib/tests/check-no-missing-file-in-run.sh \
      --replace-fail 'git ls-files HEAD "$d*.asl"' 'find "$d" -maxdepth 1 -name "*.asl" -printf "%P\n"' \
      ;

    patchShebangs asllib/tests/check-no-missing-file-in-run.sh
  '';

  makeFlags = [
    "PREFIX=${placeholder "out"}"
  ];

  buildPhase = ''
    runHook preBuild
    make just-build $makeFlags
    runHook postBuild
  '';

  doCheck = true;

  nativeCheckInputs = [
    python3
    qcheck
  ];

  preCheck = ''
    cp -v ${armIsaA64Xml} \
      herd/libdir/asl-pseudocode/ISA_A64_xml_A_profile-2023-09.tar.gz
  '';

  checkPhase = ''
    runHook preCheck
    make test $makeFlags
    runHook postCheck
  '';

  postCheck = ''
    make -C herd/libdir/asl-pseudocode clean
    rm -f herd/libdir/asl-pseudocode/notice.html
  '';

  postInstall = ''
    mkdir -p $out/share/herdtools7
    cp -r herd/libdir $out/share/herdtools7/herd
    cp -r litmus/libdir $out/share/herdtools7/litmus
    cp -r jingle/libdir $out/share/herdtools7/jingle
  '';

  meta = with lib; {
    homepage = "http://diy.inria.fr/";
    description = "Tools to design and test weak memory models";
    license = with licenses; [
      bsd3
      cecill-b
      isc
    ];
    platforms = platforms.unix;
    maintainers = with maintainers; [
      jacobkoziej
    ];
    mainProgram = "herd7";
  };
})

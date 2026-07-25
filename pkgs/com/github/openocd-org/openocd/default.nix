{
  autoconf,
  automake,
  fetchFromGitHub,
  lib,
  libtool,
  openocd,
  which,

  enableFtdi ? true,
  extraHardwareSupport ? [ ],
}:

let
  rev = "fc566d74005a4aefbe125b9b2f777d9514c60c87";

in
(openocd.overrideAttrs (previousAttrs: {
  version = rev;

  src = fetchFromGitHub {
    owner = "openocd-org";
    repo = "openocd";
    inherit rev;
    hash = "sha256-fo6R9TPLZMfMPctbwSzjTUQk9WdBRg6c5xIOFcrSURk=";
  };

  patches = [
    ./src-rev.patch
  ];

  postPatch = ''
    substituteInPlace src/Makefile.am \
      --replace-fail '@RELSTR@' '-${rev}' \
      --replace-fail '@GITVERSION@' '${rev}' \
      ;
  '';

  nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [
    autoconf
    automake
    libtool
    which
  ];

  preConfigure = ''
    SKIP_SUBMODULE=1 ./bootstrap
  '';

  meta = with lib; {
    mainProgram = "openocd";
    maintainers =
      previousAttrs.meta.maintainers
      ++ (with maintainers; [
        jacobkoziej
      ]);
  };
})).override
  {
    inherit enableFtdi;
    inherit extraHardwareSupport;
  }

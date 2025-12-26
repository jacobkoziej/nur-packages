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
  rev = "e440b0648fd5a9ced8b3a05ff1a73b17c00cd144";

in
(openocd.overrideAttrs (previousAttrs: {
  version = rev;

  src = fetchFromGitHub {
    owner = "openocd-org";
    repo = "openocd";
    inherit rev;
    hash = "sha256-0DcEQv2ZBs61d4xlT5iI1i4tTyIVJah5aw3Ke1Zz34c=";
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

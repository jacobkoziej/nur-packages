{
  autoconf,
  automake,
  fetchFromGitHub,
  lib,
  libtool,
  openocd,
  which,

  srcOverride ? null,
  enableFtdi ? true,
  extraHardwareSupport ? [ ],
}:

let
  inherit (lib.strings) optionalString;

  defaultSrc = fetchFromGitHub {
    owner = "openocd-org";
    repo = "openocd";
    rev = "e440b0648fd5a9ced8b3a05ff1a73b17c00cd144";
    hash = "sha256-0DcEQv2ZBs61d4xlT5iI1i4tTyIVJah5aw3Ke1Zz34c=";
  };

  src = if srcOverride != null then srcOverride else defaultSrc;

  rev = src.rev or "";

in
(openocd.overrideAttrs (previousAttrs: {
  version = previousAttrs.version + optionalString (rev != "") "-${rev}";

  inherit src;

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

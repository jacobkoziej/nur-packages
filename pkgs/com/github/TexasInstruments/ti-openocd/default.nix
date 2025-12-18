{
  autoconf,
  automake,
  fetchFromGitHub,
  lib,
  libtool,
  openocd,
  which,
  ...
}:

let
  version = "1.1.1";

in
openocd.overrideAttrs (previousAttrs: {
  inherit version;

  src = fetchFromGitHub {
    owner = "TexasInstruments";
    repo = "ti-openocd";
    tag = "ti-v${version}";
    hash = "sha256-Sfwvw0Ybwz7E79B/0QiPjidNg07xgpxfHsd9jf1qwfU=";
  };

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
    maintainers = with maintainters; [
      jacobkoziej
    ];
  };
})

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

openocd.overrideAttrs (previousAttrs: {
  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "openocd";
    rev = "cd4873400c881ce3019c74620afb19e964a1f235";
    hash = "sha256-lQugY+dUdvfFGGj1Sf0a5KzOzHJhdQfhyE/xFxx5Ouc=";
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

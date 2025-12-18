{
  autoconf,
  automake,
  fetchzip,
  lib,
  libtool,
  openocd,
  which,
  ...
}:

let
  version = "5.11";

in
openocd.overrideAttrs (previousAttrs: {
  inherit version;

  src = fetchzip {
    url = "https://www.infineon.com/row/public/documents/30/96/infineon-openocd-src-${version}.zip-software-en.zip";
    hash = "sha256-mi+6C18u2B5YhzXe6mNDCvJ06g/lmUtQVntWgwvFtKc=";
  };

  nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [
    autoconf
    automake
    libtool
    which
  ];

  postUnpack = ''
    chmod +x $sourceRoot/bootstrap
    chmod +x $sourceRoot/src/helper/bin2char.sh
  '';

  preConfigure = ''
    SKIP_SUBMODULE=1 ./bootstrap
  '';

  meta = with lib; {
    maintainers = with maintainters; [
      jacobkoziej
    ];
  };
})

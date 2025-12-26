{
  fetchzip,
  openocd-nightly,
}:

let
  version = "5.11";
  rev = "refs/tags/release-v${version}.0";

in
openocd-nightly.overrideAttrs (previousAttrs: {
  inherit version;

  src = fetchzip {
    url = "https://www.infineon.com/row/public/documents/30/96/infineon-openocd-src-${version}.zip-software-en.zip";
    hash = "sha256-mi+6C18u2B5YhzXe6mNDCvJ06g/lmUtQVntWgwvFtKc=";
  };

  patches = [
    ./add-rev.patch
  ];

  postPatch = ''
    substituteInPlace configure.ac \
      --replace-fail '@REV@' '${rev}' \
      ;
  '';

  postUnpack = ''
    chmod +x $sourceRoot/bootstrap
    chmod +x $sourceRoot/src/helper/bin2char.sh
  '';
})

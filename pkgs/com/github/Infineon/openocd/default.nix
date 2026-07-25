{
  fetchzip,
  openocd-nightly,
}:

let
  version = "5.16.1";
  rev = "refs/tags/release-v${version}";

in
openocd-nightly.overrideAttrs (previousAttrs: {
  inherit version;

  src = fetchzip {
    url = "https://www.infineon.com/row/public/documents/30/96/infineon-openocd-src-${version}-software-en.zip";
    hash = "sha256-fZSfTpgFx02ObApYwOmCle8F4g3/vA0BAhYcGN/q1Xw=";
    curlOpts = "--user-agent 'Mozilla/5.0'";
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
    find $sourceRoot -type f -exec sed -i 's/\r$//' {} +
  '';
})

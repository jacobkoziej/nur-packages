{
  fetchFromGitHub,
  openocd-nightly,
}:

let
  version = "1.1.1";
  tag = "ti-v${version}";

in
openocd-nightly.overrideAttrs (previousAttrs: {
  pname = "ti-openocd";
  inherit version;

  src = fetchFromGitHub {
    owner = "TexasInstruments";
    repo = "ti-openocd";
    inherit tag;
    hash = "sha256-Sfwvw0Ybwz7E79B/0QiPjidNg07xgpxfHsd9jf1qwfU=";
  };

  patches = [
    ./src-rev.patch
  ];

  postPatch = ''
    substituteInPlace src/Makefile.am \
      --replace-fail '@RELSTR@' '-refs/tags/${tag}' \
      --replace-fail '@GITVERSION@' 'refs/tags/${tag}' \
      ;
  '';
})

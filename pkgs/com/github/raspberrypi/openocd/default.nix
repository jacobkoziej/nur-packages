{
  fetchFromGitHub,
  openocd-nightly,
}:

let
  rev = "cd4873400c881ce3019c74620afb19e964a1f235";

in
openocd-nightly.overrideAttrs (previousAttrs: {
  version = rev;

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "openocd";
    inherit rev;
    hash = "sha256-lQugY+dUdvfFGGj1Sf0a5KzOzHJhdQfhyE/xFxx5Ouc=";
  };

  postPatch = ''
    substituteInPlace src/Makefile.am \
      --replace-fail '@RELSTR@' '-${rev}' \
      --replace-fail '@GITVERSION@' '${rev}' \
      ;
  '';
})

{
  pkgs,
}:

let
  inherit (pkgs) fetchFromGitHub;

in
pkgs.openocd.overrideAttrs (previousAttrs: {
  src = pkgs.fetchFromGitHub {
    owner = "raspberrypi";
    repo = "openocd";
    rev = "cf9c0b41cd5c45b2faf01b4fd1186f160342b7b7";
    hash = "sha256-Wqv9zGwyYgSk/5WqPYXnVWM+TQDJa9iqBQ3ev+o8aiA=";
  };

  nativeBuildInputs =
    previousAttrs.nativeBuildInputs
    ++ (with pkgs; [
      autoconf
      automake
      libtool
      which
    ]);

  preConfigure = ''
    SKIP_SUBMODULE=1 $src/bootstrap
  '';
})

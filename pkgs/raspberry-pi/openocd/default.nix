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
    hash = "sha256-gfwi4p0B//kaphBpOJKK2/0nzfsmAmfao4hhtIPlCH0=";
    fetchSubmodules = true;
    leaveDotGit = true;
  };

  nativeBuildInputs =
    previousAttrs.nativeBuildInputs
    ++ (with pkgs; [
      autoconf
      automake
      git
      libtool
      which
    ]);

  preConfigure = ''
    $src/bootstrap
  '';
})

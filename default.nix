{
  pkgs ? import <nixpkgs> { },
}:

{
  pkgs = import ./pkgs pkgs pkgs;
}

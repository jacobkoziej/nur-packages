{ pkgs }:

let
  lib = pkgs.lib;

in
{
  pkgs = import ./pkgs { inherit pkgs lib; };
}

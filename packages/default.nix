{
  pkgs,
  lib,
}:
lib.mapAttrs
(name: _: pkgs.callPackage (./by-name + "/${name}") {})
(builtins.readDir ./by-name)

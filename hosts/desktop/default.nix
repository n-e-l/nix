{ pkgs, lib, ... }: {
  imports = [
    ./configuration.nix
    ./driver
  ];
}

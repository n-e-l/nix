{ pkgs, lib, nixos-apple-silicon, home-manager, stylix, ... }@inputs: {
  imports = [
    nixos-apple-silicon.nixosModules.apple-silicon-support
    ./configuration.nix
    home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lauda = import ../../home/lauda-macbook/home.nix;
  home-manager.extraSpecialArgs = { inherit stylix; };
}

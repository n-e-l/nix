{ pkgs, lib, home-manager, stylix, ... }: {
  imports = [
    ./configuration.nix
    ./driver
    home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lauda = import ../../home/home.nix;
  home-manager.extraSpecialArgs = { inherit stylix; };
}

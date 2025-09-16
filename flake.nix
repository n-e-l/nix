{
  description = "Nel's NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home-manager setup
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix.url = "github:nix-community/stylix/release-25.05";
  };

  outputs = { 
    nixpkgs, 
    home-manager,  
    stylix, 
    ... 
  }: let

    mkSystem = system: modules: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = modules;
      specialArgs = {
        inherit home-manager stylix;
      };
     };
    
  in {

    nixosConfigurations = {
      desktop = mkSystem "x86_64-linux" [ ./hosts/desktop ];
    };
  };
}

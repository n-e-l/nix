{
  description = "Nel's NixOS flake";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { 
    self,
    nixpkgs, 
	nixos-apple-silicon,
    home-manager,  
    stylix, 
    ... 
  }@inputs: let

    mkSystem = system: modules: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = modules;
      specialArgs = {
        inherit nixos-apple-silicon home-manager stylix;
      };
     };
    
  in {

    nixosConfigurations = {
      desktop = mkSystem "x86_64-linux" [ ./hosts/desktop ];
      macbook = mkSystem "aarch64-linux" [ ./hosts/macbook ];
    };
  };
}

{ config, pkgs, stylix, ... }:

{
  imports = [
    stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    image = ./wallpaper/space_engine.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    targets = {
      kitty.enable = true;
      neovim.enable = true;
      hyprpaper.enable = true;
    };
  };
}

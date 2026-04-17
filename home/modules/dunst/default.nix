{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
	dunst
    libnotify
  ];

  services.dunst = {
    enable = true;
  
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "10x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#89b4fa";
        corner_radius = 8;
        gap_size = 4;
        padding = 8;
        horizontal_padding = 10;
        icon_theme = "Papirus-Dark";
        enable_recursive_icon_lookup = true;
      };
    };
  };
}

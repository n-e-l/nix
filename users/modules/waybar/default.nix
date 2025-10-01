{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
	position = "top";
	height = 20;
	spacing = 4;

        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
	modules-center = [ "hyprland/window" ];
	modules-right = [ "battery" "clock" ];
      };
    };

    style = builtins.readFile ./style.css;
  };

}

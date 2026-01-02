{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    iosevka
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
		modules-right = [ "cpu" "memory" "battery" "clock" ];

		"clock" = {
          format = "{:%Y-%m-%d  %H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

		"cpu" = {
          format = "CPU {usage}%";
          format-alt = "CPU {avg_frequency}GHz";
          tooltip = true;
          interval = 2;
        };
        
        "memory" = {
          format = "RAM {}%";
          format-alt = "RAM {used:0.1f}G/{total:0.1f}G";
          tooltip = true;
          tooltip-format = "Memory: {used:0.1f}G used of {total:0.1f}G ({percentage}%)\nSwap: {swapUsed:0.1f}G used of {swapTotal:0.1f}G ({swapPercentage}%)";
          interval = 2;
        };
      };
    };

    style = builtins.readFile ./style.css;
  };

}

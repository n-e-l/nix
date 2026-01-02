{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      exec-once = [
        "waybar"
      ];

      monitor = [
        "DP-1,2560x1440@165,1440x440,1"
        "HDMI-A-1,2560x1440@144,0x0,1,transform,3"
      ];

      misc = {
        disable_hyprland_logo = true;
	disable_splash_rendering = true;
      };

      workspace = [
        "1, monitor:HDMI-A-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
      ];

      # Key bindings
      "$mod" =  "SUPER";

      bind = [
        # Application shortcuts
        "$mod, Return, exec, kitty"
	"$mod, Q, killactive"
        "$mod, D, exec, rofi -show drun"

	# Brightness
	", XF86MonBrightnessUp, exec, ddcutil -d 1 setvcp 10 + 5; ddcutil -d 2 setvcp 10 + 10"
    	", XF86MonBrightnessDown, exec, ddcutil setvcp 10 - 5; ddcutil -d 2 setvcp 10 - 10"

        # Move focus with mainMod + hjkl
        "$mod, m, movefocus, l"
        "$mod, i, movefocus, r"
        "$mod, e, movefocus, u"
        "$mod, n, movefocus, d"

        # Move window with mainMod + hjkl
        "$mod SHIFT, m, movewindow, l"
        "$mod SHIFT, i , movewindow, r"
        "$mod SHIFT, e, movewindow, u"
        "$mod SHIFT, n, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      input = {
        follow_mouse = 0;
      };
    };
  };
}

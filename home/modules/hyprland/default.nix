{ config, lib, pkgs, ... }:

{
  options.nelHyprland = {
    enable = lib.mkEnableOption "Hyprland configuration";

	monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
	  default = [];
	  description = "Monitor configuration strings for Hyprland";
	};

	workspaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
	  default = [];
	  description = "Workspace assignment for monitors";
	};

	kb_layout = lib.mkOption {
	  type = lib.types.str;
	  default = "us";
	  description = "Keyboard layout";
	};

	kb_options = lib.mkOption {
	  type = lib.types.str;
	  default = "";
	  description = "Keyboard options";
	};
  };

  config = lib.mkIf config.nelHyprland.enable {
    home.packages = with pkgs; [
      hyprpaper
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {

        env = [
          "GDK_SCALE,2"
        ];

        xwayland = {
          force_zero_scaling = true;
        };

        animations = {
          enabled = false;
        };

        exec-once = [
          "waybar"
      	  "hyprpaper"
        ];

        monitor = config.nelHyprland.monitors;

        general = {
          gaps_in = 1;
      	  gaps_out = 5;
      	  border_size = 1;
      	  layout = "dwindle";
        };

        workspace = config.nelHyprland.workspaces ++ [
          # Smart gaps / No gaps when only one window
          "w[t1], gapsout:0, gapsin:0"    # Workspaces with only 1 tiled window
          "w[tg1], gapsout:0, gapsin:0"   # Workspaces with only 1 tiled window in group
          "f[1], gapsout:0, gapsin:0"     # Workspaces with only 1 window (tiled or floating)
        ];
      
        windowrulev2 = [
          # Remove borders and rounding for single tiled windows
          "bordersize 0, floating:0, onworkspace:w[t1]"
          "rounding 0, floating:0, onworkspace:w[t1]"
          "bordersize 0, floating:0, onworkspace:w[tg1]"
          "rounding 0, floating:0, onworkspace:w[tg1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
  
          # Dropdown
          "float, class:(dropdown)"
          "size 80% 60%, class:(dropdown)"
          "center, class:(dropdown)"
        ];

        misc = {
          disable_hyprland_logo = true;
      	  disable_splash_rendering = true;
        };

        # Key bindings
        "$mod" =  "SUPER";

        bind = [
          # Application shortcuts
          "$mod, Return, exec, kitty"
      	  "$mod, Q, killactive"
          "$mod, D, exec, rofi -show drun"
      	  "$mod, P, exec, grim -g \"$(slurp)\" - | wl-copy"
      	  "$mod, U, exec, hdrop kitty --class dropdown"

      	  # Toggle floating
      	  "$mod, s, togglefloating"
      	  #"$mod, g, togglegroup"
      	  #"$mod, y, movewindoworgroup, r"
  
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

      	  # Switch to previous workspace
      	  "$mod, TAB, workspace, previous"

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

          # Move active window to workspace [0-9]
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

      	  # Volume
          ", XF86AudioRaiseVolume, exec, pamixer --increase 5"
      	  ", XF86AudioLowerVolume, exec, pamixer --decrease 5"
      	  ", XF86AudioMute, exec, pamixer --toggle-mute"

      	  # Brightness
      	  ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      	  ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        input = {
          touchpad = {
      	    disable_while_typing = false;
            clickfinger_behavior = 1;
      	    tap-to-click = false;
      	  };

          kb_layout = config.nelHyprland.kb_layout;
      	  kb_options = config.nelHyprland.kb_options; 
          follow_mouse = 0;
        };
      };
    };
  };
}

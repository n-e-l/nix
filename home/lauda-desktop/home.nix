{ config, pkgs, stylix, ... }:

{

  imports = [
    ../modules/stylix
    ../modules/neovim
    ../modules/zsh
    ../modules/kitty
    ../modules/waybar
    ../modules/direnv
    ../modules/hyprland
    ./steam.nix
  ];

  # Disable dconf to prevent the service error
  dconf.enable = false;

  home.username = "lauda";
  home.homeDirectory = "/home/lauda";

  home.stateVersion = "25.05";

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
    BROWSER = "vivaldi";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = "vivaldi-stable.desktop";
      "text/html" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
    };
  };

  home.packages = with pkgs; [
    nix-output-monitor
    git
    vim
    xdg-utils
    gotop
    ranger
    wget
    neofetch
    rofi
    discord
    ddcutil
    inkscape
    vivaldi
    firefox
    spotify
    jetbrains.rust-rover
    python3
    zip
    unzip
    pavucontrol
  ];

  nelHyprland = {
    enable = true;
	monitors = [
	  "DP-1,2560x1440@165,1440x440,1"
      "HDMI-A-1,2560x1440@144,0x0,1,transform,3"
	];

	workspaces = [
	  "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
      "5, monitor:DP-1"
      "6, monitor:HDMI-A-1"
      "7, monitor:HDMI-A-1"
      "8, monitor:HDMI-A-1"
      "9, monitor:HDMI-A-1"
      "10, monitor:HDMI-A-1"
	];
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lauda/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.fontconfig.enable = true;

}

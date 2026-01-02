{ config, pkgs, stylix, ... }:

{

  imports = [
    stylix.homeModules.stylix
    ./direnv.nix
    ./hyprland
	#./steam.nix
    ./neovim
    ./kitty.nix
    ./helix.nix
    ./waybar
  ];

  # Disable dconf to prevent the service error
  dconf.enable = false;

  # Color scheme
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

  home.username = "lauda";
  home.homeDirectory = "/home/lauda";

  home.stateVersion = "25.05";

  services.ssh-agent.enable = true;

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
    BROWSER = "vivaldi";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = "vivaldi-stable.desktop";
      "text/html" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
    };
  };

  programs.distrobox = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-gstreamer
      obs-vkcapture
    ];
  };

  # Enable autoload
  xdg.configFile."gdb/gdbinit".text = ''
    set auto-load safe-path /
  '';

  home.packages = with pkgs; [
    gparted
	gdb
    nix-output-monitor
	mpv
	jq
	qbittorrent
    git
    vivaldi
	vivaldi-ffmpeg-codecs
	widevine-cdm
	blender
    ncdu
    vim
    zip
    unzip
    tree
	krita
    xdg-utils
    tigervnc
	rclone
	zathura
	picard
    remmina
    gotop
    waylock
	ffmpeg
    tmux
    ranger
    grim
    slurp
    wl-clipboard
    wget
	nicotine-plus
    neofetch
	hdrop
    rofi
    widevine-cdm
	p7zip
    firefox
    jetbrains.rust-rover
    jetbrains.idea-ultimate
    jetbrains.clion
	dbeaver-bin
	android-studio
    python3
	tracy
	renderdoc
	fzf
  ];

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

  # Software configuration

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      custom = "/etc/nixos/home/zsh/themes";
      theme = "blinks-mag";
      plugins = [
        "git"
		"fzf"
		"sudo"
		"docker"
      ];
    };

    syntaxHighlighting.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.fontconfig.enable = true;

}

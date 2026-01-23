{ config, lib, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ 
    (final: prev: {
      virglrenderer = prev.virglrenderer.overrideAttrs (old: {
        src = final.fetchurl {
          url = "https://gitlab.freedesktop.org/asahi/virglrenderer/-/archive/asahi-20250424/virglrenderer-asahi-20250424.tar.bz2";
          hash = "sha256-9qFOsSv8o6h9nJXtMKksEaFlDP1of/LXsg3LCRL79JM=";
        };
        mesonFlags = old.mesonFlags ++ [ (final.lib.mesonOption "drm-renderers" "asahi-experimental") ];
      });
    })
  ];

  imports = [
      ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  hardware.asahi = {
    enable = true;
    setupAsahiSound = true;
    peripheralFirmwareDirectory = ./firmware;
  };

  swapDevices = [{
    device = "/swapfile";
    size = 16384;
  }];

  hardware.graphics = {
    enable = true;
  };

  # Allow non-root users to use FUSE
  programs.fuse.userAllowOther = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  boot.kernelParams = [
  ];

  # Display manager
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";  # or "doom", "none"
      bigclock = "en";
      hide_borders = true;
      save = true;
    };
  };

  # networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    #font = "Lat2-Terminus16";
    useXkbConfig = true; # Load xkb keymap in tty
  };

  # Theme
  environment.variables = {
    GTK_THEME = "Adwaita:dark";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  services.xserver.xkb.extraLayouts.dh = {
    description = "Colemak-DH ergo";
    languages = ["eng"];
    symbolsFile = symbols/colemak_dh;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "dh";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            rightmeta = "layer(nav)";
          };
          
          nav = {
            # Vim-style arrow keys
            h = "left";
            j = "down";
            k = "up";
            l = "right";
          };
        };
      };
    };
  };


  virtualisation.docker.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # MIDI support
  services.udev.packages = [ pkgs.alsa-utils ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.lauda = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "dialout" "audio" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      neovim
    ];
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    fuse
	virglrenderer
    alsa-utils
    brightnessctl
    pamixer
    git
    neovim
    openvpn
    wget
    pavucontrol
    qemu
  ] ++ [
    inputs.globalprotect-openconnect.packages.${pkgs.system}.default
  ];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.fireware.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

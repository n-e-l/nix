{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
  ];

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      custom = "/etc/nixos/home/modules/zsh/themes";
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
}

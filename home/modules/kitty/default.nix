{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hack-font
    kitty
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Hack";
    };
  };
}

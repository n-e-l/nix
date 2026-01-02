{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
  ];

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        mouse = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
    languages = {
      language = [{
        name = "rust";
        auto-format = true;
      }];
    };
  };
}

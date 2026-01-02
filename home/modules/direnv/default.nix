{ config, pkgs, ... }:

{

  #
  # Direnv allows you to run .envrc files automatically upon entering a directory.
  # By putting "use flake" in there you automatically load your flake.nix files.
  #

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

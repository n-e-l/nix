{ config, pkgs, inputs, ... }:
{
  home-manager.users.lauda.programs.kitty.extraConfig =
    builtins.readFile (config.scheme inputs.base16-kitty);
}

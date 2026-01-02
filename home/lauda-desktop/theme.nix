{ config, lib, ... }@args:
let
  inherit (lib) mkOption types;
  inherit (config.theme) colors;

  theme = (import colorschemes/pasque.nix args).colorScheme;
in {
  options.theme = lib.mkOption {
    type = lib.types.submodule {
      options = {
        slug = lib.mkOption { type = lib.types.str; };
	name = lib.mkOption { type = lib.types.str; };
	author = lib.mkOption { type = lib.types.str; };
	palette = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
	};
      };
    };
    description = "Theme configuration";
  };

  config.theme = theme;
}

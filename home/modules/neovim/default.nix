{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      nvim-treesitter.withAllGrammars
    ];
  };
}

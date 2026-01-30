{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
	ripgrep
	fd
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      nvim-treesitter.withAllGrammars
	  vim-gitgutter

	  # Telescope
	  telescope-nvim
      telescope-fzf-native-nvim
	  plenary-nvim
    ];

    extraConfig = ''
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
	  let mapleader = " "

	  " Gitgutter
	  set updatetime=100
      set signcolumn=yes
      highlight clear SignColumn
    '';
	
  extraLuaConfig = ''
    -- Telescope setup
    require('telescope').setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        }
      }
    })
    
    -- Load fzf extension
    require('telescope').load_extension('fzf')
    
    -- Keybindings
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Search in files' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Find files' })
  '';
  };
}

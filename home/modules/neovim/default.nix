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

	  # Keymap popup
	  which-key-nvim
    ];

    extraConfig = ''
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
	  let mapleader = " "

	  set number

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
    
    -- Helix-style space-mode keybindings
    local builtin = require('telescope.builtin')
	local map = function(key, cmd, desc)
      vim.keymap.set("n", key, cmd, { desc = desc, noremap = true, silent = false })
    end
	map("<space>f",  builtin.find_files,           "file picker")
	map('<leader>ff', builtin.find_files, 'Find files')
    map('<leader>fg', builtin.live_grep, 'Search in files')
    map('<leader>fb', builtin.buffers, 'Find buffers')
    map('<leader><space>', builtin.find_files, 'Find files')

  '';
  };
}

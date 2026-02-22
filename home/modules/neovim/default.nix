{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
	ripgrep
	fd

	# LSP servers
	nodePackages.typescript-language-server
	rust-analyzer
	pyright
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
	  telescope-file-browser-nvim
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
    -- LSP setup
    local caps = require('cmp_nvim_lsp').default_capabilities()
    
    for _, s in ipairs({ 'ts_ls', 'rust_analyzer', 'pyright' }) do
      vim.lsp.config(s, { capabilities = caps })
      vim.lsp.enable(s)
    end

	vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local map = function(key, cmd, desc)
          vim.keymap.set('n', key, cmd, { buffer = args.buf, desc = desc })
        end
        map('gd',         vim.lsp.buf.definition,     'Go to definition')
        map('gD',         vim.lsp.buf.declaration,    'Go to declaration')
        map('gr',         vim.lsp.buf.references,     'References')
        map('K',          vim.lsp.buf.hover,          'Hover docs')
        map('<leader>rn', vim.lsp.buf.rename,         'Rename symbol')
        map('<leader>ca', vim.lsp.buf.code_action,    'Code action')
        map('[d',         vim.diagnostic.goto_prev,   'Prev diagnostic')
        map(']d',         vim.diagnostic.goto_next,   'Next diagnostic')
      end
    })

    -- Telescope setup
    require('telescope').setup({
	  defaults = {
            borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            sorting_strategy = 'ascending',
		layout_config = {
		  prompt_position = 'top',
		},
		border = true,
		prompt_prefix = '> ',
		selection_caret = '> ',

		-- Helix-style insert-mode navigation
		mappings = {
		  i = {
			['<C-j>'] = 'move_selection_next',
			['<C-k>'] = 'move_selection_previous',
			['<esc>'] = 'close',         -- single esc closes, like Helix
			['<C-c>'] = 'close',
			['<C-u>'] = false,           -- don't clear prompt on C-u
			['<C-s>'] = 'select_horizontal', -- open in split
			['<C-v>'] = 'select_vertical',
		  },
		},
	  },
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
    
    local builtin = require('telescope.builtin')
	local map = function(key, cmd, desc)
      vim.keymap.set("n", key, cmd, { desc = desc, noremap = true, silent = false })
    end
	map("<space>f",  builtin.find_files,           "file picker")
	map('<leader>ff', builtin.find_files, 'Find files')
    map('<leader>fg', builtin.live_grep, 'Search in files')
    map('<leader>fb', builtin.buffers, 'Find buffers')
    map('<leader><space>', builtin.find_files, 'Find files')

    -- File browser
	require('telescope').load_extension('file_browser')
    map('<leader>e', ':Telescope file_browser<CR>', 'File browser')
  '';
  };
}

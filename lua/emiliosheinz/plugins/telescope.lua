return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local config = require("telescope.config")
    local builtin = require("telescope.builtin")
    local lga_actions = require("telescope-live-grep-args.actions")
    local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--hidden")
    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = { "%.git/", "phpstan%-baseline.php" },
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-space>"] = lga_actions.quote_prompt(),
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden" },
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("live_grep_args")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
    vim.keymap.set("n", "<leader>fs", telescope.extensions.live_grep_args.live_grep_args, { desc = "Find string in cwd" })
    vim.keymap.set("n", "<leader>fc", lga_shortcuts.grep_word_under_cursor, { desc = "Find string under cursor in cwd" })
    vim.keymap.set("v", "<leader>fv", lga_shortcuts.grep_visual_selection, { desc = "Find string that is currently visually selected" })
    vim.keymap.set(
      "n",
      "<leader>fS",
      builtin.lsp_dynamic_workspace_symbols,
      { desc = "Find LSP workspace symbols" }
    )
  end,
}

-- ┌─────────────────┐
-- │ Custom mappings │
-- └─────────────────┘
--
-- This file contains definitions of custom general and Leader mappings.

-- General mappings ===========================================================

-- Use this section to add custom general mappings. See `:h vim.keymap.set()`.

-- An example helper to create a Normal mode mapping
local nmap = function(lhs, rhs, desc)
	-- See `:h vim.keymap.set()`
	vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- Escape toggles search highlight off.
nmap("<Esc>", "<Cmd>nohlsearch<CR>")

-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
nmap("[p", '<Cmd>exe "put! " . v:register<CR>', "Paste Above")
nmap("]p", '<Cmd>exe "put "  . v:register<CR>', "Paste Below")

-- Many general mappings are created by 'mini.basics'. See 'plugin/30_mini.lua'

-- Leader mappings ============================================================

-- Neovim has the concept of a Leader key (see `:h <Leader>`). It is a configurable
-- key that is primarily used for "workflow" mappings (opposed to text editing).
-- Like "open file explorer", "create scratch buffer", "pick from buffers".
--
-- In 'plugin/10_options.lua' <Leader> is set to <Space>, i.e. press <Space>
-- whenever there is a suggestion to press <Leader>.
--
-- This config uses a "two key Leader mappings" approach: first key describes
-- semantic group, second key executes an action. Both keys are usually chosen
-- to create some kind of mnemonic.
-- Example: `<Leader>f` groups "find" type of actions; `<Leader>ff` - find files.
-- Use this section to add Leader mappings in a structural manner.
--
-- Usually if there are global and local kinds of actions, lowercase second key
-- denotes global and uppercase - local.
-- Example: `<Leader>fs` / `<Leader>fS` - find workspace/document LSP symbols.
--
-- Many of the mappings use 'mini.nvim' modules set up in 'plugin/30_mini.lua'.

-- Create a global table with information about Leader groups in certain modes.
-- This is used to provide 'mini.clue' with extra clues.
-- Add an entry if you create a new group.
_G.Config.leader_group_clues = {
	{ mode = "n", keys = "<Leader>b", desc = "+Buffer" },
	{ mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
	{ mode = "n", keys = "<Leader>f", desc = "+Find" },
	{ mode = "n", keys = "<Leader>g", desc = "+Git" },
	{ mode = "n", keys = "<Leader>s", desc = "+Session" },
	{ mode = "n", keys = "<Leader>c", desc = "+Code" },
	{ mode = "x", keys = "<Leader>g", desc = "+Git" },
	{ mode = "q", keys = "<Leader>q", desc = "+Quit" },
}

-- Helpers for a more concise `<Leader>` mappings.
-- Most of the mappings use `<Cmd>...<CR>` string as a right hand side (RHS) in
-- an attempt to be more concise yet descriptive. See `:h <Cmd>`.
-- This approach also doesn't require the underlying commands/functions to exist
-- during mapping creation: a "lazy loading" approach to improve startup time.
local nmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end

-- b is for 'Buffer'. Common usage:
-- - `<Leader>bs` - create scratch (temporary) buffer
local new_scratch_buffer = function()
	vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end
nmap_leader("bd", ":bdelete<CR>", "Delete")
nmap_leader("bs", new_scratch_buffer, "Scratch")
nmap("H", ":bprevious<CR>", "Previous buffer")
nmap("L", ":bnext<CR>", "Next buffer")

-- e is for 'Explore' and 'Edit'. Common usage:
-- - `<Leader>ed` - open explorer at current working directory
-- - `<Leader>ef` - open directory of current file (needs to be present on disk)
-- - All mappings that use `edit_plugin_file` - edit 'plugin/' config files
nmap_leader("ed", "<Cmd>lua MiniFiles.open()<CR>", "Directory")
nmap_leader("ef", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", "File directory")
nmap_leader("en", "<Cmd>lua MiniNotify.show_history()<CR>", "Notifications")

-- f is for 'Fuzzy Find'. Common usage:
-- - `<Leader>ff` - find files; for best performance requires `ripgrep`
-- - `<Leader>fg` - find inside files; requires `ripgrep`
-- - `<Leader>fh` - find help tag
-- - `<Leader>fr` - resume latest picker
--
-- All these use 'mini.pick'. See `:h MiniPick-overview` for an overview.
nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
nmap_leader("f:", '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader("fb", "<Cmd>Pick buffers<CR>", "Buffers")
nmap_leader("fg", "<Cmd>Pick grep_live<CR>", "Grep live")
nmap_leader("fG", '<Cmd>Pick grep pattern="<cword>"<CR>', "Grep current word")
nmap_leader("fh", "<Cmd>Pick help<CR>", "Help tags")
nmap_leader("fl", '<Cmd>Pick buf_lines scope="all"<CR>', "Lines (all)")
nmap_leader("fL", '<Cmd>Pick buf_lines scope="current"<CR>', "Lines (buf)")
nmap_leader("fr", "<Cmd>Pick resume<CR>", "Resume")
nmap_leader("fs", '<Cmd>Pick lsp scope="workspace_symbol"<CR>', "Symbols workspace")
nmap_leader("fS", '<Cmd>Pick lsp scope="document_symbol"<CR>', "Symbols document")

-- Disable the default LSP commands to avoid conflicts
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")

nmap("gr", '<Cmd>Pick lsp scope="references"<CR>', "References (LSP)")
nmap("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", "Source definition")
nmap_leader("gd", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle diff")

-- c is for 'Code'. Common usage:
-- - `<Leader>cd` - show more diagnostic details in a floating window
-- - `<Leader>cr` - perform rename via LSP
nmap_leader("ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions")
nmap_leader("cd", '<Cmd>Pick diagnostic scope="all"<CR>', "Diagnostic workspace")
nmap_leader("cD", '<Cmd>Pick diagnostic scope="current"<CR>', "Diagnostic buffer")
nmap_leader("cf", '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>', "Format")
nmap_leader("cr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")

-- s is for 'Session'. Common usage:
-- - `<Leader>sn` - start new session
-- - `<Leader>sl` - load previous session
-- - `<Leader>sd` - delete previously started session
nmap_leader("sd", '<Cmd>lua MiniSessions.select("delete")<CR>', "Delete")
nmap_leader("sn", '<Cmd>lua MiniSessions.write(vim.fn.input("Session name: "))<CR>', "New")
nmap_leader("sl", '<Cmd>lua MiniSessions.select("read")<CR>', "Load")

-- q is for 'Quit'
nmap_leader("qq", ":qa<CR>", "Delete")

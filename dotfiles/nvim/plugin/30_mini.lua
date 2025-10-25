-- ┌────────────────────┐
-- │ MINI configuration │
-- └────────────────────┘
--
-- This file contains configuration of the MINI parts of the config.
-- It contains only configs for the 'mini.nvim' plugin (installed in 'init.lua').
--
-- 'mini.nvim' is a library of modules. Each is enabled independently via
-- `require('mini.xxx').setup()` convention. It creates all intended side effects:
-- mappings, autocommands, highlight groups, etc. It also creates a global
-- `MiniXxx` table that can be later used to access module's features.
--
-- Every module's `setup()` function accepts an optional `config` table to
-- adjust its behavior. See the structure of this table at `:h MiniXxx.config`.
--
-- See `:h mini.nvim-general-principles` for more general principles.
--
-- Here each module's `setup()` has a brief explanation of what the module is for,
-- its usage examples (uses Leader mappings from 'plugin/20_keymaps.lua'), and
-- possible directions for more info.
-- For more info about a module see its help page (`:h mini.xxx` for 'mini.xxx').

-- To minimize the time until first screen draw, modules are enabled in two steps:
-- - Step one enables everything that is needed for first draw with `now()`.
-- - Everything else is delayed until the first draw with `later()`.
local now, later = MiniDeps.now, MiniDeps.later

-- Step one ===================================================================
-- Enable a color scheme from 'mini.nvim', which uses 'mini.hues'.
--
-- See also:
-- - `:h mini.nvim-color-schemes` - list of other color schemes
-- - `:h MiniHues-examples` - how to define highlighting with 'mini.hues'

-- You can try these 'mini.hues'-based color schemes (uncomment with `gcc`):
-- now(function()
-- 	vim.cmd("colorscheme miniwinter")
-- end)
-- now(function()
-- 	vim.cmd("colorscheme minispring")
-- end)
-- now(function()
-- 	vim.cmd("colorscheme minisummer")
-- end)
-- now(function()
-- 	vim.cmd("colorscheme miniautumn")
-- end)
-- now(function()
-- 	vim.cmd("colorscheme randomhue")
-- end)

-- Common configuration presets. Example usage:
-- - `<C-s>` in Insert mode - save and go to Normal mode
-- - `go` / `gO` - insert empty line before/after in Normal mode
-- - `gy` / `gp` - copy / paste from system clipboard
-- - `\` + key - toggle common options. Like `\h` toggles highlighting search.
-- - `<C-hjkl>` (four combos) - navigate between windows.
-- - `<M-hjkl>` in Insert/Command mode - navigate in that mode.
--
-- See also:
-- - `:h MiniBasics.config.options` - list of adjusted options
-- - `:h MiniBasics.config.mappings` - list of created mappings
-- - `:h MiniBasics.config.autocommands` - list of created autocommands
now(function()
	require("mini.basics").setup({
		-- Manage options in 'plugin/10_options.lua' for didactic purposes
		options = { basic = false },
		mappings = {
			-- Create `<C-hjkl>` mappings for window navigation
			windows = true,
			-- Create `<M-hjkl>` mappings for navigation in Insert and Command modes
			move_with_alt = true,
		},
	})
end)

-- Icon provider. Usually no need to use manually. It is used by plugins like
-- 'mini.pick', 'mini.files', 'mini.statusline', and others.
now(function()
	-- Set up to not prefer extension-based icon for some extensions
	local ext3_blocklist = { scm = true, txt = true, yml = true }
	local ext4_blocklist = { json = true, yaml = true }
	require("mini.icons").setup({
		use_file_extension = function(ext, _)
			return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
		end,
	})

	-- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
	-- Not needed for 'mini.nvim' or MiniMax, but might be useful for others.
	later(MiniIcons.mock_nvim_web_devicons)

	-- Add LSP kind icons. Useful for 'mini.completion'.
	later(MiniIcons.tweak_lsp_kind)
end)

-- Notifications provider. Shows all kinds of notifications in the upper right
-- corner (by default). Example usage:
-- - `:h vim.notify()` - show notification (hides automatically)
-- - `<Leader>en` - show notification history
--
-- See also:
-- - `:h MiniNotify.config` for some of common configuration examples.
now(function()
	require("mini.notify").setup()
end)

-- Session management. A thin wrapper around `:h mksession` that consistently
-- manages session files. Example usage:
-- - `<Leader>sn` - start new session
-- - `<Leader>sr` - read previously started session
-- - `<Leader>sd` - delete previously started session
now(function()
	require("mini.sessions").setup()
end)

-- Start screen. This is what is shown when you open Neovim like `nvim`.
-- Example usage:
-- - Type prefix keys to limit available candidates
-- - Navigate down/up with `<C-n>` and `<C-p>`
-- - Press `<CR>` to select an entry
--
-- See also:
-- - `:h MiniStarter-example-config` - non-default config examples
-- - `:h MiniStarter-lifecycle` - how to work with Starter buffer
now(function()
	local starter = require("mini.starter")
	starter.setup({
		header = "Welcome!",
		items = {
			starter.sections.sessions(5, true),
			starter.sections.builtin_actions(),
		},
	})
end)

-- Statusline. Sets `:h 'statusline'` to show more info in a line below window.
-- Example usage:
-- - Left most section indicates current mode (text + highlighting).
-- - Second from left section shows "developer info": Git, diff, diagnostics, LSP.
-- - Center section shows the name of displayed buffer.
-- - Second to right section shows more buffer info.
-- - Right most section shows current cursor coordinates and search results.
--
-- See also:
-- - `:h MiniStatusline-example-content` - example of default content. Use it to
--   configure a custom statusline by setting `config.content.active` function.
now(function()
	require("mini.statusline").setup()
end)

-- Tabline. Sets `:h 'tabline'` to show all listed buffers in a line at the top.
-- Buffers are ordered as they were created. Navigate with `[b` and `]b`.
now(function()
	require("mini.tabline").setup()
end)

-- Step two ===================================================================

-- Extra 'mini.nvim' functionality.
--
-- See also:
-- - `:h MiniExtra.pickers` - pickers. Most are mapped in `<Leader>f` group.
--   Calling `setup()` makes 'mini.pick' respect 'mini.extra' pickers.
-- - `:h MiniExtra.gen_ai_spec` - 'mini.ai' textobject specifications
-- - `:h MiniExtra.gen_highlighter` - 'mini.hipatterns' highlighters
later(function()
	require("mini.extra").setup()
end)

-- Extend and create a/i textobjects, like `:h a(`, `:h a'`, and more).
-- Contains not only `a` and `i` type of textobjects, but also their "next" and
-- "last" variants that will explicitly search for textobjects after and before
-- cursor. Example usage:
-- - `ci)` - *c*hange *i*inside parenthesis (`)`)
-- - `di(` - *d*elete *i*inside padded parenthesis (`(`)
-- - `yaq` - *y*ank *a*round *q*uote (any of "", '', or ``)
-- - `vif` - *v*isually select *i*inside *f*unction call
-- - `cina` - *c*hange *i*nside *n*ext *a*rgument
-- - `valaala` - *v*isually select *a*round *l*ast (i.e. previous) *a*rgument
--   and then again reselect *a*round new *l*ast *a*rgument
--
-- See also:
-- - `:h text-objects` - general info about what textobjects are
-- - `:h MiniAi-builtin-textobjects` - list of all supported textobjects
-- - `:h MiniAi-textobject-specification` - examples of custom textobjects
later(function()
	local ai = require("mini.ai")
	ai.setup({
		-- 'mini.ai' can be extended with custom textobjects
		custom_textobjects = {
			-- Make `aB` / `iB` act on around/inside whole *b*uffer
			B = MiniExtra.gen_ai_spec.buffer(),
			-- For more complicated textobjects that require structural awareness,
			-- use tree-sitter. This example makes `aF`/`iF` mean around/inside function
			-- definition (not call). See `:h MiniAi.gen_spec.treesitter()` for details.
			F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		},

		-- 'mini.ai' by default mostly mimics built-in search behavior: first try
		-- to find textobject covering cursor, then try to find to the right.
		-- Although this works in most cases, some are confusing. It is more robust to
		-- always try to search only covering textobject and explicitly ask to search
		-- for next (`an`/`in`) or last (`an`/`il`).
		-- Try this. If you don't like it - delete next line and this comment.
		search_method = "cover",
	})
end)

-- Align text interactively. Example usage:
-- - `gaip,` - `ga` (align operator) *i*nside *p*aragraph by comma
-- - `gAip` - start interactive alignment on the paragraph. Choose how to
--   split, justify, and merge string parts. Press `<CR>` to make it permanent,
--   press `<Esc>` to go back to initial state.
--
-- See also:
-- - `:h MiniAlign-example` - hands-on list of examples to practice aligning
-- - `:h MiniAlign.gen_step` - list of support step customizations
-- - `:h MiniAlign-algorithm` - how alignment is done on algorithmic level
later(function()
	require("mini.align").setup()
end)

-- Animate common Neovim actions. Like cursor movement, scroll, window resize,
-- window open, window close. Animations are done based on Neovim events and
-- don't require custom mappings.
--
-- It is not enabled by default because its effects are a matter of taste.
-- Also scroll and resize have some unwanted side effects (see `:h mini.animate`).
-- Uncomment next line (use `gcc`) to enable.
later(function()
	require("mini.animate").setup({
		cursor = {
			enable = false,
		},
	})
end)

-- Go forward/backward with square brackets. Implements consistent sets of mappings
-- for selected targets (like buffers, diagnostic, quickfix list entries, etc.).
-- Example usage:
-- - `]b` - go to next buffer
-- - `[j` - go to previous jump inside current buffer
-- - `[Q` - go to first entry of quickfix list
-- - `]X` - go to last conflict marker in a buffer
--
-- See also:
-- - `:h MiniBracketed` - overall mapping design and list of targets
later(function()
	require("mini.bracketed").setup()
end)

-- Show next key clues in a bottom right window. Requires explicit opt-in for
-- keys that act as clue trigger. Example usage:
-- - Press `<Leader>` and wait for 1 second. A window with information about
--   next available keys should appear.
-- - Press one of the listed keys. Window updates immediately to show information
--   about new next available keys. You can press `<BS>` to go back in key sequence.
-- - Press keys until they resolve into some mapping.
--
-- Note: it is designed to work in buffers for normal files. It doesn't work in
-- special buffers (like for 'mini.starter' or 'mini.files') to not conflict
-- with its local mappings.
--
-- See also:
-- - `:h MiniClue-examples` - examples of common setups
-- - `:h MiniClue.ensure_buf_triggers()` - use it to enable triggers in buffer
-- - `:h MiniClue.set_mapping_desc()` - change mapping description not from config
later(function()
	local miniclue = require("mini.clue")
	miniclue.setup({
		-- Define which clues to show. By default shows only clues for custom mappings
		-- (uses `desc` field from the mapping; takes precedence over custom clue).
		clues = {
			-- This is defined in 'plugin/20_keymaps.lua' with Leader group descriptions
			Config.leader_group_clues,
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			-- This creates a submode for window resize mappings. Try the following:
			-- - Press `<C-w>s` to make a window split.
			-- - Press `<C-w>+` to increase height. Clue window still shows clues as if
			--   `<C-w>` is pressed again. Keep pressing just `+` to increase height.
			--   Try pressing `-` to decrease height.
			-- - Stop submode either by `<Esc>` or by any key that is not in submode.
			miniclue.gen_clues.windows({ submode_resize = true }),
			miniclue.gen_clues.z(),
		},
		-- Explicitly opt-in for set of common keys to trigger clue window
		triggers = {
			{ mode = "n", keys = "<Leader>" }, -- Leader triggers
			{ mode = "x", keys = "<Leader>" },
			{ mode = "n", keys = "\\" }, -- mini.basics
			{ mode = "n", keys = "[" }, -- mini.bracketed
			{ mode = "n", keys = "]" },
			{ mode = "x", keys = "[" },
			{ mode = "x", keys = "]" },
			{ mode = "i", keys = "<C-x>" }, -- Built-in completion
			{ mode = "n", keys = "g" }, -- `g` key
			{ mode = "x", keys = "g" },
			{ mode = "n", keys = "'" }, -- Marks
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },
			{ mode = "n", keys = '"' }, -- Registers
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },
			{ mode = "n", keys = "<C-w>" }, -- Window commands
			{ mode = "n", keys = "z" }, -- `z` key
			{ mode = "x", keys = "z" },
		},
	})
end)

-- Tweak and save any color scheme. Contains utility functions to work with
-- color spaces and color schemes. Example usage:
-- - `:Colorscheme default` - switch with animation to the default color scheme
--
-- See also:
-- - `:h MiniColors.interactive()` - interactively tweak color scheme
-- - `:h MiniColors-recipes` - common recipes to use during interactive tweaking
-- - `:h MiniColors.convert()` - convert between color spaces
-- - `:h MiniColors-color-spaces` - list of supported color sapces
--
-- Comment lines. Provides functionality to work with commented lines.
-- Uses `:h 'commentstring'` option to infer comment structure.
-- Example usage:
-- - `gcip` - toggle comment (`gc`) *i*inside *p*aragraph
-- - `vapgc` - *v*isually select *a*round *p*aragraph and toggle comment (`gc`)
-- - `gcgc` - uncomment (`gc`, operator) comment block at cursor (`gc`, textobject)
--
-- The built-in `:h commenting` is based on 'mini.comment'. Yet this module is
-- still enabled as it provides more customization opportunities.
later(function()
	require("mini.comment").setup()
end)

-- Completion and signature help. Implements async "two stage" autocompletion:
-- - Based on attached LSP servers that support completion.
-- - Fallback (based on built-in keyword completion) if there is no LSP candidates.
--
-- Example usage in Insert mode with attached LSP:
-- - Start typing text that should be recognized by LSP (like variable name).
-- - After 100ms a popup menu with candidates appears.
-- - Press `<Tab>` / `<S-Tab>` to navigate down/up the list. These are set up
--   in 'mini.keymap'. You can also use `<C-n>` / `<C-p>`.
-- - During navigation there is an info window to the right showing extra info
--   that the LSP server can provide about the candidate. It appears after the
--   candidate stays selected for 100ms. Use `<C-f>` / `<C-b>` to scroll it.
-- - Navigating to an entry also changes buffer text. If you are happy with it,
--   keep typing after it. To discard completion completely, press `<C-e>`.
-- - After pressing special trigger(s), usually `(`, a window appears that shows
--   the signature of the current function/method. It gets updated as you type
--   showing the currently active parameter.
--
-- Example usage in Insert mode without an attached LSP or in places not
-- supported by the LSP (like comments):
-- - Start typing a word that is present in current or opened buffers.
-- - After 100ms popup menu with candidates appears.
-- - Navigate with `<Tab>` / `<S-Tab>` or `<C-n>` / `<C-p>`. This also updates
--   buffer text. If happy with choice, keep typing. Stop with `<C-e>`.
--
-- It also works with snippet candidates provided by LSP server. Best experience
-- when paired with 'mini.snippets' (which is set up in this file).
later(function()
	-- Customize post-processing of LSP responses for a better user experience.
	-- Don't show 'Text' suggestions (usually noisy) and show snippets last.
	local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
	local process_items = function(items, base)
		return MiniCompletion.default_process_items(items, base, process_items_opts)
	end
	require("mini.completion").setup({
		lsp_completion = {
			-- Without this config autocompletion is set up through `:h 'completefunc'`.
			-- Although not needed, setting up through `:h 'omnifunc'` is cleaner
			-- (sets up only when needed) and makes it possible to use `<C-u>`.
			source_func = "omnifunc",
			auto_setup = false,
			process_items = process_items,
		},
	})

	-- Set 'omnifunc' for LSP completion only when needed.
	local on_attach = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
	end
	_G.Config.new_autocmd("LspAttach", nil, on_attach, "Set 'omnifunc'")

	-- Advertise to servers that Neovim now supports certain set of completion and
	-- signature features through 'mini.completion'.
	vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

-- Work with diff hunks that represent the difference between the buffer text and
-- some reference text set by a source. Default source uses text from Git index.
-- Also provides summary info used in developer section of 'mini.statusline'.
-- Example usage:
-- - `<Leader>go` - toggle overlay
--
-- See also:
-- - `:h MiniDiff-overview` - overview of how module works
-- - `:h MiniDiff-diff-summary` - available summary information
-- - `:h MiniDiff.gen_source` - available built-in sources
later(function()
	require("mini.diff").setup()
end)

-- Navigate and manipulate file system
--
-- Navigation is done using column view (Miller columns) to display nested
-- directories, they are displayed in floating windows in top left corner.
--
-- Manipulate files and directories by editing text as regular buffers.
--
-- Example usage:
-- - `<Leader>ed` - open current working directory
-- - `<Leader>ef` - open directory of current file (needs to be present on disk)
--
-- Basic navigation:
-- - `l` - go in entry at cursor: navigate into directory or open file
-- - `h` - go out of focused directory
-- - Navigate window as any regular buffer
-- - Press `g?` inside explorer to see more mappings
--
-- Basic manipulation:
-- - After any following action, press `=` in Normal mode to synchronize, read
--   carefully about actions, press `y` or `<CR>` to confirm
-- - New entry: press `o` and type its name; end with `/` to create directory
-- - Rename: press `C` and type new name
-- - Delete: type `dd`
-- - Move/copy: type `dd`/`yy`, navigate to target directory, press `p`
--
-- See also:
-- - `:h MiniFiles-navigation` - more details about how to navigate
-- - `:h MiniFiles-manipulation` - more details about how to manipulate
-- - `:h MiniFiles-examples` - examples of common setups
later(function()
	-- Enable directory/file preview
	require("mini.files").setup({ windows = { preview = true } })

	-- Add common bookmarks for every explorer. Example usage inside explorer:
	-- - `'c` to navigate into your config directory
	-- - `g?` to see available bookmarks
	local add_marks = function()
		MiniFiles.set_bookmark("r", vim.fn.expand("~/repos"), { desc = "Repos" })
		MiniFiles.set_bookmark("c", vim.fn.expand("~/.config"), { desc = "Config" })
		MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
	end
	_G.Config.new_autocmd("User", "MiniFilesExplorerOpen", add_marks, "Add bookmarks")
end)

-- Git integration for more straightforward Git actions based on Neovim's state.
-- It is not meant as a fully featured Git client, only to provide helpers that
-- integrate better with Neovim. Example usage:
-- - `<Leader>gs` - show information at cursor
-- - `<Leader>gd` - show unstaged changes as a patch in separate tabpage
-- - `<Leader>gL` - show Git log of current file
-- - `:Git help git` - show output of `git help git` inside Neovim
--
-- See also:
-- - `:h MiniGit-examples` - examples of common setups
-- - `:h :Git` - more details about `:Git` user command
-- - `:h MiniGit.show_at_cursor()` - what information at cursor is shown
later(function()
	require("mini.git").setup()
end)

-- Highlight patterns in text. Like `TODO`/`NOTE` or color hex codes.
-- Example usage:
-- - `:Pick hipatterns` - pick among all highlighted patterns
--
-- See also:
-- - `:h MiniHipatterns-examples` - examples of common setups
later(function()
	local hipatterns = require("mini.hipatterns")
	local hi_words = MiniExtra.gen_highlighter.words
	hipatterns.setup({
		highlighters = {
			-- Highlight a fixed set of common words. Will be highlighted in any place,
			-- not like "only in comments".
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

			-- Highlight hex color string (#aabbcc) with that color as a background
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

-- Jump to next/previous single character. It implements "smarter `fFtT` keys"
-- (see `:h f`) that work across multiple lines, start "jumping mode", and
-- highlight all target matches. Example usage:
-- - `fxff` - move *f*orward onto next character "x", then next, and next again
-- - `dt)` - *d*elete *t*ill next closing parenthesis (`)`)
later(function()
	require("mini.jump").setup()
end)

-- Jump within visible lines to pre-defined spots via iterative label filtering.
-- Spots are computed by a configurable spotter function.
--
-- See also:
-- - `:h MiniJump2d.gen_spotter` - list of available spotters
later(function()
	local jump2d = require("mini.jump2d")
	jump2d.setup({
		spotter = jump2d.gen_spotter.pattern("[^%s%p]+"),
		labels = "arstneioqwfpluy;zxcdh,./bjvk",
		view = { dim = true, n_steps_ahead = 2 },
	})
	vim.keymap.set({ "n", "x", "o" }, "<CR>", function()
		MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
	end)
end)

-- Special key mappings. Provides helpers to map:
-- - Multi-step actions. Apply action 1 if condition is met; else apply
--   action 2 if condition is met; etc.
-- - Combos. Sequence of keys where each acts immediately plus execute extra
--   action if all are typed fast enough. Useful for Insert mode mappings to not
--   introduce delay when typing mapping keys without intention to execute action.
--
-- See also:
-- - `:h MiniKeymap-examples` - examples of common setups
-- - `:h MiniKeymap.map_multistep()` - map multi-step action
-- - `:h MiniKeymap.map_combo()` - map combo
later(function()
	require("mini.keymap").setup()
	-- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
	MiniKeymap.map_multistep("i", "<Tab>", { "pmenu_next" })
	MiniKeymap.map_multistep("i", "<S-Tab>", { "pmenu_prev" })
	-- On `<CR>` try to accept current completion item, fall back to accounting
	-- for pairs from 'mini.pairs'
	MiniKeymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
	-- On `<BS>` just try to account for pairs from 'mini.pairs'
	MiniKeymap.map_multistep("i", "<BS>", { "minipairs_bs" })
end)

-- Move any selection in any direction. Example usage in Normal mode:
-- - `<M-j>`/`<M-k>` - move current line down / up
-- - `<M-h>`/`<M-l>` - decrease / increase indent of current line
--
-- Example usage in Visual mode:
-- - `<M-h>`/`<M-j>`/`<M-k>`/`<M-l>` - move selection left/down/up/right
later(function()
	require("mini.move").setup()
end)

-- Autopairs functionality. Insert pair when typing opening character and go over
-- right character if it is already to cursor's right. Also provides mappings for
-- `<CR>` and `<BS>` to perform extra actions when inside pair.
-- Example usage in Insert mode:
-- - `(` - insert "()" and put cursor between them
-- - `)` when there is ")" to the right - jump over ")" without inserting new one
-- - `<C-v>(` - always insert a single "(" literally. This is useful since
--   'mini.pairs' doesn't provide particularly smart behavior, like auto balancing
later(function()
	-- Create pairs not only in Insert, but also in Command line mode
	require("mini.pairs").setup({ modes = { command = true } })
end)

-- Pick anything with single window layout and fast matching. This is one of
-- the main usability improvements as it powers a lot of "find things quickly"
-- workflows. How to use a picker:
-- - Start picker, usually with `:Pick <picker-name>` command. Like `:Pick files`.
--   It shows a single centered window filled with possible items to choose from.
--   Current item has special full line highlighting.
--   At the top there is a current query used to filter+sort items.
-- - Type characters (appear at top) to narrow down items. There is fuzzy matching:
--   characters may not match one-by-one, but they should be in correct order.
-- - Navigate down/up with `<C-n>`/`<C-p>`.
-- - Press `<Tab>` to show item's preview. `<Tab>` again goes back to items.
-- - Press `<S-Tab>` to show picker's info. `<S-Tab>` again goes back to items.
-- - Press `<CR>` to choose an item. The exact action depends on the picker: `files`
--   picker opens a selected file, `help` picker opens help page on selected tag.
--   To close picker without choosing an item, press `<Esc>`.
--
-- Example usage:
-- - `<Leader>ff` - *f*ind *f*iles; for best performance requires `ripgrep`
-- - `<Leader>fg` - *f*ind inside files (a.k.a. "to *g*rep"); requires `ripgrep`
-- - `<Leader>fh` - *f*ind *h*elp tag
-- - `<Leader>fr` - *r*esume latest picker
--
-- See also:
-- - `:h MiniPick-overview` - overview of picker functionality
-- - `:h MiniPick-examples` - examples of common setups
-- - `:h MiniPick.builtin` and `:h MiniExtra.pickers` - available pickers;
--   Execute one either with Lua function, `:Pick <picker-name>` command, or
--   one of `<Leader>f` mappings defined in 'plugin/20_keymaps.lua'
local win_config = function()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.5 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end
later(function()
	require("mini.pick").setup({ window = { config = win_config } })
end)

-- Manage and expand snippets (templates for a frequently used text).
-- Typical workflow is to type snippet's (configurable) prefix and expand it
-- into a snippet session.
--
-- How to manage snippets:
-- - 'mini.snippets' itself doesn't come with preconfigured snippets. Instead there
--   is a flexible system of how snippets are prepared before expanding.
--   They can come from pre-defined path on disk, 'snippets/' directories inside
--   config or plugins, defined inside `setup()` call directly.
-- - This config, however, does come with snippet configuration:
--     - 'snippets/global.json' is a file with global snippets that will be
--       available in any buffer
--     - 'after/snippets/lua.json' defines personal snippets for Lua language
--     - 'friendly-snippets' plugin configured in 'plugin/40_plugins.lua' provides
--       a collection of language snippets
--
-- How to expand a snippet in Insert mode:
-- - If you know snippet's prefix, type it as a word and press `<C-j>`. Snippet's
--   body should be inserted instead of the prefix.
-- - If you don't remember snippet's prefix, type only part of it (or none at all)
--   and press `<C-j>`. It should show picker with all snippets that have prefixes
--   matching typed characters (or all snippets if none was typed).
--   Choose one and its body should be inserted instead of previously typed text.
--
-- How to navigate during snippet session:
-- - Snippets can contain tabstops - places for user to interactively adjust text.
--   Each tabstop is highlighted depending on session progression - whether tabstop
--   is current, was or was not visited. If tabstop doesn't yet have text, it is
--   visualized with special "ghost" inline text: • and ∎ by default.
-- - Type necessary text at current tabstop and navigate to next/previous one
--   by pressing `<C-l>` / `<C-h>`.
-- - Repeat previous step until you reach special final tabstop, usually denoted
--   by ∎ symbol. If you spotted a mistake in an earlier tabstop, navigate to it
--   and return back to the final tabstop.
-- - To end a snippet session when at final tabstop, keep typing or go into
--   Normal mode. To force end snippet session, press `<C-c>`.
--
-- See also:
-- - `:h MiniSnippets-overview` - overview of how module works
-- - `:h MiniSnippets-examples` - examples of common setups
-- - `:h MiniSnippets-session` - details about snippet session
-- - `:h MiniSnippets.gen_loader` - list of available loaders
later(function()
	-- Define language patterns to work better with 'friendly-snippets'
	local latex_patterns = { "latex/**/*.json", "**/latex.json" }
	local lang_patterns = {
		tex = latex_patterns,
		plaintex = latex_patterns,
		-- Recognize special injected language of markdown tree-sitter parser
		markdown_inline = { "markdown.json" },
	}

	local snippets = require("mini.snippets")
	local config_path = vim.fn.stdpath("config")
	snippets.setup({
		snippets = {
			-- Always load 'snippets/global.json' from config directory
			snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),
			-- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
			snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
		},
	})

	-- By default snippets available at cursor are not shown as candidates in
	-- 'mini.completion' menu. This requires a dedicated in-process LSP server
	-- that will provide them. To have that, uncomment next line (use `gcc`).
	-- MiniSnippets.start_lsp_server()
end)

-- Surround actions: add/delete/replace/find/highlight. Working with surroundings
-- is surprisingly common: surround word with quotes, replace `)` with `]`, etc.
-- This module comes with many built-in surroundings, each identified by a single
-- character. It searches only for surrounding that covers cursor and comes with
-- a special "next" / "last" versions of actions to search forward or backward
-- (just like 'mini.ai'). All text editing actions are dot-repeatable (see `:h .`).
--
-- Example usage (this may feel intimidating at first, but after practice it
-- becomes second nature during text editing):
-- - `saiw)` - *s*urround *a*dd for *i*nside *w*ord parenthesis (`)`)
-- - `sdf`   - *s*urround *d*elete *f*unction call (like `f(var)` -> `var`)
-- - `srb[`  - *s*urround *r*eplace *b*racket (any of [], (), {}) with padded `[`
-- - `sf*`   - *s*urround *f*ind right part of `*` pair (like bold in markdown)
-- - `shf`   - *s*urround *h*ighlight current *f*unction call
-- - `srn{{` - *s*urround *r*eplace *n*ext curly bracket `{` with padded `{`
-- - `sdl'`  - *s*urround *d*elete *l*ast quote pair (`'`)
-- - `vaWsa<Space>` - *v*isually select *a*round *W*ORD and *s*urround *a*dd
--                    spaces (`<Space>`)
--
-- See also:
-- - `:h MiniSurround-builtin-surroundings` - list of all supported surroundings
-- - `:h MiniSurround-surrounding-specification` - examples of custom surroundings
-- - `:h MiniSurround-vim-surround-config` - alternative set of action mappings
later(function()
	require("mini.surround").setup()
end)

-- Highlight and remove trailspace. Temporarily stops highlighting in Insert mode
-- to reduce noise when typing. Example usage:
-- - `<Leader>ot` - trim all trailing whitespace in a buffer
later(function()
	require("mini.trailspace").setup()
end)

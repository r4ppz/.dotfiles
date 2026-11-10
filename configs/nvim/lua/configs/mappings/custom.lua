local map = vim.keymap.set

--------------------------------------------------------
-- Personal preference ?!!
--------------------------------------------------------

-- Emacs style in insert mode :p
--
-- command line mode
map("c", "<C-a>", "<Home>", { desc = "Beginning of command line" })
map("c", "<C-b>", "<Left>", { desc = "Move backward" })
map("c", "<C-d>", "<Del>", { desc = "Delete character under cursor" })
map("c", "<C-e>", "<End>", { desc = "End of command line" })
map("c", "<C-f>", "<Right>", { desc = "Move forward" })
map("c", "<C-n>", "<Down>", { desc = "Next command history" })
map("c", "<C-p>", "<Up>", { desc = "Previous command history" })
map("c", "<M-b>", "<S-Left>", { desc = "Move backward one word" })
map("c", "<M-f>", "<S-Right>", { desc = "Move forward one word" })

-- insert mode
map("i", "<C-a>", "<Home>", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-b>", "<Left>", { desc = "Move backward" })
map("i", "<C-f>", "<Right>", { desc = "Move forward" })
map("i", "<C-n>", "<Down>", { desc = "Move down" })
map("i", "<C-p>", "<Up>", { desc = "Move up" })
map("i", "<C-d>", "<Del>", { desc = "Delete character under cursor" })
map("i", "<C-h>", "<BS>", { desc = "Delete character before cursor" })
map("i", "<M-b>", "<C-o>b", { desc = "Move backward one word" })
map("i", "<M-f>", "<C-o>e<C-o>a", { desc = "Move forward one word" })
map("i", "<C-k>", "<C-o>D", { desc = "Delete to end of line" })
map("i", "<C-u>", "<C-o>d0", { desc = "Delete to beginning of line" })
map("i", "<C-j>", "<CR>", { desc = "New line" })

-- Scroll half page and center
map("n", { "<S-Up>", "<C-u>" }, "<C-u>zz", { desc = "Scroll half a page up and center" })
map("n", { "<S-Down>", "<C-d>" }, "<C-d>zz", { desc = "Scroll half a page down and center" })
map("i", "<S-Up>", "<C-o><C-u><C-o>zz", { desc = "Scroll half a page up and center" })
map("i", "<S-Down>", "<C-o><C-d><C-o>zz", { desc = "Scroll half a page down and center" })

-- Move line Up/Down
map("n", { "<C-A-Up>", "<C-k>" }, ":m .-2<CR>==<C-l>", { desc = "Move line up" })
map("n", { "<C-A-Down>", "<C-j>" }, ":m .+1<CR>==<C-l>", { desc = "Move line down" })
map("v", { "<C-A-Up>", "<C-k>" }, ":m '<-2<CR>gv=gv<C-l>", { desc = "Move selection up" })
map("v", { "<C-A-Down>", "<C-j>" }, ":m '>+1<CR>gv=gv<C-l>", { desc = "Move selection down" })

-- Indent line
map("v", { "<", "<C-h>" }, "<gv", { desc = "Indent left and reselect" })
map("v", { ">", "<C-l>" }, ">gv", { desc = "Indent right and reselect" })

-- Ctrl+Up/Down scroll one line
map({ "n", "v" }, { "<C-Down>", "J" }, "<C-e>", { desc = "Scroll window down one line" })
map({ "n", "v" }, { "<C-Up>", "K" }, "<C-y>", { desc = "Scroll window up one line" })
map("i", "<C-Down>", "<C-o><C-e>", { desc = "Scroll window down one line in insert mode" })
map("i", "<C-Up>", "<C-o><C-y>", { desc = "Scroll window up one line in insert mode" })

-- Save only if there are changes
map({ "n", "v" }, "<C-s>", "<cmd>update<cr>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:update<CR>", { desc = "Save file" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map("n", "<M-Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

map("t", "<C-q>", "<C-\\><C-N>", { desc = "Escape terminal mode" })

-- Comment
map("n", "<C-_>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-_>", "gc", { desc = "toggle comment", remap = true })

-- Not needed now cause I use emacs on insert now
-- map("i", "<C-h>", "<Left>", { desc = "Move left" })
-- map("i", "<C-j>", "<Down>", { desc = "Move down" })
-- map("i", "<C-k>", "<Up>", { desc = "Move up" })
-- map("i", "<C-l>", "<Right>", { desc = "Move right" })

map("n", "<leader>q", "gqap", {
  desc = "Hard Wrap",
})

-- This is useful for wrapped lines
map("n", { "<Down>", "j" }, "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true,
  desc = "Move down by screen lines (or count lines)",
})
map("n", { "<Up>", "k" }, "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true,
  desc = "Move up by screen lines (or count lines)",
})
map("i", "<Down>", "<C-o>gj", {
  silent = true,
  desc = "Move down by screen lines in insert mode",
})
map("i", "<Up>", "<C-o>gk", {
  silent = true,
  desc = "Move up by screen lines in insert mode",
})

-- Next and previous using tab/Stab like n/N
map({ "n", "v", "o" }, { "<Tab>", "n" }, "nzz", {
  noremap = true,
  silent = true,
  desc = "Next search result and center",
})
map({ "n", "v", "o" }, { "<S-Tab>", "N" }, "Nzz", {
  noremap = true,
  silent = true,
  desc = "Previous search result and center",
})

--------------------------------------------------------
-- Weird remaps ?!?

-- Insert below and above
map("n", { "<M-Up>", "<M-k>" }, "O", { desc = "Insert above" })
map("n", { "<M-Down>", "<M-j>" }, "o", { desc = "Insert below" })
map("i", { "<M-Up>", "<M-k>" }, "<C-o>O", { desc = "Insert above" })
map("i", { "<M-Down>", "<M-j>" }, "<C-o>o", { desc = "Insert below" })

-- Undo and redo (this is like 10x better)
map("n", "<M-a>", "u", { desc = "Undo" })
map("n", "<M-d>", "<C-r>", { desc = "Redo" })
map("v", "<M-a>", "u", { desc = "Undo" })
map("v", "<M-d>", "<C-r>", { desc = "Redo" })
map("i", "<M-d>", "<Esc><C-r>", { desc = "Redo" })
map("i", "<M-a>", "<Esc>u", { desc = "Undo" })

-- Disable default undo/redo (this is too err prone)
map("n", "u", "<Nop>", { desc = "Disable default undo" })
map("n", "<C-r>", "<Nop>", { desc = "Disable default redo" })

-- Jump by paragraph while selecting
map("v", { "<S-Up>", "K" }, "{", { desc = "Jump to previous paragraph" })
map("v", { "<S-Down>", "J" }, "}", { desc = "Jump to next paragraph" })

-- Ctrl+Left/Right word navigation (like any other GUI's)
map({ "n", "v", "o" }, "<C-Left>", "b", {
  desc = "Move to the beginning of the word",
})
map({ "n", "v", "o" }, "<C-Right>", "e", {
  desc = "Move to the end of the word",
})
map("i", "<C-Left>", "<C-o>b", {
  desc = "Move to the beginning of the word in insert mode",
})
map("i", "<C-Right>", "<C-o>e<C-o>a", {
  desc = "Move to the end of the word in insert mode",
})
map({ "n", "v", "o" }, "<S-Right>", "E", {
  desc = "Move Right like E",
})
map({ "n", "v", "o" }, "<S-Left>", "B", {
  desc = "Move Left like B",
})
map("i", "<S-Left>", "<C-o>B", {
  desc = "Move to the beginning of the word like B in insert mode",
})
map("i", "<S-Right>", "<C-o>E<C-o>a", {
  desc = "Move to the end of the word like E in insert mode",
})

-- Jump last and first char of the line
map({ "n", "v" }, { "!", "gh" }, "0", {
  desc = "Jump to absolute first character of the line",
})
map({ "n", "v" }, { "@", "gl" }, "$", {
  desc = "Jump to absolute last character of line",
})
map({ "n", "v" }, { "g<Left>", "H", "<C-S-Left>" }, "^", {
  desc = "Jump to first non-blank character of the line",
})
map({ "n", "v" }, { "g<Right>", "L", "<C-S-Right>" }, "g_", {
  desc = "Jump to last non-blank character of line",
})

--------------------------------------------------------
-- Disabled/Change defaults cause why not
--------------------------------------------------------
map("n", "<C-z>", "<nop>", { desc = "Disable suspend" })
map("n", "ZZ", "<nop>", { desc = "Disable accidental save and quit (ZZ)" })
map("n", "ZQ", "<nop>", { desc = "Disable accidental quit (ZQ)" })

map({ "n", "v" }, "s", '"_s', { desc = "Substitute without yanking (visual)" })
map({ "n", "v" }, "S", '"_S', { desc = "Substitute line without yanking (normal)" })

map({ "n", "v" }, "q", "<Nop>", { desc = "Disable recording macro (q)" })
map({ "n", "v" }, "Q", "<Nop>", { desc = "Disable Ex mode (Q)" })

map("n", "p", "]p", { desc = "Paste and adjust indent" })
map("n", "P", "[p", { desc = "Paste before and adjust indent" })
map("v", "p", '"_dP', { desc = "Paste without yanking replaced text" })

map({ "n", "v" }, "c", '"_c', { desc = "Change text without yanking" })
map({ "n", "v" }, "C", '"_C', { desc = "Change to end of line without yanking" })

map({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
map({ "n", "v" }, "D", '"_D', { desc = "Delete to end of line without yanking" })

-- what the fuck am I doing?
map("n", "X", "D", { desc = "Cut line" })
-- map("n", "xx", "dd", { desc = "Cut line" })

-- Highlights the word without jumping to the next occurrence (smart-case)
map(
  "n",
  "#",
  [[<Cmd>let @/ = (expand('<cword>') =~# '\u' ? '\C' : '\c') . '\<' . expand('<cword>') . '\>'<CR><Cmd>set hlsearch<CR>]],
  {
    desc = "Highlight word (no jump, smart-case)",
  }
)

-- Highlights the visual selection (multiline, smart-case)
map(
  "x",
  "#",
  [["zy<Cmd>let @/ = (@z =~# '\u' ? '\C\V' : '\c\V') . substitute(escape(@z, '/\'), '\n', '\\n', 'g')<CR><Cmd>set hlsearch<CR>]],
  {
    desc = "Highlight selection (no jump, smart-case)",
  }
)

-- Hide the annoying error msg
map("n", "gx", function()
  pcall(function()
    vim.ui.open(vim.fn.expand("<cfile>"))
  end)
end, { desc = "Open URL under cursor" })

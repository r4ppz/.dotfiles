-- I use both vim and emacs style editing btw
-- and plus my wierd arrow centric remaps.

-- Most of these mappings will only work in modern terminal emulators.

require("configs.mappings.custom")
require("configs.mappings.lsp")
require("configs.mappings.utils")
require("configs.mappings.git")
require("configs.mappings.bufwin")

-- Concepts:
-- C = Control
-- S = Shift
-- M = Alt
-- Leader = Space
--
-- e.g.
-- C-S-Up = Ctrl+Shift+UpArrowKey
--
-- Modes:
-- n = normal
-- v = visual
-- i = insert
-- t = terminal

---------------------------------------------
-- SUMMARY
-- MAJOR CHANGES:
--
-- p = Paste only
-- y = Yank only
-- d = Delete only
-- x = Cut only
--
-- c, s, d, p = no yanking
-- I hate the idea of delete/everything is cut/copy.
--
-- Alt is underrated:
-- M-f = File Picker (Snacks)
-- M-g = Git Client (LazyGit)
-- M-e = File Manager (NvimTree)
-- M-c = LLM (CopilotChat)
-- M-v = Vertical Terminal
-- M-s = Horizontal Terminal
-- M-w = Floating Terminal
-- M-q = Close buffer
-- M-a = Undo
-- M-d = Redo
-- M-o/i = Incremental selection (using treesitter)
-- M-S-b = Task Manager (Btop)
-- M-S-d = Docker Client (Lazydocker)
--
-- Nice to have:
-- Copy all        = C-c
-- Select all      = C-a
-- Save (+Format)  = C-s
-- Comment         = C-/
--
-- LSP:
-- Reference              = gr
-- Definition             = gd
-- Implementation         = gi
-- Incremental Selection  = enter/M-o
-- more lsp stuff  = leader + l
--
-- ...and many more (leader, see mappings/ and plugins/)
--
-- Disabled default mappings/feature:
-- - Macros (Skill issue) - Not for me
-- - Shada (cleaner imo)
-- - f and t (used for picker and tabs)
-- - ctrl+r/u - I am used to my custom remap: M-a/d
--
-- Standard Vim motions/bindings still works fine (ciw, daw, yi(, ci{, etc.).
-- I mostly use vim bindingss, emacs on insert mode and sometimes arrowkeys just for the convenience
-- I try to not remove the default mappings as much as possible for compatibility.
--
-- System-wide rebinds (see: nixos/configuration.nix:282)
-- CapsLock = Esc
-- Ctrl+M = Enter

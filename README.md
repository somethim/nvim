# Neovim Config

Built on [LazyVim](https://lazyvim.github.io). Theme is managed by [Omarchy](https://github.com/basecamp/omarchy) and hot-reloads when you switch themes system-wide.

---

## Languages & Tooling

| Language | LSP | Formatter | Linter / Extra |
|---|---|---|---|
| **Go** | gopls | goimports + gofmt | golangci-lint, Delve DAP |
| **Rust** | rust-analyzer | rustfmt | Clippy (pedantic), codelldb DAP |
| **Python** | pyright | black | mypy, debugpy DAP |
| **TypeScript / JS** | vtsls | prettierd | eslint_d |
| **PHP / Laravel** | intelephense | pint (php-cs-fixer fallback) | Laravel stubs |
| **C / C++** | clangd | clang-format | GDB DAP |
| **Zig** | zls | zigfmt | — |
| **Terraform** | terraform-ls | terraform fmt | tflint |
| **Ansible** | ansible-ls | — | ansible-lint |
| **Docker** | dockerls | — | hadolint |
| **YAML** | yamlls | prettierd | yamllint |
| **SQL** | — | sqlfmt | sqlfluff, vim-dadbod UI |
| **Markdown** | — | prettier | render-markdown |
| **Tailwind CSS** | tailwindcss-ls | — | — |
| **TOML** | taplo | taplo | — |

---

## Custom Keymaps by Language

### Go  `<leader>G`
| Key | Action |
|---|---|
| `<leader>Gb` | Build (`go build ./...`) |
| `<leader>Gr` | Run (`go run .`) |
| `<leader>Gt` | Test all (`go test ./...`) |
| `<leader>Gi` | Organize imports |
| `<leader>Gd` | Debug test under cursor |
| `<leader>Gl` | Debug last test |

### Rust  `<leader>R`
Diagnostics come from **bacon-ls** (real-time `cargo clippy` with `-D clippy::pedantic -D clippy::nursery`), not rust-analyzer's checkOnSave. Squiggles update as you type. A per-crate `Cargo.toml` `[lints.clippy]` block overrides the global pedantic/nursery flags. Apply a clippy fix with **Alt+Enter** on the warning line.

| Key | Action |
|---|---|
| `<leader>Rr` | Runnables |
| `<leader>Rd` | Debuggables |
| `<leader>Rt` | Testables |
| `<leader>Re` | Expand macro |
| `<leader>Rc` | Open Cargo.toml |
| `<leader>Rp` | Parent module |
| `<leader>Rh` | Hover actions |
| `K` | Hover docs |

### Python  `<leader>P`
| Key | Action |
|---|---|
| `<leader>Po` | Organize imports |
| `<leader>Pr` | Restart Pyright |
| `<leader>Pt` | Debug test method |
| `<leader>PC` | Debug test class |
| `<leader>Ps` | Debug selection (visual) |

### TypeScript  `<leader>T`
| Key | Action |
|---|---|
| `<leader>To` | Organize imports |
| `<leader>Tr` | Remove unused |

### Terraform  `<leader>T` (in .tf files)
| Key | Action |
|---|---|
| `<leader>Tf` | Format file |
| `<leader>Ti` | Init |
| `<leader>Tv` | Validate |
| `<leader>Tp` | Plan |

### PHP  `<leader>L`
| Key | Action |
|---|---|
| `<leader>La` | Code actions |

### C / C++  `<leader>c`
| Key | Action |
|---|---|
| `<leader>ch` | Switch header ↔ source |
| `<leader>ci` | Symbol info |
| `<leader>ct` | Type hierarchy |

### Zig  `<leader>z`
| Key | Action |
|---|---|
| `<leader>zb` | Build |
| `<leader>zt` | Test |
| `<leader>zr` | Run file |
| `<leader>zf` | Format file |

### SQL / DB  `<leader>D`
| Key | Action |
|---|---|
| `<leader>Du` | Toggle DB UI (vim-dadbod) |
| `<leader>Da` | Add connection |

Connect via `:DB postgresql://user:pass@host/db` or set `g:db` for a default.

---

## Testing (neotest)  `<leader>n`

Works in Go, Rust, Python, TypeScript (vitest), PHP.

| Key | Action |
|---|---|
| `<leader>nt` | Run nearest test |
| `<leader>nf` | Run all tests in file |
| `<leader>na` | Run all tests in project |
| `<leader>nd` | Debug nearest test (DAP) |
| `<leader>ns` | Toggle test summary panel |
| `<leader>no` | Toggle output panel |
| `]t` | Jump to next failure |
| `[t` | Jump to prev failure |

---

## Editor Extras

### Harpoon  `<leader>h`
Fast file pinning — mark up to 4 files and jump to them instantly.

| Key | Action |
|---|---|
| `<leader>ha` | Add file to harpoon |
| `<leader>hh` | Open harpoon menu |
| `<leader>h1`–`h4` | Jump to pinned file 1–4 |

### Aerial  `<leader>cs`
Code outline — all symbols/functions in current file.

| Key | Action |
|---|---|
| `<leader>cs` | Toggle aerial outline |
| `{` / `}` | Jump prev / next symbol |

### Yanky  `<leader>p`
Clipboard ring — cycle through previous yanks when pasting.

| Key | Action |
|---|---|
| `<leader>p` | Paste from yank history |
| `]p` / `[p` | Cycle forward / back through yank ring after paste |

### Treesitter Context
Sticky function/class header at the top of the screen as you scroll. No key needed — always on.

### Inc-rename
Live preview of rename as you type. Replaces the default `<leader>cr`.

---

## Essential Neovim / LazyVim

### Navigation
| Key | Action |
|---|---|
| `<leader><space>` | Find files |
| `<leader>/` | Search in project (grep) |
| `<leader>,` | Switch buffer |
| `<leader>e` | File explorer (neo-tree) |
| `<C-h/j/k/l>` | Move between splits |
| `<leader>-` | Split window horizontally |
| `<leader>\|` | Split window vertically |

### LSP (any language)
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover docs |
| `<M-CR>` (Alt+Enter) | **Context menu / intentions** — quick-fixes, imports, refactors (JetBrains-style) |
| `<leader>ca` | Code actions (same menu) |
| `<leader>cq` | Auto-apply the quick-fix under the cursor |
| `<leader>cr` | Rename symbol (live preview) |
| `<leader>cf` | Format file |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>cd` | Line diagnostics |

### DAP (debugger)
| Key | Action |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue |
| `<leader>ds` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dr` | REPL |
| `<leader>du` | Toggle DAP UI |

### Editing
| Key | Action |
|---|---|
| `<leader>cf` | Format |
| `gcc` | Toggle line comment |
| `gc` + motion | Toggle comment over motion |
| `<leader>ur` | Toggle search highlights |
| `<C-s>` | Save file |
| `<leader>fn` | New file |

### Git
| Key | Action |
|---|---|
| `<leader>gg` | Lazygit |
| `<leader>gb` | Git blame line |
| `<leader>gB` | Open in browser |
| `<leader>gf` | Lazygit (current file) |
| `]h` / `[h` | Next / prev hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |

### Tabs & Buffers
| Key | Action |
|---|---|
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |

---

## Power Editing Cheatsheet

Things that are easy to forget but save a ton of time.

### Context menu / "do something here"  (JetBrains Alt+Enter)
| Key | Action |
|---|---|
| `<M-CR>` (Alt+Enter) | Open the action menu under the cursor — quick-fix, import, refactor, generate. Works in normal, visual **and** insert mode, in every language with an LSP. |
| `<leader>cq` | Skip the menu — auto-apply the obvious quick-fix for the diagnostic on the current line. |

If your terminal eats Alt+Enter, use `<leader>ca` (code actions) or `<leader>cq` instead.

### Edit many places at once (multi-cursor-style)
No multi-cursor plugin needed — these are native and faster once they click.

| Keys | What it does |
|---|---|
| `<C-v>` → move down → `I` text `<Esc>` | **Visual block insert**: type on the front of many lines at once (e.g. prefix a column). |
| `<C-v>` → move down → `A` text `<Esc>` | Same, but append after the selection on every line. |
| `<C-v>` → select block → `c` text `<Esc>` | Replace a column/block on every selected line simultaneously. |
| `<C-v>` → select block → `d` / `x` | Delete a vertical block (great for stripping a column). |
| `*` then `cgn` text `<Esc>`, then `.` `.` `.` | Change the word under the cursor, then hit `.` to repeat the change on each next occurrence — pseudo multi-cursor with confirmation. |
| `:%s/old/new/g` | Replace everywhere; add `c` (`/gc`) to confirm each. |
| `:%s/old/new/gc` over a visual range with `:'<,'>s/...` | Replace only inside the selection. |

### Comment many lines at once
| Keys | What it does |
|---|---|
| `gcc` | Toggle comment on the current line. |
| `gc` + motion | Comment a motion — e.g. `gcap` (paragraph), `gc3j` (3 lines down), `gcG` (to EOF). |
| Visual select → `gc` | Comment every selected line. `<C-v>`/`V` first, then `gc`. |
| `gco` / `gcO` | Add a comment line below / above and enter insert. |

### Jumping & motion
| Keys | What it does |
|---|---|
| `s` + 2 chars | **flash.nvim** — jump anywhere on screen by typing 2 chars of the target. |
| `$` / `0` / `^` | End of line / first column / first non-blank of line. |
| `A` | Jump to **EOL and enter insert** (append at end of line). `I` does the same at line start. |
| `G` / `gg` | End of file / top of file. |
| `<C-d>` / `<C-u>` | Half-page down / up. |
| `}` / `{` | Next / previous blank-line paragraph. |
| `%` | Jump to the matching bracket/paren/brace. |
| `ciw` / `ci"` / `ci(` | Change inner word / inside quotes / inside parens (mini.ai extends these). |
| `f<char>` / `t<char>` | Jump to / just-before the next `<char>` on the line; `;` repeats. |

### Misc time-savers
| Keys | What it does |
|---|---|
| `.` | Repeat the last change — the most underused key in vim. |
| `<C-o>` / `<C-i>` | Jump back / forward through your cursor-position history. |
| `qa` … `q` then `@a` | Record a macro into register `a`, replay with `@a`, `@@` to repeat. |
| `>>` / `<<` | Indent / dedent line; `=` re-indents a motion (`=ap`, `=G`). |
| `:earlier 5m` / `:later 5m` | Time-travel the undo tree. |

---

## Plugin Management

| Command | Action |
|---|---|
| `:Lazy` | Open plugin manager |
| `:Lazy sync` | Install / update / clean |
| `:Mason` | Open Mason (LSP/tool installer) |
| `:LazyHealth` | Check health |
| `:checkhealth` | Full health check |

---

## Theme

Theme is controlled by Omarchy — switch it with the Omarchy theme switcher and Neovim hot-reloads automatically. The active theme spec lives at `~/.config/omarchy/current/theme/neovim.lua`.

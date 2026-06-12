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
| **PHP / Laravel** | intelephense | php-cs-fixer | Laravel stubs |
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

### Rust  `<leader>r`
| Key | Action |
|---|---|
| `<leader>rr` | Runnables |
| `<leader>rd` | Debuggables |
| `<leader>rt` | Testables |
| `<leader>re` | Expand macro |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Parent module |
| `<leader>rh` | Hover actions |
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
| `<leader>ca` | Code actions |
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

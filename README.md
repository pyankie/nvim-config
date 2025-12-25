# 🚀 Neovim Configuration

Modern Neovim setup based on [LazyVim](https://github.com/LazyVim/LazyVim), inspired by [Takuya Matsuyama's dotfiles](https://github.com/craftzdog/dotfiles-public).

## Requirements

- Neovim >= 0.10.0
- Git, Node.js, Ripgrep
- A Nerd Font

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repo
git clone https://github.com/pyankie/nvim-config.git ~/.config/nvim

# Start Neovim (plugins install automatically)
nvim
```

## 📁 Project Structure

```
nvim/
├── init.lua                  # Entry point
├── lua/
│   ├── config/               # Core configuration
│   │   ├── autocmds.lua     # Auto commands
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Lazy.nvim setup
│   │   └── options.lua      # Vim options
│   ├── lib/                  # Shared libraries
│   │   └── icons.lua        # Icon definitions
│   ├── plugins/              # Plugin configurations
│   │   ├── colorscheme.lua  # Color themes
│   │   ├── lsp.lua          # LSP configuration
## Structure

```
lua/
├── config/      # Core config (options, keymaps, autocmds)
├── plugins/     # Plugin configurations
├── util/        # Utility functions
└── zpyankie/    # Custom modules
```---|------|-------------|
| `sh/sj/sk/sl` | Normal | Navigate between splits |
| `ss` | Normal | Horizontal split |
| `sv` | Normal | Vertical split |
| `sq` | Normal | Close split |
| `<Tab>` | Normal | Next tab |
## Key Mappings

Leader key: `<Space>`

**Essential:**
- `jk` - Exit insert mode
- `<Leader>w` - Save file
- `<Leader>ff` - Find files
- `<Leader>fg` - Grep search
- `<Leader>gg` - LazyGit

**Splits:**
- `ss`/`sv` - Split horizontal/vertical
- `sh`/`sj`/`sk`/`sl` - Navigate splits

**Tabs:**
- `te` - New tab
- `<Tab>`/`<S-Tab>` - Next/previous tab

See `lua/config/keymaps.lua` for all mappings.
  keys = {
    -- plugin keymaps
  },
}
```

### Modifying Keymaps

Edit `lua/config/keymaps.lua` to add or modify key mappings:

```lua
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<your-key>", "<your-command>", opts)
```

### Changing Options

Modify `lua/config/options.lua` to change Vim options:

```lua
vim.opt.option_name = value
```

## 🛠️ Language Support

### Pre-configured Languages

- **JavaScript/TypeScript** (tsserver, eslint, prettier)
- **Lua** (lua_ls, stylua)
- **Go** (gopls)
- **C/C++** (clangd, clang-format)
- **Java** (jdtls)
- **Rust** (rust-analyzer)
- **Python** (pyright)
- **HTML/CSS** (html, cssls, emmet_ls)
- **Tailwind CSS** (tailwindcss)

### Adding New Languages

1. Open Mason: `<Space>cm`
2. Install required LSP server
## Documentation

- **[QUICK_START.md](docs/QUICK_START.md)** - Quick reference guide
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contribution guidelines
- **[PLUGIN_ORGANIZATION.md](docs/PLUGIN_ORGANIZATION.md)** - Plugin structure

## License

MIT License - see [LICENSE](LICENSE) for details.
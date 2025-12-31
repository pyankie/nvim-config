# 🚀 Personal Neovim Configuration

A modern, modular, and highly customizable Neovim configuration built with [LazyVim](https://github.com/LazyVim/LazyVim) and inspired by [Takuya Matsuyama's setup](https://github.com/craftzdog/dotfiles-public/tree/master/.config/nvim).

![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg?style=flat-square&logo=neovim)
![Lua](https://img.shields.io/badge/Lua-5.1+-blue.svg?style=flat-square&logo=lua)
![LazyVim](https://img.shields.io/badge/LazyVim-Latest-purple.svg?style=flat-square)

## ✨ Features

- 🎨 **Multiple Colorschemes**: Solarized Osaka, Ayu, Night Owl, Oh Lucy, Horizon, and more
- 🧠 **AI Integration**: GitHub Copilot with chat support
- 📦 **Plugin Management**: Lazy.nvim for fast, efficient plugin loading
- 🔍 **Enhanced Navigation**: Telescope, Flash.nvim, and Neo-tree
- 💻 **LSP Support**: Full language server protocol integration for multiple languages
- 🎯 **Smart Completion**: Blink.cmp for blazing-fast completions
- 🔧 **Developer Tools**: LazyGit, code runner, terminal integration
- 📝 **Markdown Support**: Enhanced markdown editing and preview
- 🎓 **LeetCode Integration**: Solve coding problems directly in Neovim
- 🔄 **Session Management**: Auto-save and restore sessions

## 📋 Requirements

- **Neovim** >= 0.10.0
- **Git** >= 2.19.0
- **Node.js** >= 18.x (for LSP servers)
- **Ripgrep** (for Telescope grep)
- **A Nerd Font** (recommended: JetBrains Mono Nerd Font, Fira Code Nerd Font)
- **C Compiler** (for Treesitter)
- **Python 3** (optional, for some plugins)

## 🚀 Installation

### Quick Start

1. **Backup existing Neovim configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/pyankie/nvim-config.git ~/.config/nvim
   ```

3. **Launch Neovim**:
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins on first launch.

4. **Install LSP servers and tools**:
   - Press `<space>` + `c` + `m` to open Mason
   - Or run `:Mason` and install required language servers

### Post-Installation

After installation, restart Neovim to ensure all plugins are properly loaded.

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
│   │   ├── ui.lua           # UI plugins
│   │   ├── editor.lua       # Editor enhancements
│   │   ├── coding.lua       # Coding tools
│   │   └── ...              # Other plugin configs
│   ├── util/                 # Utility functions
│   │   └── debug.lua        # Debug utilities
│   └── zpyankie/             # Custom modules
│       ├── hsl.lua          # HSL color utilities
│       └── lsp.lua          # Custom LSP helpers
├── stylua.toml              # Stylua formatter config
├── lazyvim.json             # LazyVim extras config
└── README.md                # This file
```

## ⌨️ Key Mappings

### General

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>` | Normal | Leader key |
| `jk` | Insert | Exit insert mode |
| `<Leader>w` | Normal | Save file |
| `<Leader>nh` | Normal | Clear search highlights |

### Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `sh/sj/sk/sl` | Normal | Navigate between splits |
| `ss` | Normal | Horizontal split |
| `sv` | Normal | Vertical split |
| `sq` | Normal | Close split |
| `<Tab>` | Normal | Next tab |
| `<S-Tab>` | Normal | Previous tab |
| `te` | Normal | New tab |
| `tq` | Normal | Close tab |

### Editing

| Key | Mode | Description |
|-----|------|-------------|
| `<Leader>p` | Normal/Visual | Paste from yank register |
| `<Leader>d` | Normal/Visual | Delete without yanking |
| `<Leader>c` | Normal/Visual | Change without yanking |
| `<Alt-Up/Down>` | Normal/Insert/Visual | Move lines up/down |
| `+/-` | Normal | Increment/decrement number |

### Window Management

| Key | Mode | Description |
|-----|------|-------------|
| `<C-w><arrows>` | Normal | Resize window |
| `<Leader>sm` | Normal | Maximize/minimize split (vim-maximizer) |

### LSP & Code

| Key | Mode | Description |
|-----|------|-------------|
| `<C-j>` | Normal | Go to next diagnostic |
| `<Leader>r` | Normal | Replace hex with HSL (custom) |
| `<Leader>i` | Normal | Toggle inlay hints |
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references |
| `K` | Normal | Hover documentation |

### Git

| Key | Mode | Description |
|-----|------|-------------|
| `<Leader>gb` | Normal | Git blame |
| `<Leader>go` | Normal | Open in browser |
| `<Leader>gg` | Normal | LazyGit |

### Search & Files

| Key | Mode | Description |
|-----|------|-------------|
| `<Leader>ff` | Normal | Find files |
| `<Leader>fg` | Normal | Grep search |
| `<Leader>fb` | Normal | File browser |
| `s` | Normal/Visual | Flash jump |
| `S` | Normal/Visual | Flash treesitter |

## 🎨 Colorschemes

This configuration includes multiple colorschemes:

- **Solarized Osaka** (default) - Modern Solarized theme
- **Ayu** - Simple, bright, and elegant
- **Night Owl** - Theme for the night owls
- **Oh Lucy** - Warm and elegant
- **Horizon** - Dark theme with bright colors
- **Retro Theme** - Nostalgic retro vibes

Switch colorschemes with: `:colorscheme <name>`

## 🔧 Customization

### Adding New Plugins

Create a new file in `lua/plugins/` following this structure:

```lua
return {
  "author/plugin-name",
  event = "VeryLazy", -- or other lazy-loading events
  dependencies = {
    -- plugin dependencies
  },
  opts = {
    -- plugin options
  },
  config = function()
    -- plugin configuration
  end,
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
3. Or add to `lua/plugins/lsp.lua`:

```lua
opts = function(_, opts)
  vim.list_extend(opts.ensure_installed, {
    "your-lsp-server",
    "your-formatter",
    "your-linter",
  })
end
```

## 📚 Plugin Highlights

### Core Plugins

- **[LazyVim](https://github.com/LazyVim/LazyVim)** - Base configuration
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting

### UI Enhancements

- **[noice.nvim](https://github.com/folke/noice.nvim)** - Better UI for messages and cmdline
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer/tab line
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Status line
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - File explorer

### Productivity

- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Enhanced navigation
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keymap popup
- **[auto-session](https://github.com/rmagatti/auto-session)** - Session management

### AI & Coding

- **[copilot.vim](https://github.com/github/copilot.vim)** - GitHub Copilot
- **[CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)** - Chat with Copilot
- **[blink.cmp](https://github.com/Saghen/blink.cmp)** - Completion engine
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto pairs

## 🐛 Troubleshooting

### Plugins not loading

```bash
# Clear cache and reinstall
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
nvim
```

### LSP not working

1. Check if LSP server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Check logs: `:messages`

### Slow startup

1. Profile plugins: `:Lazy profile`
2. Check startup time: `nvim --startuptime startup.log`

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Code Style

- Use [Stylua](https://github.com/JohnnyMorganz/StyLua) for Lua formatting
- Follow modular structure: one plugin per file
- Add comments for complex configurations
- Keep files focused and DRY

## 📖 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [LazyVim Documentation](https://lazyvim.github.io/)
- [Takuya's Dotfiles](https://github.com/craftzdog/dotfiles-public)
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)

## 📄 License

This configuration is available under the MIT License. See [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- [LazyVim](https://github.com/LazyVim/LazyVim) by [folke](https://github.com/folke)
- [Takuya Matsuyama](https://github.com/craftzdog) for inspiration
- The amazing Neovim community

---

**Made with ❤️ and Neovim**


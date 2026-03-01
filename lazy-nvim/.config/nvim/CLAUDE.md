# CLAUDE.md

## Architecture

### Entry Point

- `init.lua` - Main entry point that bootstraps lazy.nvim by requiring `config.lazy`

### Configuration Files (`lua/config/`)

All config files are auto-loaded in the following order:

- `lua/config/lazy.lua` - Lazy.nvim bootstrap and setup, including plugin specification
- `lua/config/options.lua` - Neovim options (merged with LazyVim defaults)
- `lua/config/keymaps.lua` - Custom keymaps (merged with LazyVim defaults)
- `lua/config/autocmds.lua` - Autocommands (merged with LazyVim defaults)

### Plugin Architecture
- Plugin Directory: `lua/plugins/` - individual plugin configurations
- LazyVim Extras: Pre-configured langauge support for Go, Python, TypeScript, Docker, etc.

### Lazy.nvim Setup

- Plugin defaults load immediately (`lazy = false` by default for custom plugins)
- Version tracking disabled (`version = false`) - always uses latest git commits
- Plugin update checker enabled (no notifications)
- Default colorscheme fallbacks: `tokyonight`, `habamax`

## Code Style

Defined in `stylua.toml`:
- Indent type: Spaces
- Indent width: 2
- Column width: 120

Run formatting with:
```bash
stylua lua/
```

## Common Operations

### Update plugins
In Neovim: `:Lazy update`

### Install a new plugin
Add a spec table to a new or existing file in `lua/plugins/`:
```lua
return {
  {
    "author/plugin-name",
    opts = { ... },
  },
}
```

### Disable a LazyVim plugin
```lua
return {
  { "LazyVim/plugin-name", enabled = false },
}
```

### Configure an existing LazyVim plugin
```lua
return {
  {
    "LazyVim/plugin-name",
    opts = function(_, opts)
      -- modify opts
    end,
  },
}
```

## Key Files

- `lazy-lock.json` - Plugin version lockfile (commit reference)
- `lazyvim.json` - LazyVim configuration state and extras list
- `.gitignore` - Generated `lazy-lock.json` is tracked

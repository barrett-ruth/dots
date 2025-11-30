# Dynamic Theme System Setup

A unified theme system that updates Neovim, FZF, ripgrep, and system appearance from a single command.

## Overview

Running `theme gruvbox` instantly updates:
- All Neovim instances (via sockets)
- FZF colors in shell and Neovim
- Ripgrep colors
- macOS system appearance (light/dark)
- tmux colors (if configured)

## Architecture

The system uses symlinks and mtime checks for efficiency:
- Theme files contain color definitions
- Symlinks point to current theme
- Shell precmd hooks check for changes
- Neovim instances receive direct signals

## Step-by-Step Implementation

### 1. Create Theme Files

#### FZF Themes
Create color files in `~/.config/fzf/themes/`:

`~/.config/fzf/themes/gruvbox`:
```
--color=fg:#ebdbb2,bg:#282828,hl:#fabd2f --color=fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color=info:#83a598,prompt:#fb4934,pointer:#b8bb26,marker:#fe8019,spinner:#8ec07c,header:#928374
```

`~/.config/fzf/themes/daylight`:
```
--color=fg:#000000,bg:#ffffff,hl:#0000ff --color=fg+:#000000,bg+:#e0e0e0,hl+:#0000ff --color=info:#008000,prompt:#ff0000,pointer:#800080,marker:#ff8c00,spinner:#008080,header:#808080
```

`~/.config/fzf/themes/midnight`:
```
--color=fg:#c0c0c0,bg:#000033,hl:#00ffff --color=fg+:#ffffff,bg+:#000066,hl+:#00ffff --color=info:#ffff00,prompt:#ff00ff,pointer:#00ff00,marker:#ffa500,spinner:#00bfff,header:#696969
```

#### Ripgrep Configuration
Create base config in `~/.config/rg/config`:
```
--column
--no-heading
--smart-case
--no-follow
--glob=!pnpm-lock.yaml
--glob=!*.json
--glob=!venv/
--glob=!pyenv/
--no-messages
```

Create color files in `~/.config/rg/colors/`:

`~/.config/rg/colors/gruvbox`:
```
--color=always
--colors=line:style:nobold
--colors=line:fg:242
--colors=match:fg:yellow
--colors=match:style:bold
--colors=path:fg:cyan
```

`~/.config/rg/colors/daylight`:
```
--color=always
--colors=line:style:nobold
--colors=line:fg:8
--colors=match:fg:red
--colors=match:style:bold
--colors=path:fg:magenta
```

`~/.config/rg/colors/midnight`:
```
--color=always
--colors=line:style:nobold
--colors=line:fg:242
--colors=match:fg:green
--colors=match:style:bold
--colors=path:fg:blue
```

### 2. Setup Neovim Integration

#### Add Socket Server
In `~/.config/nvim/init.lua`, add after lazy.nvim setup:
```lua
local socket_path = string.format('/tmp/nvim-%d.sock', vim.fn.getpid())
vim.fn.serverstart(socket_path)
```

#### Create Reload Module
Create `~/.config/nvim/lua/fzf_theme.lua`:
```lua
local M = {}

function M.reload_colors()
    local theme_file = vim.fn.expand('~/.config/fzf/themes/theme')
    local file = io.open(theme_file, 'r')
    if not file then return end

    local content = file:read('*a')
    file:close()

    local colors = {}
    for color_spec in content:gmatch('--color=([^%s]+)') do
        for key, value in color_spec:gmatch('([^:,]+):([^,]+)') do
            colors[key] = value
        end
    end

    require('fzf-lua').setup({ fzf_colors = colors })
end

return M
```

#### Update fzf-lua Plugin
In `~/.config/nvim/lua/plugins/fzf.lua`, add at the end of config function:
```lua
require('fzf_theme').reload_colors()
```

### 3. Configure Shell Integration

Add to `~/.config/zsh/.zprofile`:

```bash
_fzf_theme_precmd() {
    local theme_file="$XDG_CONFIG_HOME/fzf/themes/theme"
    local theme_target=$(readlink "$theme_file" 2>/dev/null)

    if [[ "$theme_target" != "$_FZF_THEME_TARGET" ]]; then
        _FZF_THEME_TARGET="$theme_target"

        if [[ -r "$theme_file" ]]; then
            local colors=$(cat "$theme_file")
            export FZF_DEFAULT_OPTS="--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --bind=ctrl-u:half-page-up --bind=ctrl-d:half-page-down --no-scrollbar --no-info $colors"
        fi
    fi
}

_rg_theme_precmd() {
    local config="$XDG_CONFIG_HOME/rg/config"
    local colors="$XDG_CONFIG_HOME/rg/colors/theme"
    local combined="$XDG_CONFIG_HOME/rg/current"

    local config_mtime=$(stat -f %m "$config" 2>/dev/null)  # Linux: stat -c %Y
    local colors_target=$(readlink "$colors" 2>/dev/null)
    local check="${config_mtime}:${colors_target}"

    if [[ "$check" != "$_RG_CHECK" ]]; then
        _RG_CHECK="$check"
        test -f "$config" && test -f "$colors" && { cat "$config"; echo; cat "$colors"; } > "$combined"
    fi

    test -f "$combined" && export RIPGREP_CONFIG_PATH="$combined"
}

autoload -U add-zsh-hook
add-zsh-hook precmd _fzf_theme_precmd
add-zsh-hook precmd _rg_theme_precmd

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/current"
```

### 4. Create Theme Script

Create `~/.local/bin/scripts/theme`:
```bash
#!/bin/sh

themes="daylight
gruvbox
midnight"

as_list="$(printf "%s\n" "$themes" | awk 'NF{printf "\"%s\",", $0}' | sed 's/,$//')"

case "$(uname)" in
Linux)
  if [ -n "$1" ]; then
    theme="$1"
  else
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      theme="$(printf "%s\n" "$themes" | rofi -dmenu -p 'theme')"
    else
      theme="$(printf "%s\n" "$themes" | dmenu -p 'theme: ')"
    fi
  fi
  ;;
Darwin)
  if [ -n "$1" ]; then
    theme="$1"
  else
    theme="$(
      osascript <<EOF
set theList to {$as_list}

set chosenTheme to (choose from list theList ¬
  with title "Theme" ¬
  with prompt "Pick a theme" ¬
  OK button name "Apply" ¬
  cancel button name "Cancel" ¬
  without empty selection allowed)

if chosenTheme is false then
  return ""
else
  return item 1 of chosenTheme
end if
EOF
    )"
  fi
  ;;
*)
  exit 1
  ;;
esac

[ -z "$theme" ] && exit 1

test -d "$XDG_CONFIG_HOME/fzf/themes" && ln -sf "$XDG_CONFIG_HOME/fzf/themes/$theme" "$XDG_CONFIG_HOME/fzf/themes/theme"
test -d "$XDG_CONFIG_HOME/rg/colors" && ln -sf "$XDG_CONFIG_HOME/rg/colors/$theme" "$XDG_CONFIG_HOME/rg/colors/theme"

test -f ~/.zshenv && sed -i '' "s|^\(export THEME=\).*|\1$theme|" ~/.zshenv  # Linux: sed -i

if command -v tmux >/dev/null 2>&1; then
  test -f "$XDG_CONFIG_HOME/tmux/themes/$theme.tmux" && ln -sf "$XDG_CONFIG_HOME/tmux/themes/$theme.tmux" "$XDG_CONFIG_HOME/tmux/themes/theme.tmux"
  test -f "$XDG_CONFIG_HOME/tmux/themes/$theme.tmux" && tmux source-file "$XDG_CONFIG_HOME/tmux/themes/$theme.tmux"
  tmux refresh-client -S 2>/dev/null || true
fi

for socket in /tmp/nvim-*.sock; do
  test -S "$socket" && nvim --server "$socket" --remote-expr "v:lua.require('fzf_theme').reload_colors()" >/dev/null 2>&1 || true
done

case "$(uname)" in
Darwin)
  case "$theme" in
  daylight)
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false' 2>/dev/null || true
    ;;
  gruvbox|midnight)
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true' 2>/dev/null || true
    ;;
  esac
  ;;
esac
```

### 5. Initialize Symlinks

Run once to create initial symlinks:
```bash
cd ~/.config/fzf/themes && ln -sf midnight theme
cd ~/.config/rg/colors && ln -sf midnight theme
{ cat ~/.config/rg/config; echo; cat ~/.config/rg/colors/theme; } > ~/.config/rg/current
```

## Linux Porting Notes

### Platform Differences

1. **stat command**:
   - macOS: `stat -f %m`
   - Linux: `stat -c %Y`

2. **sed in-place**:
   - macOS: `sed -i ''`
   - Linux: `sed -i`

3. **Remove macOS-specific**:
   - Remove osascript appearance switching
   - UI picker already has Linux support (rofi/dmenu)

### Quick Linux Adaptation

In `.zprofile`, replace all:
- `stat -f %m` → `stat -c %Y`

In `theme` script:
- `sed -i ''` → `sed -i`
- Remove the Darwin appearance switching block

## Testing

1. Start a new shell: `source ~/.config/zsh/.zprofile`
2. Open Neovim: `nvim &`
3. Switch theme: `theme daylight`
4. Verify:
   - macOS appearance changes (macOS only)
   - Press Enter for new prompt
   - `rg test` shows daylight colors
   - `fzf` shows daylight colors
   - Neovim fzf-lua shows daylight colors

## File Structure Summary

```
~/.config/
├── fzf/
│   └── themes/
│       ├── gruvbox
│       ├── daylight
│       ├── midnight
│       └── theme → midnight (symlink)
├── rg/
│   ├── config (base settings)
│   ├── current (generated combined)
│   └── colors/
│       ├── gruvbox
│       ├── daylight
│       ├── midnight
│       └── theme → midnight (symlink)
├── nvim/
│   ├── init.lua (socket server)
│   └── lua/
│       ├── fzf_theme.lua (reload module)
│       └── plugins/
│           └── fzf.lua (uses fzf_theme)
└── zsh/
    └── .zprofile (precmd hooks)

~/.local/bin/scripts/
└── theme (master control script)
```

## How It Works

1. `theme gruvbox` updates symlinks and signals all tools
2. Neovim instances receive socket signal, reload immediately
3. Next shell prompt triggers precmd hooks:
   - FZF: Sources theme file if mtime changed
   - Ripgrep: Regenerates config if symlink target changed
4. All tools use new colors automatically

The system is efficient - only regenerates when files actually change, using mtime and readlink checks.
# refmenu

A wofi-driven reference menu for the terminal commands you keep forgetting and
your live Hyprland keybinds. Omarchy-style popup, but instead of *running*
things it's a quick read-only cheat sheet.

Press your keybind → pick **Commands** or **Hotkeys** → drill down. Selecting an
entry just shows it. Nothing is copied, typed, or executed.

```
refmenu
├── Commands         (from data/*.cmds)
│   ├── pacman       → install/remove, update, search, maintenance…
│   ├── systemctl    → service control, boot, logs…
│   ├── git          → commit, branch, remote, undo…
│   └── paru         → AUR install/update/search…
└── Hotkeys          (parsed live from ~/.config/hypr/hyprland.conf)
```

## Install

```sh
git clone https://github.com/<you>/refmenu.git
cd refmenu
./install.sh
```

This drops `refmenu` in `~/.local/bin` and the command data in
`~/.local/share/refmenu/data`. Make sure `~/.local/bin` is on your `PATH`.

Requires **wofi** (`sudo pacman -S wofi`).

### Bind it in Hyprland

```ini
bind = $mainMod, K, exec, refmenu
```

## Usage

```sh
refmenu            # main menu
refmenu commands   # jump straight to commands
refmenu hotkeys    # jump straight to live keybinds
refmenu --help
```

## Adding your own commands

Each tool is one file: `data/<tool>.cmds`.

- The first `# ` line is the tool's short description (shown in the tool list).
- `## Header` lines create section dividers (optional).
- Every other line is `command<TAB>description` — **a real tab between them.**

```
# Container and image manager
## Containers
docker ps	List running containers
docker ps -a	List all containers
## Images
docker images	List local images
docker pull <img>	Download an image
```

Drop the file in `~/.local/share/refmenu/data/` (or in the repo's `data/` then
re-run `./install.sh`). It shows up automatically — no code changes.

## Config

| Env var | Default | Purpose |
|---|---|---|
| `REFMENU_DATA_DIR` | `~/.local/share/refmenu/data` | command data location |
| `REFMENU_HYPR_CONF` | `~/.config/hypr/hyprland.conf` | which config to parse |

## Uninstall

```sh
./uninstall.sh
```

## Notes on the Hyprland parser

It reads `bind`, `bindm`, `binde`, `bindl`, `bindr` lines, strips trailing
comments, and resolves `$mainMod`-style variables defined in the same file.
Because it parses on every launch, edits to your config show up instantly.

## License

MIT — see [LICENSE](LICENSE).

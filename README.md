# dotfiles

> Here be thy dotfiles.
> A collection of incantations, symlinks, and shell spells, forged in the fires
> of frustration and optimised through far too many late nights.
> Tread carefully, adventurer — what lies within may summon tiling windows,
> whisper zsh aliases, and open portals to the neovim void.

## overview

| | Linux | Mac |
|---|---|---|
| **Machine** | Mini-ITX desktop: [Jonsbo N3](https://www.jonsbo.com/en/products/N3.html), Intel Core i5-12400; 2016 13-inch MacBook Pro | [MacBook Pro](https://www.apple.com/au/macbook-pro/) |
| **OS** | [Fedora](https://getfedora.org/) | macOS |
| **WM** | [Hyprland](https://hypr.land/) + [Quickshell](https://quickshell.org/) | [AeroSpace](https://github.com/nikitabobko/AeroSpace) |

- **Dotfile Manager**: [GNU Stow](https://www.gnu.org/software/stow/)
- **Shell**: [zsh](https://wiki.archlinux.org/index.php/Zsh) + [znap](https://github.com/marlonrichert/zsh-snap)
- **Terminal**: [Ghostty](https://ghostty.org/)
- **Editor**: [Neovim](https://neovim.io/) + [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Multiplexer**: [tmux](https://github.com/tmux/tmux) + [tpm](https://github.com/tmux-plugins/tpm); [herdr](https://herdr.dev) for agent sessions
- **Todos**: [shepherd](https://github.com/jwarykowski/shepherd) todo board — `<leader>T` in nvim via [nvim-shepherd](https://github.com/jwarykowski/nvim-shepherd)
- **RSS**: [newsboat](https://newsboat.org/)
- **Theme**: [lackluster](https://github.com/slugbyte/lackluster.nvim) (nvim, ghostty, tmux, btop, delta)
- **Font**: [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono/)
- **Keyboards**: [ZSA Moonlander](https://www.zsa.io/moonlander) and [ZSA Voyager](https://www.zsa.io/voyager) (see [keyboards](#keyboards))

## toolchain

```
 ┌──────────────────────────────────────────────────────────────────────────────┐
 │ Moonlander · Voyager (Oryx) ── home-row mods · symbols/nav/media layers      │
 └───────────────────────────────────┬──────────────────────────────────────────┘
      Fedora · Hyprland + Quickshell │  macOS · AeroSpace + borders
 ┌───────────────────────────────────▼──────────────────────────────────────────┐
 │ Ghostty ── lackluster theme · Berkeley Mono                                  │
 └───────────────────────────────────┬──────────────────────────────────────────┘
 ┌───────────────────────────────────▼──────────────────────────────────────────┐
 │ herdr ── tabs: claude · nvim · lazygit · shell      (tmux + tpm fallback)    │
 │   plugins: herdr-plus · vim-herdr-navigation · herdr-lazy · shepherd         │
 └───────────────────────────────────┬──────────────────────────────────────────┘
 ┌──────────────────┬────────────────┴─────────┬────────────────────────────────┐
 │ zsh + znap       │ nvim (lazy.nvim)         │ git                            │
 │  pure prompt     │  snacks picker/lazygit   │  delta · histogram · zdiff3    │
 │  autosuggest     │  blink.cmp · mini.*      │  gpg sign · work includeIf     │
 │  syntax-hl       │  mason + lspconfig       │  lazygit · gh                  │
 │  substring hist  │  conform · treesitter    │  ~90 aliases + git_main_branch │
 │  zoxide · fzf-tab│  oil · trouble · neotest │                                │
 │  direnv · fnm    │  shepherd todo board     │                                │
 └──────────────────┴──────────────────────────┴────────────────────────────────┘
   CLI: eza · bat · ripgrep · fd · fzf · yazi · btop · newsboat · jq · uv · tldr
 ┌──────────────────────────────────────────────────────────────────────────────┐
 │ ~/dotfiles ── stow --no-folding:  common/ + linux/ | mac/   → $HOME          │
 │   install.sh [--packages|--adopt|--profile] · scripts/install-packages-*     │
 │   ~/.local/bin: update · cleanup · systemctl-* · disk-report · screenrecord  │
 │   CI: shellcheck · stylua · luacheck · zsh -n · qmllint                      │
 └──────────────────────────────────────────────────────────────────────────────┘
```

## keyboards

Both layouts live on Oryx (not in this repo) and share the same idea:
home-row mods (`S D F` / `J K L` hold for Ctrl Alt Gui), `A` / `;` hold for
symbols, `Space` hold for navigation and a toggled media layer.

`/x` = tap / hold `x` · `MO(n)` hold layer · `TG(n)` toggle layer ·
`▽` transparent · `·` nothing · `C- S- A- G-` = Ctrl Shift Alt Gui

### moonlander

[Layout on Oryx](https://configure.zsa.io/moonlander/layouts/BO0Dw/latest).
A vim-motion bottom row: `<` `0` on the left, `$` `>` on the right. The
`C-a` / `C-f` thumb keys are grep and git-file pickers in both nvim (snacks)
and zsh (fzf).

```
── 0: qwerty ─────────────────────────────────────────────────────────────────
 TG(2)   1      2      3      4      5     Bri-  │  Bri+   6      7      8      9      0     Boot
 Tab     Q      W      E      R      T     Paste │  Undo   Y      U      I      O      P     Del
 Esc   A/MO1  S/Ctl  D/Alt  F/Gui    G     Copy  │ S-Undo  H    J/Gui  K/Alt  L/Ctl ;/MO1   Bksp
  _      Z      X      C      V      B           │         N      M      ,      .      /      :
  ▽      ▽      ▽      <      0                  │                $      >      ▽      ▽      ▽
                           [Play]                │               [Lock C-A-G-L]
                     Spc/MO3   /Sft   C-a        │   C-f    /Sft   Enter

── 1: symbols  (hold A or ;) ──────────────────────────────────────────────────
  ▽     F1     F2     F3     F4     F5      ▽    │   ▽     F6     F7     F8     F9    F10    F11
  <      !      @      {      }      |      :    │   "      +      7      8      9      *      >
  ▽      ·      $      (      )      `      ;    │   '      -      4      5      6      ·      ▽
  ▽      %      ^      [      ]      ~           │         &      1      2      3      \      =
  ▽      ▽      ▽      ▽      #                  │                0      ▽      ▽      ▽      ▽

── 2: media  (toggle with TG(2), top-left) ────────────────────────────────────
  ·   (all other keys ▽)                         │  RGB
                            [Stop]               │                [Stop]
                       Vol-   Vol+   Mute        │   Play   Prev   Next

── 3: navi  (hold Space) ──────────────────────────────────────────────────────
  ▽      ▽    /S-Ctl /S-Alt   ▽      ▽      ▽    │   ▽      ▽      ▽      ▽      ▽      ▽      ▽
  ▽      ▽     /Ctl   /Alt    ▽      ▽      ▽    │   ▽      ←      ↓      ↑      →      ▽      ▽
```

### voyager

[Layout on Oryx](https://configure.zsa.io/voyager/layouts/nJLJb/latest).
Fewer keys, so the thumbs are plain Shift and line start / end in nvim is
`Space`+`Y` / `Space`+`O` (Home / End work as `0` / `$`, also after an
operator: `d<End>`). The top-right key sends `C-A-G-Space`.

```
── 0: qwerty ──────────────────────────────────────────────────────
 TG(3)   1      2      3      4      5    │   6      7      8      9      0   C-A-G-Spc
 Tab     Q      W      E      R      T    │   Y      U      I      O      P     Del
 Esc   A/MO1  S/Ctl  D/Alt  F/Gui    G    │   H    J/Gui  K/Alt  L/Ctl ;/MO1   Bksp
  _      Z      X      C      V      B    │   N      M      ,      .      /      :
                        Spc/MO2   Sft     │  Sft   Enter

── 1: symbols  (hold A or ;) ──────────────────────────────────────
  &     F1     F2     F3     F4     F5    │  F6     F7     F8     F9    F10    F11
  <      !      @      {      }      |    │   +      7      8      9      *      >
  ·      ·      $      (      )      `    │   -      4      5      6      ·      ·
  _      %      ^      [      ]      ~    │   '      1      2      3      \      =
                          ▽       ▽       │   ▽      0

── 2: nav  (hold Space) ───────────────────────────────────────────
  ·      ·      ·      ·      ·      ·    │   ▽      ▽      ▽      ▽      ▽      ·
  ▽      ▽    /S-Ctl /S-Alt   ·      ▽    │ Home   PgDn   PgUp   End     ▽      ▽
  ▽      ·     /Ctl   /Alt    ·      ▽    │   ←      ↓      ↑      →      ▽      ▽
  ▽      ▽      ▽      ·      ·      ·    │   ▽      ·      ·      ▽      ▽      ▽
                           ·      ▽       │   ▽      ▽

── 3: media  (toggle with TG(3), top-left) ────────────────────────
  (all other keys ·)                      │        RGB   Layer  Mode
                                          │        Vol-   Vol+  Mute
                         Stop    Play     │  Prev   Next
```

### linux setup

Oryx live training, Keymapp and flashing need udev access
(`install-packages-fedora.sh` writes this):

```
# /etc/udev/rules.d/50-zsa.rules
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", TAG+="uaccess"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"
```

`kbd-layer` prints the active layer when it isn't the base one; the zsh right
prompt, the nvim statusline and the Quickshell bar show it (`⌨ media`), so a
toggled layer is never forgotten. It reads the layer with
[Kontroll](https://github.com/zsa/kontroll) through Keymapp's API (Keymapp
autostarts minimised with the API on).

## hyprland

[Hyprland](https://hypr.land/) runs as its own session next to GNOME (pick it
at the GDM login screen; GNOME stays as a fallback). It comes from the
`sdegler/hyprland` copr and is configured in Lua (`hyprland.lua` requires
`look`, `input`, `binds`, `rules` and `autostart`). Monitors default to
`preferred, auto`; per-machine overrides go in an untracked
`~/.config/hypr/local.lua`:

```lua
hl.monitor({ output = "DP-1", mode = "2560x1440@144", position = "0x0", scale = 1 })
```

`SUPER` (hold `F` or `J`) is the modifier, so the `ctrl+alt` combos stay with
herdr.

| key | action |
|---|---|
| `SUPER+Return` | ghostty |
| `SUPER+d` | launcher |
| `SUPER+Escape` / `SUPER+Shift+e` | power menu |
| `SUPER+h/j/k/l`, `+Shift` | focus, move window |
| `SUPER+1..0`, `+Shift` | go to, move window to workspace |
| `SUPER+f` / `SUPER+Shift+space` / `SUPER+e` | fullscreen / float / toggle split |
| `SUPER+r` | resize mode (`h/j/k/l`, `Esc` leaves) |
| `SUPER+Shift+q` / `SUPER+Shift+c` | close window / reload config |
| Lock key (`ctrl+alt+gui+l`) | lock (hypridle runs hyprlock) |
| `SUPER+v` | clipboard history |
| `SUPER+s` / `SUPER+Shift+s` | toggle scratchpad / move window to it |
| `SUPER+n` | night light (hyprsunset) |
| `Print` / `Shift+Print` | screenshot region / screen to the clipboard |
| `Ctrl+Print` | annotate a region in satty |
| `Alt+Print` | start / stop recording a region (`~/Videos`) |
| `SUPER+Print` / `SUPER+Ctrl+Print` | colour picker / OCR a region to the clipboard |

hypridle locks after 10 minutes and turns the screens off after 15.

### quickshell

[Quickshell](https://quickshell.org/) is the desktop shell, written in QML in
`linux/.config/quickshell` and started by Hyprland (`qs`). Edits reload live.

- **bar** (one per monitor): workspaces on that monitor (click to switch),
  herdr agents (`◑` working, `◆` blocked, `✓` done; click focuses the next
  waiting one), `kbd-layer`, volume (click mutes, scroll adjusts), tray, clock.
- **notifications**: Quickshell is the notification daemon; popups sit top
  right, expire after 5 seconds (critical ones stay), click to dismiss.
- **volume OSD**: a bar at the bottom of the screen whenever volume or mute
  changes.
- **launcher** (`SUPER+d`): filters installed apps by name or keyword;
  `Up/Down` or `C-j/C-k` to pick, `Enter` runs, `Esc` closes.
- **clipboard** (`SUPER+v`): `cliphist` history (text and images); filter,
  `Enter` copies the entry back.
- **power menu** (`SUPER+Escape`): `l` lock, `e` log out, `s` suspend,
  `r` reboot, `p` shut down (or `j/k` and `Enter`).

Hyprland binds open the overlays with `qs ipc call launcher toggle` (or
`power`, `clipboard`).

## structure

```
dotfiles/
├── common/                     # configs for all platforms
│   ├── .config/
│   │   ├── bat/                # bat
│   │   ├── btop/               # btop system monitor
│   │   ├── gh/                 # github cli
│   │   ├── git/ignore          # global excludes (stow skips a top-level .gitignore)
│   │   ├── ghostty/themes/     # shared ghostty colour theme
│   │   ├── herdr/              # herdr agent multiplexer
│   │   ├── lazygit/            # lazygit
│   │   ├── nvim/               # neovim
│   │   ├── ripgrep/            # ripgrep
│   │   ├── shepherd/           # shepherd todo board (config only)
│   │   ├── yazi/               # yazi file manager
│   │   └── zsh/                # aliases, functions, utils
│   ├── .newsboat/              # newsboat rss reader
│   ├── .ssh/
│   │   ├── config.d/           # per-host snippets (forgejo, homelab)
│   │   └── config.template     # ssh config template
│   ├── .editorconfig
│   ├── .git-commit-template
│   ├── .gitconfig
│   ├── .gitconfig-work         # work identity, included by remote url
│   ├── .tmux.conf
│   ├── .zshenv
│   └── .zshrc
├── linux/                      # fedora-specific configs
│   ├── .config/
│   │   ├── ghostty/            # ghostty terminal
│   │   ├── hypr/               # hyprland (lua), hypridle, hyprlock, hyprpaper
│   │   ├── quickshell/         # bar, notifications, launcher, clipboard, power menu
│   │   └── zsh/                # linux-only functions
│   ├── .local/bin/             # linux scripts (auto on PATH)
│   │   ├── update              # update all packages + tools
│   │   ├── cleanup             # free disk space
│   │   ├── disk-report
│   │   ├── journalctl-report
│   │   ├── system-ports
│   │   ├── systemctl-browser
│   │   ├── systemctl-failed
│   │   └── systemctl-logs
│   └── .zshrc.local
├── mac/                        # macos-specific configs
│   ├── .config/
│   │   ├── ghostty/            # ghostty terminal
│   │   └── zsh/                # mac-only aliases
│   ├── .gnupg/                 # gpg agent config
│   ├── .local/bin/             # mac scripts (auto on PATH)
│   │   ├── update              # update all packages + tools
│   │   └── cleanup             # free disk space
│   ├── .aerospace.toml
│   └── .zshrc.local
├── resources/                  # wallpapers, gifs, icons
├── scripts/
│   ├── immich/
│   │   └── immich_add_unassigned_assets.sh
│   ├── install-packages-fedora.sh
│   ├── install-packages-mac.sh
│   └── macos-defaults.sh
└── install.sh
```

`install.sh` stows with `--no-folding`: every file is linked individually and
directories are always real, so files an app writes into its config dir
(herdr sockets and plugins, gh tokens, shepherd boards) never land in the repo.
It also lets packages share a directory — ghostty's `config` is per-platform
(fonts differ) while its colour theme lives in `common/`.

## getting started

Clone into your home directory:

```sh
git clone git@github.com:jwarykowski/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### fresh machine

Install packages then stow dotfiles:

```sh
./install.sh --packages --profile personal   # or --profile work
```

`--profile` seeds the untracked `~/.claude/CLAUDE.local.md` (only if it doesn't
exist yet), which the shared `~/.claude/CLAUDE.md` imports: `personal` points it
at `CLAUDE.personal.md` from this repo, `work` leaves a stub for work-only rules
that must stay out of this public repo.

### existing machine

Adopt current configs into the repo, then stow:

```sh
./install.sh --adopt
```

### subsequent runs

Re-apply dotfiles (safe, idempotent):

```sh
./install.sh
```

## post-install

- **tmux plugins**: open tmux and press `prefix + I` to install plugins via tpm
- **neovim plugins**: open nvim — lazy.nvim installs automatically on first launch, mason installs LSPs
- **zsh plugins**: znap clones and caches plugins automatically on first shell start
- **zsh default shell**: `chsh -s $(which zsh)`
- **ssh config**: copy `~/.ssh/config.template` to `~/.ssh/config` and add your hosts; git over SSH to Forgejo (`config.d/forgejo`) needs `cloudflared` and your public key added in Forgejo
- **gh cli**: `gh auth login` — `hosts.yml` is deliberately untracked, it can hold an oauth token

## license

[MIT](LICENSE)

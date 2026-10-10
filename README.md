# dotfiles

> Here be thy dotfiles.
> A collection of incantations, symlinks, and shell spells, forged in the fires
> of frustration and optimised through far too many late nights.
> Tread carefully, adventurer — what lies within may summon tiling windows,
> whisper zsh aliases, and open portals to the neovim void.

## overview

| | Linux | Mac |
|---|---|---|
| **Machine** | [Intel NUC Hades Canyon](https://www.scorptec.com.au/product/Branded-Systems/NUC-&-Mini-PC/71990-BOXNUC8I7HVK4) | [MacBook Pro](https://www.apple.com/au/macbook-pro/) |
| **OS** | [Fedora](https://getfedora.org/) | macOS |
| **WM** | [i3](https://i3wm.org/) | [AeroSpace](https://github.com/nikitabobko/AeroSpace) |

- **Dotfile Manager**: [GNU Stow](https://www.gnu.org/software/stow/)
- **Shell**: [zsh](https://wiki.archlinux.org/index.php/Zsh) + [znap](https://github.com/marlonrichert/zsh-snap)
- **Terminal**: [Ghostty](https://ghostty.org/)
- **Editor**: [Neovim](https://neovim.io/) + [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Multiplexer**: [tmux](https://github.com/tmux/tmux) + [tpm](https://github.com/tmux-plugins/tpm); [herdr](https://herdr.dev) for agent sessions
- **Todos**: [shepherd](https://github.com/jwarykowski/shepherd) todo board — `<leader>T` in nvim via [nvim-shepherd](https://github.com/jwarykowski/nvim-shepherd)
- **RSS**: [newsboat](https://newsboat.org/)
- **Theme**: [lackluster](https://github.com/slugbyte/lackluster.nvim) (nvim, ghostty, tmux, btop, delta)
- **Font**: [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono/)
- **Keyboard**: [ZSA Moonlander](https://www.zsa.io/moonlander) — [layout on Oryx](https://configure.zsa.io/moonlander/layouts/BO0Dw/latest)

## toolchain

```
 ┌──────────────────────────────────────────────────────────────────────────────┐
 │ Moonlander (Oryx BO0Dw) ── home-row mods · symbols/navi/media layers         │
 └───────────────────────────────────┬──────────────────────────────────────────┘
        Fedora · GNOME / i3          │  macOS · AeroSpace + borders
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
 │  zsh-z · fzf     │  oil · trouble · neotest │                                │
 │  direnv · fnm    │  shepherd todo board     │                                │
 └──────────────────┴──────────────────────────┴────────────────────────────────┘
   CLI: eza · bat · ripgrep · fd · fzf · yazi · btop · newsboat · jq
 ┌──────────────────────────────────────────────────────────────────────────────┐
 │ ~/dotfiles ── stow --no-folding:  common/ + linux/ | mac/   → $HOME          │
 │   install.sh [--packages|--adopt|--profile] · scripts/install-packages-*     │
 │   ~/.local/bin: update · cleanup · systemctl-* · disk-report                 │
 │   CI: shellcheck · stylua · luacheck                                         │
 └──────────────────────────────────────────────────────────────────────────────┘
```

## moonlander

Layout lives on [Oryx](https://configure.zsa.io/moonlander/layouts/BO0Dw/latest)
(not in this repo). Home-row mods (`S D F` / `J K L` hold for Ctrl Alt Gui),
`A` / `;` hold for symbols, `Space` hold for navigation, and a vim-motion
bottom row: `<` `0` on the left, `$` `>` on the right. The `C-a` / `C-f`
thumb keys are grep and git-file pickers in both nvim (snacks) and zsh (fzf).

`/x` = tap / hold `x` · `MO(n)` hold layer · `TG(n)` toggle layer ·
`▽` transparent · `C- S- A- G-` = Ctrl Shift Alt Gui

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

On Linux, Oryx live training, Keymapp and flashing need udev access
(`install-packages-fedora.sh` writes this):

```
# /etc/udev/rules.d/50-zsa.rules
KERNEL=="hidraw*", ATTRS{idVendor}=="3297", TAG+="uaccess"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"
```

### agent lights

[Kontroll](https://github.com/zsa/kontroll) drives the backlight through
Keymapp's API (Keymapp autostarts minimised with the API on).
[herdr-zsa-lights](https://github.com/jwarykowski/herdr-zsa-lights) (herdr
plugin) lights the number key of each workspace, matching `ctrl+alt+N`: amber
while its agent is blocked, green when it's done. The top-right key glows
amber while anything is blocked.

| key | Oryx sends | herdr runs |
|---|---|---|
| top-right | `ctrl+alt+a` | `next-agent`: focus the next blocked (then done) agent |
| hold Space + top-right | `ctrl+alt+shift+a` | `toggle`: lights on/off |

[herdr-gh](https://github.com/jwarykowski/herdr-gh) (herdr plugin) puts each
workspace's pull request on its sidebar branch line as `$gh`, e.g. `#412│×│!`.

Agents from the editor and the todo board:

- `<leader>ai` in nvim asks the agent in the same herdr workspace about the
  cursor line (normal) or the selection (visual), with `file:line` context.
- `prefix+shift+d` in herdr (`herdr-todo-agent`) picks an open shepherd todo,
  creates a `todo/<slug>` worktree, starts Claude there with the todo as its
  prompt and marks it in-progress; `herdr-todo-sync` marks it done once the
  branch's PR merges.

`kbd-layer` prints the active layer when it isn't the base one; the zsh right
prompt and the nvim statusline show it (`⌨ media`), so a toggled layer is
never forgotten.

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
│   │   ├── i3/                 # i3 window manager
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
- **ssh config**: copy `~/.ssh/config.template` to `~/.ssh/config` and add your hosts
- **gh cli**: `gh auth login` — `hosts.yml` is deliberately untracked, it can hold an oauth token

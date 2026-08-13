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

## structure

```
dotfiles/
├── common/                     # configs for all platforms
│   ├── .config/
│   │   ├── bat/                # bat
│   │   ├── btop/               # btop system monitor
│   │   ├── gh/                 # github cli
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
│   ├── .gitignore              # stowed as the global excludesfile
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

Ghostty's `config` is per-platform (fonts differ) but the colour theme lives in
`common/`. Stow only merges the two into one `~/.config/ghostty` on a restow —
`--adopt` on a folded directory will silently keep the theme unlinked.

## getting started

Clone into your home directory:

```sh
git clone git@github.com:jwarykowski/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### fresh machine

Install packages then stow dotfiles:

```sh
./install.sh --packages
```

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

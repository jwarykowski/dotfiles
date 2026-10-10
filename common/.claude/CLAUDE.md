# Global rules

Shared by every machine (from ~/dotfiles, which is public). Machine-specific
rules (work or personal) live in the untracked ~/.claude/CLAUDE.local.md,
imported at the end.

## git

- Commit only when asked. Never commit on the default branch; branch first.
- Sign nothing: commit with `--no-gpg-sign`.
- No AI attribution anywhere:
  - commits: no `Co-Authored-By` or `Claude-Session` trailers
  - pull requests: no `Co-Authored-By`, no "Generated with Claude Code" line, no session link in the description
- Conventional Commits (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`); branches `feat/…`, `fix/…`, etc. off the default branch.
- Use `gh` for GitHub work. Projects live in `~/development`.

## shell

- My zsh aliases make some commands interactive or hang: use `command rm` and `command ls` (not the `rm -i` / eza aliases). For anything longer than a line, write a script to a file and run it with `bash`.
- zsh expands a leading `=`: quote such arguments (`echo '======'`).
- Never run `sudo` yourself; give me the command to run in my own terminal.
- Shell scripts must pass shellcheck and run on both Linux (Fedora) and macOS: no GNU-only flags such as `find -xtype`, or `sed -i` without a suffix argument.

## dotfiles (`~/dotfiles`, GNU stow)

- Stow runs with `--no-folding`, so a new file only appears in `~` after a restow: `stow -d ~/dotfiles -t ~ --no-folding -R common` (plus `linux` or `mac`).
- Never commit credentials: `common/.config/gh/hosts.yml`, `.npmrc`.
- Neovim: install plugins with `Lazy! install`, never `Lazy! sync` (it updates every plugin and the lockfile).

## toolchain

- Go: build and test with `GOTOOLCHAIN=auto` (repos may need a newer Go than the system one).
- Lua tests: run busted as `luajit ~/.luarocks/bin/busted </dev/null` (the launcher's `lua` is 5.4; the rocks are 5.1; nlua's nvim hangs on an open stdin).

## writing

- Australian English in prose, comments, docs, commit messages and PR descriptions:
  - `-ise` / `-isation`: organise, initialise, prioritise, optimisation
  - `-our`: colour, behaviour, favour
  - `-re`: centre, metre (but "meter" for a measuring device)
  - `-yse`: analyse, paralyse
  - doubled `l`: travelled, cancelled, modelling, labelled
  - nouns vs verbs: licence/license, practice/practise
  - also: program (software), defence, catalogue, grey, aluminium
- Identifiers, APIs, CLI flags, config keys and quoted output keep their own spelling (`color`, `initialize`, `--color`).
- Keep READMEs and PR descriptions short; match the surrounding code's comment density.

@~/.claude/CLAUDE.local.md

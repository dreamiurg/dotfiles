# Repository Guidelines

## Project Structure & Module Organization
Dotfiles live at the repository root for easy symlinking: `vimrc`, `zshrc`, `tmux.conf`, and `screenrc` are the primary entry points. Supporting scripts sit beside them (`install.sh`, `brew.sh`, `git-setup.sh`) so contributors can track bootstrap changes in one place. Editor-specific assets live under `vim/` with standard Vim runtime layout (`autoload/`, `colors/`, `syntax/`, `ftdetect/`); keep new language tweaks within those folders so they are picked up automatically.

## Build, Test, and Development Commands
Run `./install.sh` to back up any existing dotfiles and create the `~/.dotfiles` symlinks—use a disposable shell profile when iterating. Execute `./git-setup.sh` after install to refresh aliases and signing defaults. Use `./brew.sh` during macOS provisioning; group any additional packages by role and annotate with comments as the current file does.

## Coding Style & Naming Conventions
Shell scripts target Bash on macOS; keep `#!/bin/bash` shebangs, use four-space indentation inside loops, and favour uppercase for exported variables (`INSTALL_DIR`). Prefer small, composable functions over inline blocks when scripts grow past ~40 lines. Vimscript additions should mirror the existing lowercase naming and live in `vim/autoload` or `vim/syntax` depending on purpose. Configuration filenames should match the upstream tool (`zshrc`, not `shellrc`) to preserve the symlink flow in `install.sh`.

## Testing Guidelines
There is no automated harness. After changes, dry-run `./install.sh` in a temp home (`HOME=$(mktemp -d) ./install.sh`) to confirm backups and symlinks succeed, then launch the relevant shell (`zsh -l`) or editor to sanity check new settings. For Vim updates, run `vim -Nu NONE -c 'source ~/.vimrc'` to ensure the file loads without errors.

## Commit & Pull Request Guidelines
Start each change on a dedicated feature branch (or the shared `dev` branch) instead of committing directly to `master`, and land updates through a pull request. History shows concise, imperative commit subjects (e.g., `fix rbenv init permissions`). Follow that format and scope one logical change per commit. Pull requests should explain the motivation, list affected dotfiles, and include per-file change bullets (e.g., ``- zshrc adds staged-count coloring``) that spell out what changed and why. Attach any screenshots or terminal clips if a visual theme changes, link related issues or TODOs, and note manual validation steps so reviewers can reproduce them quickly.

## Security & Configuration Tips
Avoid committing personal secrets or machine identifiers; rely on local overrides sourced from `zshrc` when needed. When adding new bootstrap commands, prefer idempotent checks (`command -v delta >/dev/null || brew install git-delta`) to keep first-run scripts safe for repeated execution.

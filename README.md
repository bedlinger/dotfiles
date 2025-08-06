# macOS dotfiles

My gruvbox themed dotfiles and configurations for a modern macOS development environment.

![main screen wallpaper](./main_screen_wp.png)
![main screen](./main_screen.png)
![secondary screen](./secondary_screen.png)

## Requirements

- [Homebrew](https://brew.sh/) (for installing dependencies)
- [Git](https://git-scm.com/) > `brew install git`
- [GNU Stow](https://www.gnu.org/software/stow/) > `brew install stow`

## Installation

1. **Clone the repository into your home directory**

   ```bash
   git clone git@github.com:bedlinger/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Symlink all configurations using GNU Stow**

   ```bash
   stow .
   ```

   > _Tip: Back up any existing config files before running Stow._

3. **(Optional) Stow only selected configs**
   ```bash
   stow .zshrc
   stow .config/nvim
   stow .config/sketchybar
   ```

## Usage & Updates

- **Update dotfiles:**
  ```bash
  cd ~/dotfiles
  git pull origin main
  stow .
  ```

## Adding or Modifying Configurations

1. Place the new config directory or file inside the repo (e.g., `.config/nvim` for Neovim).
2. Use `stow <target>` to symlink it.
3. If you need to exclude files, add patterns to `.stow-local-ignore`.
4. Test after each change.

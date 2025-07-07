# My macOS dotfiles

My macOS dotfiles and configurations for a modern development environment. This repository contains configuration files for various tools including shell environments, window management, system monitoring, and more.

## Requirements

Ensure you have the following installed on your system before proceeding with installation:

### Git

```bash
brew install git
```

### Stow

GNU Stow is used to manage symlinks for the dotfiles:

```bash
brew install stow
```

## Installation

1. First, check out the dotfiles repository in your `$HOME` directory using git:

```bash
git clone git@github.com/bedlinger/dotfiles.git
cd dotfiles
```

2. Use GNU Stow to create symlinks for all configurations:

```bash
stow .
```

**Note:** This will create symlinks in your home directory. Make sure to backup any existing configuration files before running this command.

## Usage

### Updating Dotfiles

To update your dotfiles with the latest changes:

```bash
cd ~/dotfiles
git pull origin main
stow .
```

### Managing Individual Configurations

You can also stow individual configuration directories if you only want specific dotfiles:

```bash
# Example: Only install zsh configuration
stow .zshrc

# Example: Only install specific config directories
stow .config/sketchybar
```

## Features

This dotfiles repository includes configurations for:

- **Shell Environment**
  - `.zshrc` - Zsh configuration with Oh My Zsh, themes, and helpful aliases
  - Eza integration for enhanced `ls` functionality

- **Window Management**
  - **Aerospace** - Tiling window manager configuration
  - **Borders** - Window border enhancement

- **System Monitoring**
  - **SketchyBar** - Highly customizable macOS status bar with plugins for:
    - System information (CPU, memory, network, battery)
    - Spotify integration
    - Workspace indicators
    - Volume and clock widgets
  - **Btop** - Modern system resource monitor

- **Terminal**
  - **Ghostty** - Terminal emulator configuration

## Customization

### Modifying Configurations

1. **SketchyBar**: Edit `.config/sketchybar/sketchybarrc` to modify the status bar layout and plugins
2. **Zsh**: Customize `.zshrc` to add personal aliases, functions, or modify the theme
3. **Colors**: SketchyBar uses a Gruvbox color scheme defined in `.config/sketchybar/colors.sh`

### Adding New Configurations

1. Add your configuration files to the repository
2. Update `.stow-local-ignore` if you need to exclude certain files
3. Test with `stow .` to ensure proper symlinking

### Theme Consistency

Most configurations use the Gruvbox color scheme for visual consistency across applications.

## Contributing

Contributions are welcome! If you have improvements or additional configurations:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-config`)
3. Commit your changes (`git commit -am 'Add amazing configuration'`)
4. Push to the branch (`git push origin feature/amazing-config`)
5. Open a Pull Request

Please ensure that:
- Configurations follow the existing structure
- New features are documented in the README
- Color schemes maintain consistency with the Gruvbox theme where applicable

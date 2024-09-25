# dotfiles

A collection of configuration files meant to be used with GNU stow.


## Todos

* configure 'pavucontrol' and 'blueman-manager' to use a dark theme
* configure 'dunst'
* configure 'logind'
* configure lock screen (probably i3lock)
* 'fzf'??
* neovim -.-


## Usage

### List of packages to install
* alacritty
* audacious
* bash-completion
* bitwarden
* dunst
* eza
* feh
* firefox
* git
* maim
* man
* pavucontrol
* picom
* polybar
* ripgrep
* rofi
* starship
* stow
* unzip
* xclip

AUR:
* paru
* visual-studio-code-bin


### Getting the repository
Navigate to your home directory `~/`.
Download the repository to that directory or do it the recommended way and clone it there with git:
```
    git clone https://github.com/zegonix/dotfiles.git
```
or
```
    git clone git@github.com:zegonix/dotfiles.git
```

**Note:** The location of the local copy is important for stow. You can put it somewhere else, but you will have to configure stow to inform it of non default source and target locations, the target is relative to the source by default.


### Link configurations with GNU stow
Make sure to have `stow` installed.
Navigate into your local copy of the repository, usually `~/dotfiles`.
Create links to the configurations with:
```
    stow <package>
```
for example
```
    stow alacritty
```
It is important to execute this and similar commands in the root directory of the repository `~/dotfiles` unless you specify source and target locations manually.

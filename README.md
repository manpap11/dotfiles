# Dotfiles

This is just a repo were I save and share my dotfiles (.config)

## Environment Variables

Since a lot of applications place their config files in random places you should set the **XDG environment variables** to introduce ***some sense*** of cross compatibility in case some applications make use of the standard.

In your ~/.profile add:
```
export XDG_CONFIG_HOME="$HOME/.config"
```

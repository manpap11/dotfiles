# Dotfiles

This is just a repo were I save and share my dotfiles (.config)

## Environment Variables

Since a lot of applications place their config files in random places you should set the **XDG environment variables** to introduce ***some sense*** of cross compatibility in case some applications make use of the standard.

In your ~/.profile add:
```
export XDG_CONFIG_HOME="$HOME/.config"
```

You should download your LSPs of your choice and create a symlink to the "lsp" folder you will create for easier management of the LSPs.
```
ln -s ~/Downloads/<your_chosen_path_anyway> $HOME/.local/share/nvim/lsp"
```

In your ~/.bashrc add:
```
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$HOME/.local/share/nvim/lsp"
```

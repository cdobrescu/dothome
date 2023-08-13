# Vscode - Ubuntu keybindings overlap

Ubuntu has bindings for `Ctrl+Alt+Arrows` to unset them we can use
```
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "[]"
```
In case you would want to reset them back to defaults:
```
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-up
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-down
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-up
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-down
```
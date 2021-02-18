## Install

Uses [Dotbot](https://github.com/anishathalye/dotbot), which places
symlinks between dotfiles on the installed system to the files maintained in this
repository.

```sh
git clone https://github.com/bricoletc/dotfiles ~/dotfiles
cd ~/dotfiles
./install
```

If on the cluster, additionally run
```
ln -sf ~/dotfiles/bashrc_cluster ~/.bashrc
```

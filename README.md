# dotfiles

Pretty much everything is managed by `nix` flakes. Install that (probably using [nix-flakes-installer](https://github.com/numtide/nix-flakes-installer/tree/526432bab47a079d57653b3ea63683fc5ca32001)), install cachix and use the the `nuance` and `nix-community` caches, add a machine to `home-manager/flake.nix`, and run `rebuild.sh (new-machine-alias)`. Future updates can be triggered via the managed `flake-rebuild` bash alias.

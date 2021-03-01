# Installation instructions

## macos

Install nix in multi-user mode.

```
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
```

Run the bootstrap profile to generate a new nix.conf (providing git from nix).

```
nix-shell -p git --command "./rebuild.sh macos-bootstrap"
```

Append the generated nix.conf to the system nix.conf and add your user as a trusted user.

```
sudo "cat ../.config/nix/nix.conf >> /etc/nix/nix.conf"
sudo "echo \"trusted-users = $(whoami)\" >> /etc/nix/nix.conf"
```

Run the full profile to build home

```
nix-shell -p git --command "./rebuild.sh m1-pro"
```

# Nix

This is my flake based nixos configuration.

This page is deprecated. My flakes are now hosted on [sourcehut](https://git.sr.ht/~nel/nix).

## Desktop configuration
```bash
sudo nixos-rebuild switch --flake .#desktop
```

## Macbook configuration
```bash
sudo nixos-rebuild switch --flake .#macbook
```

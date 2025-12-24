# NixOS Dotfiles

Multi-host NixOS configuration with Hyprland, home-manager, and Stylix.

## Hosts

| Host | Machine | CPU | GPU |
|------|---------|-----|-----|
| `amaterasu` | Laptop | Intel | NVIDIA (Optimus) |
| `harakiri` | Desktop | AMD | AMD |

## Directory Structure

```
.dotfiles/
├── flake.nix              # Flake with both host configurations
├── home.nix               # Shared home-manager config
├── hosts/
│   ├── amaterasu/         # Laptop-specific config
│   └── harakiri/          # Desktop-specific config
├── modules/
│   └── common.nix         # Shared NixOS config
└── apps/                  # Application configs (hyprland, kitty, waybar, etc.)
```

## Commands

### Build & Switch

```bash
# On harakiri (desktop)
sudo nixos-rebuild switch --flake .#harakiri

# On amaterasu (laptop)
sudo nixos-rebuild switch --flake .#amaterasu

# After first build, hostname is set and this works:
sudo nixos-rebuild switch --flake .
# Or use the alias:
update
```

### Update Flake Inputs

```bash
# Update all inputs (nixpkgs, home-manager, stylix)
nix flake update
# Or use the alias:
upgrade
```

### Test Configuration (without switching)

```bash
# Build without activating
sudo nixos-rebuild build --flake .#harakiri

# Build and show what would change
sudo nixos-rebuild dry-activate --flake .#harakiri
```

### Check Flake

```bash
# Validate flake syntax and evaluation
nix flake check

# Show flake info
nix flake show
```

### Garbage Collection

```bash
# Remove old generations (automatic daily, keeps 15 days / 5 generations)
sudo nix-collect-garbage -d

# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Rollback

```bash
# Switch to previous generation
sudo nixos-rebuild switch --rollback

# Boot into previous generation (select from boot menu)
# Or list and switch to specific generation:
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
sudo nix-env --switch-generation <number> --profile /nix/var/nix/profiles/system
```

## Shell Aliases

| Alias | Command |
|-------|---------|
| `update` | `sudo nixos-rebuild switch --flake .` |
| `upgrade` | `nix flake update` |
| `n` | `nvim` |
| `ls` | `eza -lh --icons --group-directories-first` |
| `htop` | `btop` |

## Monitor Configuration

- **amaterasu**: `eDP-1` @ 1920x1080 120Hz
- **harakiri**: `DP-3` @ 2560x1440 165Hz

Hyprland configs are split: `hyprland-base.conf` (shared) + per-host configs.

## Useful Resources

| Site | Description |
|------|-------------|
| [search.nixos.org/packages](https://search.nixos.org/packages) | Official NixOS package search |
| [search.nixos.org/options](https://search.nixos.org/options) | Official NixOS options search |
| [mynixos.com](https://mynixos.com/) | NixOS & home-manager option search with examples |
| [nixhub.io](https://www.nixhub.io/) | Search packages across nixpkgs versions/channels |

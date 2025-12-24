# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Build and switch (auto-detects host after first build)
sudo nixos-rebuild switch --flake .
# Or use alias: update

# Build for specific host
sudo nixos-rebuild switch --flake .#harakiri   # desktop
sudo nixos-rebuild switch --flake .#amaterasu  # laptop

# Update flake inputs
nix flake update
# Or use alias: upgrade

# Validate configuration without switching
nix flake check
sudo nixos-rebuild dry-activate --flake .#<host>
```

## Architecture

Multi-host NixOS flake configuration for two machines:
- **amaterasu**: Laptop (Intel CPU + NVIDIA Optimus)
- **harakiri**: Desktop (AMD CPU + AMD GPU)

### Structure

```
flake.nix                    # Entry point, defines both host configurations
├── modules/common.nix       # Shared NixOS config (bootloader, services, packages)
├── home.nix                 # Shared home-manager config (user packages, shell, apps)
├── hosts/
│   ├── amaterasu/default.nix   # Laptop-specific (NVIDIA drivers, WiFi 7)
│   └── harakiri/default.nix    # Desktop-specific (AMD GPU)
└── apps/                    # Application modules
    ├── hyprland/            # Per-host Hyprland configs via hostname variable
    ├── stylix/              # Catppuccin theme, fonts, cursor
    ├── waybar/kitty/rofi/   # UI apps
    └── docker/gcloud/       # Development tools
```

### Key Patterns

- **Host differentiation**: The `hostname` variable (passed via `home-manager.extraSpecialArgs`) enables per-host config in home-manager modules. See `apps/hyprland/default.nix` for the pattern.
- **Stylix theming**: System-wide theming via Stylix with Catppuccin Macchiato. FiraCode Nerd Font is the monospace font.
- **Flake inputs**: nixpkgs-unstable, home-manager, and stylix (all follow nixpkgs).

### Adding New Apps

1. Create `apps/<appname>/default.nix`
2. Import in `home.nix` (user-level) or `modules/common.nix` (system-level)
3. For per-host config, use the `hostname` variable pattern from hyprland

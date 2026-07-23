# NixOS + Home-Manager Configuration

<img src="https://github.com/user-attachments/assets/4f15d2ae-caf8-4f4d-8aa8-87daa8003280" alt="desktop screenshot" align="right" width="480">

</br>

- **OS** — [NixOS](https://nixos.org/) (unstable / flake-based)
- **Compositor** — [Hyprland](https://hypr.land/) + **[Caelestia Shell](https://github.com/caelestia-dots/shell)** (custom QML shell)
- **Bar** — [Waybar](https://github.com/Alexays/Waybar) / [Caelestia](https://github.com/caelestia-dots/shell) (built-in panel)
- **Terminal** — [Kitty](https://github.com/kovidgoyal/kitty)
- **Launcher** — [Rofi](https://github.com/davatorium/rofi)
- **Notifications** — [Dunst](https://github.com/dunst-project/dunst)
- **Shell** — [Fish](https://github.com/fish-shell/fish-shell)
- **Display Manager** — [Ly](https://github.com/fairyglade/ly)
- **Privilege Escalation** — doas (sudo disabled)
- **Filesystem** — Btrfs + subvolumes + zstd:3 compression

</br>

## Features

- Fully declarative flake-based configuration
- Multiple desktop profiles support in Home-Manager
  - `hyprland/caelestia` — main experimental profile with custom QML shell
  - `hyprland/waybar` — classic Hyprland + Waybar + Rofi + Dunst
  - `hyprland/Ambxst` — another QML shell variant (under testing, incomplete)
  - `hyprland/shared` — common settings (fish, kitty, themes, utilities)
  - `dwm/dwm` — test / legacy dwm profile
- Lanzaboote + sbctl (Secure Boot)
- NVIDIA proprietary drivers + VA-API + power management
- VFIO GPU passthrough preparation (kernel params and ids are set)
- Btrfs subvolumes: @, @home, @nix, @swap, @games (nodatacow), @storage
- doas instead of sudo + kernel hardening parameters
- AmneziaVPN daemon + throne
- Gaming stack: steam, gamescope, wine, mangohud, goverlay, heroic, honkers-railway-launcher + sleepy-launcher (HoYoverse gacha games)

## How to Use

### Configuration Structure

```
/etc/nixos
├── flake.nix
├── hosts/
│   ├── common/           # settings shared across most hosts
│   │   ├── bootloader.nix
│   │   ├── networking.nix
│   │   ├── nix.nix
│   │   ├── security.nix
│   │   └── default.nix
│   └── desktop/          # host-specific settings (nvidia, vfio, btrfs, etc.)
│       ├── bootloader.nix
│       ├── hardware.nix
│       ├── hardware-configuration.nix
│       ├── virtualization.nix
│       ├── desktop.nix
│       └── ...
└── home/
    ├── common/           # settings shared across users
    ├── modules/          # modular configurations (e.g. nixcord, firefox, etc.)
    │   ├── comms/
    │   ├── core/
    │   ├── default.nix
    │   ├── desktop/
    │   ├── dev/
    │   ├── gaming/
    │   └── utils/
    └── users/
        └── quanve/
            └── host-specific/
                └── desktop/
                    ├── default.nix
                    └── profiles/     # profile-specific configurations
                        ├── dwm/
                        │   └── dwm/  # test dwm profile
                        ├── hyprland/
                        │   ├── Ambxst/     # QML shell (testing, incomplete)
                        │   ├── caelestia/  # QML shell, custom panel, lockscreen
                        │   └── waybar/     # classic Hyprland + waybar
                        └── shared/         # fish, kitty, common utilities & themes
```

### Switching Profiles

Profiles are selected in the file `home/users/quanve/host-specific/desktop/default.nix`:

```nix
let
  enabledProfiles = [
    "hyprland/caelestia"    # currently active
    # "hyprland/waybar"     # commented → inactive
    # "hyprland/Ambxst"     # commented → inactive
    # "dwm/dwm"             # commented → inactive
  ];
in { ... }
```

After changing the list of profiles, run:

```bash
# Full system + home-manager rebuild (most reliable / common case)
doas nixos-rebuild switch --flake ~/new_nixos#desktop

# Only home-manager rebuild (faster when system hasn't changed)
home-manager switch --flake ~/new_nixos#quanve@desktop
```

## Additional Information

- `sudo` is completely disabled — **`doas`** is used instead
- Configuration tracks **nixos-unstable** channel
- Recommended package separation:
  - system-wide → `hosts/desktop/packages.nix`
  - user-specific → `home/.../packages.nix`
- Main user config files (kitty, fish, hyprland, rofi, dunst, waybar) are located in `home/.../configs/`
- After changing any of these configs → run `doas nixos-rebuild switch --flake ~/new_nixos#desktop`
- **Secure Boot (Lanzaboote)** setup (if not already done):
  ```bash
  doas sbctl create-keys
  doas sbctl enroll-keys --microsoft
  ```
- VFIO / GPU passthrough is prepared in kernel parameters, but **not enabled** by default
  - You need to replace the current PCI ids (GTX 1050 Ti) with your own GPU ids

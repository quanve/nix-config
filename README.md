# NixOS + Home-Manager Configuration

Multi-host NixOS flake with per-user and per-host **toggleable** Home-Manager modules.

- **OS** — NixOS (nixos-unstable, flake-based)
- **Desktop host** — NVIDIA (legacy_580) + Lanzaboote/Secure Boot, Btrfs + LUKS, niri/Wayland
- **Privilege escalation** — `doas` (sudo disabled)
- **Home-Manager** — embedded via the NixOS module (`useGlobalPkgs` / `useUserPackages`)

## Hosts

| Host    | Purpose                                                  |
| ------- | -------------------------------------------------------- |
| `desktop` | Main desktop: NVIDIA, Secure Boot, VFIO passthrough, virtualization, niri |
| `test`   | Minimal host (Framework laptop placeholder)              |

## Structure

```
flake.nix                     # host definitions + home-manager wiring
├── hosts/
│   ├── common/               # shared system config for every host
│   │   ├── bootloader.nix    # default kernel (linuxPackages_latest)
│   │   ├── networking.nix    # NetworkManager, nftables, resolved, locale
│   │   ├── nix.nix           # nix settings, GC, allowUnfree
│   │   └── security.nix      # firewall, doas, kernel hardening (kernelParams)
│   ├── desktop/              # main desktop host (each file = one concern)
│   │   ├── bootloader.nix    # lanzaboote + vfio-passthrough specialisation
│   │   ├── display.nix       # X server (NVIDIA), ly, niri, portals
│   │   ├── apps.nix          # steam, throne, firejail, direnv, localsend
│   │   ├── services.nix      # flatpak, gnome-keyring, syncthing, mullvad, amnezia
│   │   ├── hardware.nix      # NVIDIA legacy_580, graphics, udev rules
│   │   ├── hardware-configuration.nix
│   │   ├── networking.nix    # resolved override (delta from common)
│   │   ├── packages.nix      # system packages, session variables
│   │   ├── users.nix         # user account
│   │   ├── fonts.nix
│   │   ├── virtualization.nix# libvirt/qemu + virt-manager
│   │   └── security.nix      # TPM + sysctl (delta from common)
│   └── test/                 # minimal host (hardware-configuration commented out)
└── home/
    ├── common/               # user basics + imports ../modules (option registry)
    ├── modules/              # toggleable home modules (see below)
    │   ├── comms/    discord, obsidian, telegram
    │   ├── core/     editors, gnome, terminal
    │   ├── desktop/  firefox, media, obs-studio, themes
    │   ├── dev/      development, git, reverse-engineering, vpn
    │   ├── gaming/   minecraft, wine
    │   └── utils/    file-management, nixvim, utilities,
    │                 utilities-system, utilities-wayland, utilities-x11
    └── users/
        └── quanve/
            ├── default.nix                   # user-level module selection + variants
            └── host-specific/
                ├── desktop/
                │   ├── default.nix           # desktop-only modules
                │   └── configs/              # niri, waybar, foot, fuzzel, dunst, zsh
                └── test/default.nix
├── lib/config-builder.nix    # `libx`: copies config dirs → xdg.configFile
└── overlays/
```

## Home modules (`myHome.modules`)

Every leaf file under `home/modules/<category>/` is a self-contained Home-Manager
module that declares

```nix
options.myHome.modules.<category>.<name>.enable = lib.mkEnableOption "...";
config = lib.mkIf config.myHome.modules.<category>.<name>.enable { ... };
```

so the module code exists **once**, and nothing activates unless explicitly enabled.

### Where modules are enabled

The `home/modules` files are only an *option registry* — they are imported once from
`home/common/default.nix`, so every user/host sees the options but nothing is on by
default. The actual selection happens in three layers that merge into one config:

1. `home/users/<user>/default.nix` — what the user wants on **every** host;
2. `home/users/<user>/host-specific/<host>/default.nix` — what that **host** adds;
3. `home/common/default.nix` — universal per-user bits (username, state version).

```nix
# home/users/quanve/default.nix
{ ... }: {
  myHome.modules = {
    comms.discord.enable = true;
    core.terminal.enable = true;
    dev.git.enable = true;
    ...
  };
}
```

```nix
# home/users/quanve/host-specific/desktop/default.nix
{ ... }: {
  myHome.modules = {
    desktop.firefox.enable = true;
    gaming.minecraft.enable = true;
    ...
  };
}
```

A module enabled at the user level applies on all hosts; the host-specific file only
adds to it. Unknown module names fail loudly at evaluation time
(`option ... does not exist`), so a typo cannot silently drift the config.

### Variants: one module, different settings

`enable` is just a switch. If a module needs to differ between users or hosts, declare
more sub-options — variants become *data*, not duplicated code. Example: `git` takes a
per-user identity instead of hardcoding it:

```nix
# home/modules/dev/git.nix
options.myHome.modules.dev.git = {
  enable = lib.mkEnableOption "dev/git";
  userName = lib.mkOption { type = lib.types.str; default = ""; ... };
  userEmail = lib.mkOption { type = lib.types.str; default = ""; ... };
};
```

```nix
# home/users/alice/default.nix — different variant than quanve
{ ... }: {
  myHome.modules.dev.git = {
    enable = true;
    userName = "alice";
    userEmail = "alice@example.com";
  };
}
```

Because the user-level and host-level files live in the same module tree, hosts can
override user-level values: declare the low-priority layer with `lib.mkDefault` and let
the host set a plain value, or override explicitly with `lib.mkForce`.

## Building / switching

```bash
# Full system + home-manager rebuild
doas nixos-rebuild switch --flake /path/to/repo#desktop

# VFIO passthrough kernel: select the "vfio-passthrough" entry
# in the systemd-boot menu at boot
```

Standalone `home-manager switch --flake .#quanve@desktop` is **not** available yet —
the flake exposes only `nixosConfigurations` (home-manager is embedded). Add a
`homeConfigurations` output if you want standalone home-manager switching.

## Adding things

**New host:** create `hosts/<name>/default.nix` and
`home/users/quanve/host-specific/<name>/default.nix`, then register it in `flake.nix`
(`mkNixos "<name>" ...`).

**New module:** add `home/modules/<category>/<name>.nix` with an `enable` option +
`mkIf` body (optionally extra variant options), list it in
`home/modules/<category>/default.nix`, then flip it on in the user or host-specific file.

**New user:** the flake currently hardcodes a single `user = "quanve"`. Multi-user
support means generalizing `flake.nix` to a list of users, each with its own
`home/users/<user>/default.nix`.

## Notes

- `sudo` is disabled — use `doas`.
- Secure Boot via Lanzaboote + sbctl (`/var/lib/sbctl`).
- Kernel hardening and strict firewall on all hosts (`hosts/common/security.nix`).
- Desktop uses NVIDIA legacy_580 + VA-API, Btrfs with LUKS (`resumeDevice`, zstd).
- VFIO GPU passthrough is prepared as a boot specialisation, not enabled by default
  (replace the PCI ids in `hosts/desktop/bootloader.nix`).

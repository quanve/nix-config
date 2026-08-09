{ lib, user, ... }:
{
  # Firewall
  networking.firewall = {
    enable = lib.mkDefault true;
    allowedTCPPorts = lib.mkDefault [ ];
    allowedUDPPorts = lib.mkDefault [ ];
    # Strict reverse-path filtering (nixpkgs default). "loose" would
    # silently weaken the firewall.
    checkReversePath = lib.mkDefault true;
    logReversePathDrops = lib.mkDefault true;
    allowPing = lib.mkDefault false;
  };

  # Privilege escalation
  security = {
    sudo.enable = lib.mkDefault false;

    doas = {
      enable = lib.mkDefault true;
      extraRules = [
        {
          users = lib.mkDefault [ user ];
          keepEnv = lib.mkDefault true;
          persist = lib.mkDefault true;
        }
      ];
    };

    # Kernel hardening
    protectKernelImage = lib.mkDefault true;
  };


  # Kernel hardening.
  # NOTE: keep this a plain list (not `mkDefault`). nixpkgs sets
  # boot.kernelParams at default priority, which would silently drop
  # an `mkDefault` list (lists concatenate only at equal priority).
  boot.kernelParams = [
    "slab_nomerge"
    "init_on_alloc=1"
    "init_on_free=1"
    "page_alloc.shuffle=1"
    "nowatchdog"
    "nmi_watchdog=0"
    "softlockup_panic=0"
    "pti=on"
    "vsmap=full"
    "debugfs=off"
  ];
}

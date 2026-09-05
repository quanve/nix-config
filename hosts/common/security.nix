{ lib, user, ... }:
{
  networking.firewall = {
    enable = lib.mkDefault true;
    allowedTCPPorts = lib.mkDefault [ ];
    allowedUDPPorts = lib.mkDefault [ ];
    checkReversePath = lib.mkDefault false;
    logReversePathDrops = lib.mkDefault true;
    allowPing = lib.mkDefault false;
  };

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

    protectKernelImage = lib.mkDefault true;
  };

  boot.kernelParams = [
    "page_alloc.shuffle=1"
    "softlockup_panic=0"
    "init_on_alloc=1"
    "init_on_free=1"
    "nmi_watchdog=0"
    "slab_nomerge"
    "nowatchdog"
    "debugfs=off"
    "pti=on"
  ];
}

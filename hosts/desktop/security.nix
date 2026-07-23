{ config, pkgs, lib, user, ... }:
{
  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    # checkReversePath = "loose";
    logReversePathDrops = true;
    allowPing = false;
  };

  # Privilege escalation
  security = {
    sudo.enable = false;
    
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ user ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    
    # Kernel hardening
    protectKernelImage = true;

    tpm2.enable = true;
  };


  boot = {
    kernelParams = [
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
    kernel.sysctl = {
      # IP-spoofing
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      # routing shutdown
      "net.ipv4.ip_forward" = 0;
      "net.ipv6.conf.all.forwarding" = 0;
      # Enabling syncookies to protect against SYN floods
      "net.ipv4.tcp_syncookies" = 1;
      # Ignoring ICMP redirects
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      # Logging suspicious packets
      "net.ipv4.conf.all.log_martians" = 1;
      # Protection against routing errors
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      # Connection timeout restriction
      "net.netfilter.nf_conntrack_max" = 1048576;
    };
  };
}

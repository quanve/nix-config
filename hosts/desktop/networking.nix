{ config, pkgs, lib, ... }:
{
  services.resolved.settings.Resolve = {
    DNSSEC = "true";
    FallbackDNS = [
      "1.1.1.1#cloudflare-dns.com"
      "8.8.8.8#dns.google"
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # r8169 (RTL8168g) + EEE occasionally fails to negotiate the link on
  # cold boot; a cable replug fixes it. Disable EEE on the NIC at boot.
  systemd.services.disable-eee = {
    description = "Disable Energy Efficient Ethernet on enp3s0";
    after = [ "network-pre.target" ];
    before = [ "NetworkManager.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool --set-eee enp3s0 eee off";
    };
  };
}

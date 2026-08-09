{ pkgs, ... }:
{
  services.resolved.settings.Resolve = {
    DNSSEC = "true";
    DNSOverTLS = "strict";
    FallbackDNS = [
      "1.1.1.1#cloudflare-dns.com"
      "8.8.8.8#dns.google"
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # r8169 (RTL8168g) + EEE occasionally fails to negotiate the link on
  # cold boot; a cable replug fixes it. Disable EEE on the NIC as soon
  # as the device appears.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="enp3s0", RUN+="${pkgs.ethtool}/bin/ethtool --set-eee enp3s0 eee off"
  '';
}

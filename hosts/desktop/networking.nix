{ ... }:
{
  services.resolved.settings.Resolve = {
    DNSSEC = "true";
    Domains = [ ];
    FallbackDNS = [
      "1.1.1.1#cloudflare-dns.com"
      "8.8.8.8#dns.google"
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}

{ config, pkgs, lib, user, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nftables.enable = true;
  };

  time.timeZone = "Europe/Zurich";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  services = {
    resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = "true";
        Domains = [ "~." ];
        FallbackDNS = [ "1.1.1.1#cloudflare-dns.com" "8.8.8.8#dns.google" ];
      };
    };

    syncthing = {
      enable = true;
      user = user;
      group = "users";
      dataDir = "/home/${user}";
      openDefaultPorts = true;
    };

    mullvad-vpn = {
      enable = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  systemd.services.amnezia-vpn-daemon = {
    enable = true;
    description = "AmneziaVPN Daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
  
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.amnezia-vpn}/bin/AmneziaVPN-service";
      Restart = "on-failure";
      RestartSec = 5;
      User = "root";
    };
  };
}

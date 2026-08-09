{ lib, ... }:
{
  networking = {
    hostName = lib.mkDefault "nixos";
    networkmanager.enable = lib.mkDefault true;
    nftables.enable = lib.mkDefault true;
    # wireless.enable = true; # Uncomment for wpa_supplicant
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = lib.mkDefault "Europe/Zurich";

  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = lib.mkDefault "ru_RU.UTF-8";
      LC_IDENTIFICATION = lib.mkDefault "ru_RU.UTF-8";
      LC_MEASUREMENT = lib.mkDefault "ru_RU.UTF-8";
      LC_MONETARY = lib.mkDefault "ru_RU.UTF-8";
      LC_NAME = lib.mkDefault "ru_RU.UTF-8";
      LC_NUMERIC = lib.mkDefault "ru_RU.UTF-8";
      LC_PAPER = lib.mkDefault "ru_RU.UTF-8";
      LC_TELEPHONE = lib.mkDefault "ru_RU.UTF-8";
      LC_TIME = lib.mkDefault "ru_RU.UTF-8";
    };
  };

  services.resolved = {
    enable = lib.mkDefault true;
    settings.Resolve = {
      DNSSEC = lib.mkDefault "allow-downgrade";
      Domains = lib.mkDefault [ "~." ];
      FallbackDNS = lib.mkDefault [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };
}

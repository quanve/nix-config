{ pkgs, user, ... }:
{
  services = {
    flatpak.enable = true;

    gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = true;
    };

    gvfs.enable = true;

    syncthing = {
      enable = true;
      user = user;
      group = "users";
      dataDir = "/home/${user}";
      openDefaultPorts = true;
    };

    mullvad-vpn.enable = true;
  };

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

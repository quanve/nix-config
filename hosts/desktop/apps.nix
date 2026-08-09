{ ... }:
{
  programs = {
    throne = {
      enable = true;
      tunMode.enable = true;
    };

    firejail.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}

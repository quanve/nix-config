{ pkgs, user, ... }:
{
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = [
      "networkmanager"
      "wireshark"
      "libvirtd"
      "docker"
      "wheel"
      "video"
      "input"
      "keys"
    ];
    packages = with pkgs; [ ];
    linger = true;
  };
}

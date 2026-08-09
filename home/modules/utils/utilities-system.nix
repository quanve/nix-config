{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.utils.utilities-system;
in
{
  options.myHome.modules.utils.utilities-system.enable = lib.mkEnableOption "utils/utilities-system";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      android-tools
      # cpulimit
      usbutils
      openssl
      pamixer
      parted
      cmake
      unzip
      aria2
      ncdu
      nmap
      wget
      btop
      tree
      # htop
      dig
      jq
      fd
    ];
  };
}

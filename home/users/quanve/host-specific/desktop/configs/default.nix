{ libx, ... }:
{
  imports = [
    ./foot.nix
    ./zsh.nix
  ];

  xdg.configFile = libx.configBuilder.make {
    hypr = {
      path = ./hypr;
      executable = [ "switch_wallpaper.sh" ];
    };
  };
}

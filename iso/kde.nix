{ inputs, ... }:
{
  imports = [
    ./base.nix
    (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix")
  ];

  isoImage.edition = "kde";
}

{ inputs, ... }:
{
  imports = [
    ./base.nix
    (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  isoImage.edition = "minimal";
}

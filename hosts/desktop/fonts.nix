{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.symbols-only
      jetbrains-mono
      dejavu_fonts
      noto-fonts
    ];
    fontconfig.enable = true;
  };
}

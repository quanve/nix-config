{ config, pkgs, lib, ... }:
let
  cfg = config.myHome.modules.dev.reverse-engineering;
in
{
  options.myHome.modules.dev.reverse-engineering.enable = lib.mkEnableOption "dev/reverse-engineering";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # imhex
      binutils
      radare2
      strace
      ltrace
      ghidra
      cutter
      rizin
      lurk
      file
      gdb
    ];
  };
}

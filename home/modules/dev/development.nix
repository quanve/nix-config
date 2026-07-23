{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    rust-analyzer
    rustfmt
    clippy
    cargo
    rustc

    openjdk25
    python3

    jetbrains.clion
    gcc
    cmake
    gnumake
    pkg-config

    glfw
    libGL
    xorg.libX11

    dpp
  ];
}

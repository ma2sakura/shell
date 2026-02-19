{ config, pkgs, ... }:
{
  # Configure XDG
  home.packages = with pkgs; [
    caido
  ];

  xdg.enable = true;

  xdg.desktopEntries = {
    caido = {
      name = "Caido";
      genericName = "Security auditing toolkit";
      exec = "caido";
      terminal = false;
      categories = [ "Application" "Network" ];
      icon = "security-high";
      settings = {
        StartupWMClass = "caido";
      };
    };
  };
}
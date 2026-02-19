{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inetutils
    nmap
    nmap-unleashed
    caido
    gobuster
  ];
}
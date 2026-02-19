{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nmap
    nmap-unleashed
    caido
    gobuster
  ];
}
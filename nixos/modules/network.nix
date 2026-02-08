{ config, pkgs, ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
    ];
    insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
  
  networking.hosts = {
    "10.129.13.188" = [ "facts.htb" ];
  };
}

{ config, pkgs, ... }:
{
  networking.hostName = "shell";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
    ];
    insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
  
  networking.hosts = {

  };
}

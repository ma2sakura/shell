{ config, pkgs, ... }:
{
  networking.hostName = "shell";
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    dnsovertls = "true";
  };

  networking.firewall.allowedTCPPortRanges = [
      { from = 1330; to = 1340; }
    ];
  
  networking.hosts = {

  };
}

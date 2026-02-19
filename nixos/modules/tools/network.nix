{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inetutils
    nmap
    gobuster
    mullvad
    # nmap-unleashed ## removed as needs workaround fix for XSL still
  ];

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
}
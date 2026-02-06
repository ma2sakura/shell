{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    john
    wordlists
    thc-hydra
  ];
}
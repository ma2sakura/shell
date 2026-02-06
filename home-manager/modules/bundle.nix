{ pkgs, ... }:
{
  imports = [
    ./btop.nix
    ./firefox.nix
    ./nvim.nix
  ];

  home.packages = with pkgs; [
    eza
    lazygit
    bat
    tree
    nixfmt-rfc-style
  ];
}

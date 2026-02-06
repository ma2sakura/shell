{ pkgs, ... }:
{
  users.users.nix = {
    isNormalUser = true;
    description = "nix";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}

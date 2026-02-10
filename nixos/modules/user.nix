{ pkgs, ... }:
{
  users.users.ghost = {
    isNormalUser = true;
    uid = 1001;
    description = "ghost";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}

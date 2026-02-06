{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./modules/bundle.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    username = "nix";
    homeDirectory = "/home/nix";
    stateVersion = "25.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.home-manager.backupFileExtension = "_bak";
}

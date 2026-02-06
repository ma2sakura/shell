{ pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ ];
      theme = "agnoster";
    };
  };
}
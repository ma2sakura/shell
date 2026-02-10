{ config, pkgs, ... }: {

  # Ensure necessary tools are installed
  home.packages = with pkgs; [
    pure-prompt
    chroma
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Native Home Manager Modules for these features
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Environment Variables
    sessionVariables = {
      EDITOR = "nvim";
      ZSH_COLORIZE_TOOL = "chroma";
      ZSH_COLORIZE_CHROMA_FORMATTER = "terminal256";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      # Nix handles history saving, but you can add 'ignorePatterns' here if needed
    };

    oh-my-zsh = {
      enable = true;
      # Theme is set to empty because we load 'pure' manually below
      theme = "";

      plugins = [
        "git"
        "colored-man-pages"
        "gitfast"
        "ionic"
        "npm"
        "ssh"
        "ssh-agent"
        "colorize"
      ];
    };

    # The "Meat" of the config: Custom Logic, Bindings, and Styles
    initExtra = ''
      fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
      autoload -U promptinit; promptinit
      prompt pure

      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

      zstyle :omz:plugins:ssh-agent agent-forwarding yes
      zstyle :omz:plugins:ssh-agent identities id_rsa github_rsa

      # --- Completion Styles (Fish-like) ---
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # FIX: Use three quotes (''') to escape the two quotes in Nix
      zstyle ':completion:*' group-name '''

      zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

      # --- Key Bindings ---
      bindkey '^ ' autosuggest-accept

      zmodload zsh/complist
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      # Fish-like History Search (Up/Down)
      if [[ "''${terminfo[kcuu1]}" != "" ]]; then
        bindkey "''${terminfo[kcuu1]}" history-beginning-search-backward
        bindkey "''${terminfo[kcud1]}" history-beginning-search-forward
      fi

      # Fallback ANSI bindings
      bindkey '\e[A' history-beginning-search-backward
      bindkey '\eOA' history-beginning-search-backward
      bindkey '\e[B' history-beginning-search-forward
      bindkey '\eOB' history-beginning-search-forward

      bindkey '^I' menu-select
      bindkey "$terminfo[kcbt]" menu-select
    '';
  };
}
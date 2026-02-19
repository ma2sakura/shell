{ config, pkgs, ... }:
{
  # Copy Caido CA
  home.file.".local/share/ca/caido-ca.crt".source = ./../extra/ca/caido-ca.crt;

  programs.firefox = {
    enable = true;

    policies = {
      Certificates = {
        Install = [ "${config.home.homeDirectory}/.local/share/ca/caido-ca.crt" ];
      };
    };

    # Default profile
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
      };
    };

    # Profile for Caido proxy
    profiles.caido = {
      id = 1;
      name = "caido";
      isDefault = false;

      settings = {
        "network.proxy.type" = 1;

        "network.proxy.http" = "127.0.0.1";
        "network.proxy.http_port" = 8080;
        "network.proxy.ssl" = "127.0.0.1";
        "network.proxy.ssl_port" = 8080;
        "network.proxy.socks" = "";

        "network.proxy.no_proxies_on" = "localhost, 127.0.0.1, ::1";

        "network.trr.mode" = 5;
      };
    };
  };

  # Configure XDG
  xdg.enable = true;
  xdg.desktopEntries = {
    # The standard Firefox (Default Profile)
    firefox-default = {
      name = "Firefox";
      genericName = "Web Browser";
      exec = "firefox -P default %U";
      terminal = false;
      categories = [ "Application" "Network" "WebBrowser" ];
      icon = "firefox";
      settings = {
        StartupWMClass = "firefox-default";
      };
    };

    # The Hacking Firefox (Caido Profile)
    firefox-caido = {
      name = "Firefox with Caido proxy";
      genericName = "Web Browser for security auditing";
      exec = "firefox -P caido --class firefox-caido %U";
      terminal = false;
      categories = [ "Application" "Network" "WebBrowser" ];
      icon = "security-high";
      settings = {
        StartupWMClass = "firefox-caido";
      };
    };
  };
}
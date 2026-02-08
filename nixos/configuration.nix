{ config, pkgs, pkgs-unstable, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/bundle.nix
  ];

  # Nix Settings & Maintenance
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Deduplicate storage automatically
      auto-optimise-store = true;
    };
    # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable X11
  services.xserver.enable = true;

  # SDDM config - scale for HiDPI
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;

    settings = {
      General = {
        GreeterEnvironment = lib.concatStringsSep "," [
          "QT_SCREEN_SCALE_FACTORS=2"
	        "QT_FONT_DPI=192"
        ];
      };
      X11 = {
        EnableHiDPI = "true";
        ServerArguments= "-nolisten tcp -dpi 192";
      };
    };
  };

  # Enable KDE/Plasma
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasmax11";
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "mac";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Audio support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable SSH service
  services.openssh.enable = true;

  # System-level packages
  environment.systemPackages = with pkgs; [
    vim
    neovim
    lsof
    wget
    dig
    git
    tmux
    openvpn
    home-manager
    uv
    python314
    open-vm-tools
    libxslt
  ];

  # Graphics driver and VM support
  services.xserver.videoDrivers = [ "modesetting" ];
  virtualisation.vmware.guest.enable = true;

  # Start vmware-agent for dispal resize
  systemd.user.services.vmware-user = {
    description = "VMware User Agent";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.open-vm-tools}/bin/vmware-user";
      Restart = "on-failure";
    };
  };

  # Mount VMWare shared storage
  fileSystems."/mnt/shared" = {
    device = ".host:/shared";
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    options = ["umask=22" "uid=1000" "gid=100" "allow_other" "defaults" "auto_unmount"];
  };

  system.stateVersion = "25.11";
}

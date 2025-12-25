# Shared NixOS configuration for all hosts
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../apps/stylix
    ../apps/docker
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Plymouth for nicer boot splash and LUKS prompt (theme set by Stylix)
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;  # Required for Plymouth with LUKS
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [ "quiet" "splash" ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Allow to execute binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # Theme dark for apps
  environment.variables = {
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum-dark";
    XDG_CURRENT_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
  };

  # XDG portal for dark theme detection
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 15d --keep-generations 5";

  services = {
    udisks2.enable = true;  # Auto mount disks
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable GDM with autologin
  services.displayManager.gdm.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "facundo";
  };

  # Workaround for GDM autologin race condition
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  documentation.man = {
    man-db.enable = true;
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fish shell
  programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;

    users.facundo = {
      isNormalUser = true;
      description = "Facundo";
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "python3.13-ecdsa-0.19.1"
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    git
    p7zip
    vscode
    code-cursor
    kitty
    waybar
    dunst
    libnotify
    swww
    rofi
    networkmanagerapplet
    brightnessctl
    bibata-cursors
    hyprland-qtutils
  ];

  virtualisation.libvirtd.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      hostname = config.networking.hostName;
    };
    users = {
      "facundo" = import ../home.nix;
    };
  };

  system.stateVersion = "24.05";
}

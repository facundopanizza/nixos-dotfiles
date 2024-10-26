{ config, pkgs, ... }:

{
  imports = [
    ./apps/hyprland
    ./apps/kitty
  ];

  home.username = "facundo";
  home.homeDirectory = "/home/facundo";

  nixpkgs.config.allowUnfree = true;

  home.file.".config/hypr/hyprland.conf".source = ./apps/hyprland/hyprland.conf;
  home.file.".config/kitty/kitty.conf".source = ./apps/kitty/kitty.conf;
#  home.file.".config/kitty/themes".source = ./apps/kitty/themes;

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, W, exec, kitty"
    ];
  };

  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      test -z $ZELLIJ; and zellij;
      set fish_greeting
    '';
    shellAliases = {
      n = "nvim";
      update = "sudo nixos-rebuild switch --flake .";
      upgrade = "nix flake update";
      sshlightit = "cp ~/.ssh/lightit/* ~/.ssh";
      sshmain = "cp ~/.ssh/main/* ~/.ssh";
      sf = "cd ~/code/spacedev/swordfish";
      ls = "eza -lh --icons --group-directories-first";
      neofetch = ''kitten icat & neofetch --kitty "~/.dotfiles/apps/neofetch/images/Makima-nixos.png"'';
#      kitty = "kitty +kitten themes --reload-in=all Catppuccin-Macchiato";
    };
  };

# Packages that should be installed to the user profile.
  home.packages = with pkgs; [
      neofetch
      eza
      fzf
      qbittorrent
      vesktop
      google-chrome
      mattermost-desktop
      zoom-us
      obs-studio
      gimp
      kdePackages.kdenlive
      handbrake
      dbeaver-bin
      mongodb-compass
      lazydocker
      lazygit
      hyprshot
      devbox
      imagemagick
      loupe
      whatsapp-for-linux
      davinci-resolve
      obs-studio
      anki
      nwg-look
      insomnia
      dolphin
  ];

# basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Facundo Panizza";
    userEmail = "facundo@panizza.dev";
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;

    settings = {
#      theme = "catppuccin-macchiato";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.stateVersion = "24.05";

# Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

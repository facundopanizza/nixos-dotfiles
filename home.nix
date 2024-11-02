{ config, pkgs, ... }:

{
  imports = [
    ./apps/hyprland
    ./apps/kitty
    ./apps/waybar
  ];

  home.username = "facundo";
  home.homeDirectory = "/home/facundo";

  nixpkgs.config.allowUnfree = true;

  home.file.".config/hypr/hyprland.conf".source = ./apps/hyprland/hyprland.conf;
  home.file.".config/kitty/kitty.conf".source = ./apps/kitty/kitty.conf;
  home.file."Wallpapers".source = ./wallpapers;
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
      kamal=''docker run -it --rm -v "''$PWD:/workdir" -v "''$SSH_AUTH_SOCK:/ssh-agent" -v /var/run/docker.sock:/var/run/docker.sock -e "SSH_AUTH_SOCK=/ssh-agent" ghcr.io/basecamp/kamal:latest'';
#      kitty = "kitty +kitten themes --reload-in=all Catppuccin-Macchiato";
    };
#    plugins = [
#      {
#        name = "fish-ssh-agent";
#        src = pkgs.fetchFromGitHub {
#          owner = "jethrokuan";
#          repo = "fish-ssh-agent";
#          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
#          sha256 = "1h10jgnml12bxgp7inz8v8mzh7v9740wig3gpifx8lryipsy2fqs";
#        };
#      }
#    ];
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent.enable = true;

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
      audacity
      nodejs
      screen
      postgresql # Only for the client
      mariadb # Only for the client
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

{ config, pkgs, lib, inputs, hostname, ... }:

{
  imports = [
    ./apps/hyprland
    ./apps/kitty
    ./apps/waybar
    ./apps/rofi
    ./apps/gcloud
  ];

  home.username = "facundo";
  home.homeDirectory = "/home/facundo";

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    videos = "${config.home.homeDirectory}/Videos";
    pictures = "${config.home.homeDirectory}/Pictures";
    music = "${config.home.homeDirectory}/Music";
    desktop = "${config.home.homeDirectory}/Desktop";
    templates = "${config.home.homeDirectory}/Templates";
    publicShare = "${config.home.homeDirectory}/Public";
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "python3.13-ecdsa-0.19.1"
  ];

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
      # Restore last directory
      if test -f ~/.local/share/fish/last_dir
        cd (cat ~/.local/share/fish/last_dir)
      end

      # Save directory on each change
      function __save_dir --on-variable PWD
        mkdir -p ~/.local/share/fish
        echo $PWD > ~/.local/share/fish/last_dir
      end

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
      # neofetch = ''kitten icat & neofetch --kitty "~/.dotfiles/apps/neofetch/images/Makima-nixos.png"'';
      kamal=''docker run -it --rm -v "''$PWD:/workdir" -v "''$SSH_AUTH_SOCK:/ssh-agent" -v /var/run/docker.sock:/var/run/docker.sock -e "SSH_AUTH_SOCK=/ssh-agent" ghcr.io/basecamp/kamal:latest'';
      newdirenv = ''curl "https://gist.githubusercontent.com/facundopanizza/d9158d9c3e9583853455a0017887e240/raw/flake.nix" -o flake.nix && echo "use flake" >> .envrc && direnv allow'';
      nde = ''curl "https://gist.githubusercontent.com/facundopanizza/d9158d9c3e9583853455a0017887e240/raw/flake.nix" -o flake.nix && echo "use flake" >> .envrc && direnv allow'';
      nenv = ''curl "https://gist.githubusercontent.com/facundopanizza/d9158d9c3e9583853455a0017887e240/raw/flake.nix" -o flake.nix && echo "use flake" >> .envrc && direnv allow'';
      htop = "btop";
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
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        identitiesOnly = true;
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
      };
      "github-personal.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa_personal";
      };
    };
  };

#  programs.looking-glass-client.enable = true;

  services.ssh-agent.enable = true;

# Packages that should be installed to the user profile.
  home.packages = with pkgs; [
      neofetch
      eza
      fzf
      qbittorrent
      vesktop
      brave
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
      wasistlos
      davinci-resolve
      obs-studio
      anki
      nwg-look
      yaak

      # For dolphin
      kdePackages.dolphin
      kdePackages.qtwayland
      kdePackages.qtsvg
      kdePackages.kio-fuse
      kdePackages.kio-extras
      kdePackages.ark # File extractor for dolphin
      # End for Dolphin

      audacity
      nodejs
      screen
      postgresql # Only for the client
      mariadb # Only for the client
      direnv
      wine
      winetricks
      persepolis
      lutris
      protonplus
      libreoffice-qt6
      zathura
      btop
      openssl
      # squirreldisk # marked as broken
      mpv
      heroic
      terraform
      morgen
      pciutils
      gparted
      kubectl
      slack
      freecad
      inkscape
      dig
      azure-cli
      awscli2
      claude-code
  ];

# basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings.user.name = "Facundo Panizza";
    settings.user.email = "facundo@panizza.dev";
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = lib.mkForce "prefer-dark";
        gtk-theme = lib.mkForce "Adwaita-dark";
      };
    };
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
    BROWSER = "brave";
    TERMINAL = "alacritty";
  };

  home.stateVersion = "24.05";

# Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

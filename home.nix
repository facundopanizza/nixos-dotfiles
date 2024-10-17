{ config, pkgs, ... }:

{
	home.username = "facundo";
	home.homeDirectory = "/home/facundo";

	nixpkgs.config.allowUnfree = true;

	# Packages that should be installed to the user profile.
	home.packages = with pkgs; [
		neofetch
			eza
			fzf
			qbittorrent
			discord
			google-chrome
			mattermost-desktop
			zoom-us
			obs-studio
			gimp
			kdePackages.kdenlive
			handbrake
			postgresql
			mysql
			dbeaver-bin
			mongodb-compass
	];

# basic configuration of git, please change to your own
	programs.git = {
		enable = true;
		userName = "Facundo Panizza";
		userEmail = "facundo@panizza.dev";
	};

# alacritty - a cross-platform, GPU-accelerated terminal emulator
	programs.alacritty = {
		enable = true;
		settings = {
			env.TERM = "xterm-256color";
			font = {
				normal = {
					family = "FiraCode Nerd Font";
				};
				size = 12;
			};
			colors = {
				primary = {
					background = "#24273a";
					foreground = "#cad3f5";
					dim_foreground = "#8087a2";
					bright_foreground = "#cad3f5";
				};

				cursor = {
					text = "#24273a";
					cursor = "#f4dbd6";
				};

				vi_mode_cursor = {
					text = "#24273a";
					cursor = "#b7bdf8";
				};

				search = {
					matches = {
						foreground = "#24273a";
						background = "#a5adcb";
					};
					focused_match = {
						foreground = "#24273a";
						background = "#a6da95";
					};
				};

				footer_bar = {
					foreground = "#24273a";
					background = "#a5adcb";
				};

				hints = {
					start = {
						foreground = "#24273a";
						background = "#eed49f";
					};
					end = {
						foreground = "#24273a";
						background = "#a5adcb";
					};
				};

				selection = {
					text = "#24273a";
					background = "#f4dbd6";
				};

				normal = {
					black = "#494d64";
					red = "#ed8796";
					green = "#a6da95";
					yellow = "#eed49f";
					blue = "#8aadf4";
					magenta = "#f5bde6";
					cyan = "#8bd5ca";
					white = "#b8c0e0";
				};

				bright = {
					black = "#5b6078";
					red = "#ed8796";
					green = "#a6da95";
					yellow = "#eed49f";
					blue = "#8aadf4";
					magenta = "#f5bde6";
					cyan = "#8bd5ca";
					white = "#a5adcb";
				};

				dim = {
					black = "#494d64";
					red = "#ed8796";
					green = "#a6da95";
					yellow = "#eed49f";
					blue = "#8aadf4";
					magenta = "#f5bde6";
					cyan = "#8bd5ca";
					white = "#b8c0e0";
				};

				indexed_colors = [
				{ index = 16; color = "#f5a97f"; }
				{ index = 17; color = "#f4dbd6"; }
				];
			};

			scrolling.multiplier = 5;
			selection.save_to_clipboard = true;
		};
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			n = "nvim";
			update = "sudo nixos-rebuild switch --flake .";
			upgrade = "nix flake update";
		};
		history = {
			size = 10000;
			path = "${config.xdg.dataHome}/zsh/history";
		};
		zplug = {
			enable = true;
			plugins = [
			{ name = "zsh-users/zsh-syntax-highlighting"; }
			{ name = "zsh-users/zsh-autosuggestions"; }
			{ name = "zsh-users/zsh-completions"; }
			{ name = "zsh-users/zsh-history-substring-search"; }
			{ name = "Aloxaf/fzf-tab"; }
			{ name = "themes/robbyrussell"; tags = [ as:theme from:oh-my-zsh ]; }
			];
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

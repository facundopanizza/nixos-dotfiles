{ config, pkgs, ... }:

{
  home.file.".config/waybar/config.jsonc".source = ./config.jsonc;
}

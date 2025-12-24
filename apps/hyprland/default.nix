{ hostname, ... }:

let
  hyprlandConfig = if hostname == "amaterasu"
    then ./hyprland-amaterasu.conf
    else ./hyprland-harakiri.conf;
in
{
  home.file.".config/hypr/hyprland.conf".source = hyprlandConfig;
  home.file.".config/hypr/hyprland-base.conf".source = ./hyprland-base.conf;
  home.file.".config/hypr/start.sh".source = ./start.sh;
}

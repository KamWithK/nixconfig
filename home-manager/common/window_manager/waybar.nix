{ lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      reload_style_on_change = true;
      exclusive = true;
      fixed-center = true;
      position = "top";
      layer = "top";
      margin-top = 10;
      margin-left = 10;
      margin-right = 10;

      tray.spacing = 10;

      modules-left = [
        "hyprland/workspaces"
        "river/tags"
      ];
      modules-center = [
        "clock#date"
        "clock#time"
      ];
      modules-right = [
        "pulseaudio"
        "network"
        "tray"
      ];

      "clock#date" = {
        "format" = "   {:%d/%m/%Y}";
      };
      "clock#time" = {
        "format" = "   {:%H:%M:%S}";
        "interval" = 1;
      };

      "pulseaudio" = {
        format = "   {volume}%";
        on-click = "pavucontrol";
      };

      "network" = {
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        format-ethernet = "  {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
      };

      "hyprland/workspaces" = {
        on-click = "activate";
        format = "{icon}";
        persistent-workspaces."*" = 5;
      };

      "river/tags" = {
        num-tags = 5;
      };
    };

    style = lib.mkAfter ''${builtins.readFile ../../../dotfiles/waybar.css}'';
  };
}

{ pkgs, ... }:

{
  home.sessionVariables = {
    # NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
  # config.programs.chromium.commandLineArgs = [ "--enable-wayland-ime" ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";

      windowrule = [ "workspace 5, discord" ];
      windowrulev2 = [ "workspace 5, initialTitle:^(Spotify( Premium)?)$" ];

      bind = [
        "$mod, Q, exec, alacritty"
        "$mod, W, exec, librewolf"
        "$mod, E, exec, emacsclient -c -a emacs"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, S, exec, rofi -show drun -display-drun '' -show-icons"
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, volumectl -u up"
        ", XF86AudioLowerVolume, exec, volumectl -u down"
      ];

      bindl = [
        ", XF86AudioMute, exec, volumectl toggle-mute"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next "
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      general = {
        gaps_in = 3;
        gaps_out = 10;
        border_size = 3;
      };

      decoration.rounding = 3;
    };
  };

  home.packages = with pkgs; [
    swaynotificationcenter
    wl-clipboard
    grim
    slurp
    unstable.xwaylandvideobridge
  ];
}

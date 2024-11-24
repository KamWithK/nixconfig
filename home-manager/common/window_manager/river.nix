{
  pkgs,
  lib,
  config,
  ...
}:

{
  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings =
      with config.lib.stylix.colors;
      with config.stylix;
      with lib;
      let
        numTags = 5;
        listToAttrSet = list: listToAttrs (imap (i: nameValuePair (toString i)) list);
        tagMap = foldl' (x: y: x ++ [ (last x * 2) ]) [ 1 ] (genList (_: [ 1 ]) (numTags - 1));
        tagMapSet = listToAttrSet tagMap;
        tagMapStrSet = listToAttrSet (map toString tagMap);
        tagOr = t1: t2: toString (bitOr (tagMapSet.${toString t1}) (tagMapSet.${toString t2}));
        tagKeys = concatMapAttrs (index: tag: {
          "Super ${index}" = "set-focused-tags ${tag}";
          "Super+Shift ${index}" = "set-view-tags ${tag}";
          "Super+Control ${index}" = "toggle-focused-tags ${tag}";
          "Super+Shift+Control ${index}" = "set-view-tags ${tag}";
        }) tagMapStrSet;
      in
      {
        default-layout = "bsp-layout";
        spawn = [
          "'river-bsp-layout --inner-gap 3 --outer-gap 10 --split-perc 0.5'"
          "swww-daemon"
        ];
        focus-follows-cursor = "always";
        set-cursor-warp = "on-output-change";

        border-width = 3;
        border-color-focused = "0x${base0D}";
        border-color-unfocused = "0x${base03}";
        border-color-urgent = "0x${base08}";

        declare-mode = [
          "locked"
          "normal"
          "passthrough"
        ];

        map = {
          normal = tagKeys // {
            "Super Q" = "spawn foot";
            "Super W" = "spawn firefox";
            "Super S" = "spawn \"rofi -show drun -show-icons -display-drun ''\"";
            "Super+Shift S" = "spawn 'grim -g \"$(slurp)\" - | wl-copy'";

            "Super C" = "close";
            "Super F" = "toggle-fullscreen";
            "Super V" = "toggle-float";

            "Super H" = "focus-view left";
            "Super J" = "focus-view down";
            "Super K" = "focus-view up";
            "Super L" = "focus-view right";
            "Super+Shift H" = "swap left";
            "Super+Shift J" = "swap down";
            "Super+Shift K" = "swap up";
            "Super+Shift L" = "swap right";

            "None XF86AudioLowerVolume" = "spawn 'volumectl -u down'";
            "None XF86AudioRaiseVolume" = "spawn 'volumectl -u up'";
            "None XF86AudioMute" = "spawn 'volumectl toggle-mute'";
            "None XF86AudioPlay" = "spawn 'playerctl play-pause'";
            "None XF86AudioMedia" = "spawn 'playerctl play-pause'";
            "None XF86AudioNext" = "spawn 'playerctl next'";
            "None XF86AudioPrev" = "spawn 'playerctl previous'";
          };
        };

        rule-add = {
          "-app-id" = {
            "'firefox'" = "ssd";
            "'thunar'" = "ssd";
            "'steam'" = "ssd";
            "'emacs'" = "ssd";
            "'org.pwmt.zathura'" = "ssd";
            "'org.pulseaudio.pavucontrol'" = "ssd";
            "'.blueman-manager-wrapped'" = "ssd";
            "'org.gnome.Boxes'" = "ssd";
            "'org.nicotine_plus.Nicotine'" = "ssd";
            "'discord'" = "tags '${tagOr 1 5}'";
            "'org.squidowl.halloy'" = "tags '${tagOr 1 5}'";
            "'Spotify'" = "tags '${tagMapStrSet."5"}'";
          };
        };

        set-repeat = "50 300";
        xcursor-theme = cursor.name;
      };
  };

  home.packages = with pkgs; [
    river-bsp-layout
  ];
}

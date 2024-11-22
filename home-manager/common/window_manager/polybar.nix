{ ... }:

{
  config.services.polybar = {
    enable = true;
    script = "polybar bar &";

    config = {
      "bar/bar" = {
        bottom = false;
        fixed-center = true;
        font-0 = "FontAwesome:size=10";
        font-1 = "Noto Sans JP:size=10";

        modules-left = "bspwm";
        modules-center = "date";
        tray-position = "right";
      };

      "module/bspwm" = {
        type = "internal/bspwm";
        enable-scroll = false;
        label-focused-padding = 2;
        label-empty-padding = 2;
        label-occupied-padding = 2;
        label-urgent-padding = 2;
        label-separator = "|";
        label-separator-padding = "2";
      };

      "module/date" = {
        type = "internal/date";

        interval = "1.0";

        time = "   %d-%m-%Y      %H:%M:%S";

        format = "<label>";
        format-padding = 4;

        label = "%time%";
      };

      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        label = "%title%";
        label-maxlen = 70;
      };
    };
  };
}

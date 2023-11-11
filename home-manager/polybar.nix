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

        modules-left = "date";
        modules-center = "title";
        tray-position = "right";
      };

      "module/date" = {
        type = "internal/date";

        interval = "1.0";

        time = "%H:%M:%S";
        time-alt = "%Y-%m-%d%";

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

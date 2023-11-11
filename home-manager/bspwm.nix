{ ... }:

{
  config.xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 7;
      window_gap = 5;
      focused_border_color = "#371c4b";
      pointer_follows_monitor = true;
      focus_follows_pointer = true;
    };
    monitors."any" = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
  };

  config.services.sxhkd = {
    enable = true;
    keybindings = {
      "super + q" = "alacritty";
      "super + w" = "firefox";
      "super + s" = "rofi -show drun -show-icons";
      "super + Escape" = "pkill -USR1 -x sxhkd & bspc wm -r";
      "super + c" = "bspc node -c";
      "super + m" = "bspc quit";
      "super + g" = "bspc -s biggest.window";
      "super + {_,shift+}{Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}";
      "super + {_,shift + }{1-9}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "XF86Audio{LowerVolume,RaiseVolume}" = "volumectl -u {down,up}";
      "XF86AudioMute" = "volumectl toggle-mute";
      "XF86Audio{Play,Next,Prev}" = "playerctl {play-pause,next,previous}";
    };
  };

  # config.services.polybar = {
  #   enable = true;
  # };
}

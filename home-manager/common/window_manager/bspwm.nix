{ ... }:

{
  imports = [ ./polybar.nix ];

  config.programs.rofi = {
    enable = true;
  };

  config.xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 7;
      window_gap = 5;
      pointer_follows_monitor = true;
      focus_follows_pointer = true;
    };
    monitors."any" = [
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
    ];
    startupPrograms = [
      "killall polybar; polybar bar"
    ];
  };

  config.services.sxhkd = {
    enable = true;
    keybindings = {
      "super + q" = "alacritty";
      "super + w" = "firefox";
      "super + s" = "rofi -show drun -display-drun '' -show-icons";
      "super + shift + s" = "flameshot gui --clipboard --accept-on-select";
      "super + Escape" = "pkill -USR1 -x sxhkd & bspc wm -r & killall polybar; polybar bar &";
      "super + c" = "bspc node -c";
      "super + m" = "bspc quit";
      "super + g" = "bspc -s biggest.window";
      "super + {_,shift+}{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
      "super + {_,shift+}{Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}";
      "super + {_,shift + }{1-9}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "XF86Audio{LowerVolume,RaiseVolume}" = "volumectl -u {down,up}";
      "XF86AudioMute" = "volumectl toggle-mute";
      "XF86Audio{Play,Media,Next,Prev}" = "playerctl {play-pause,play-pause,next,previous}";
    };
  };
}

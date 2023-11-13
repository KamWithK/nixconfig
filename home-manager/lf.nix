{ pkgs, ... }:

{
  programs.lf = {
    enable = true;
    package = pkgs.unstable.lf;

    settings = {
      preview = true;
      hidden = false;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    commands = {
      q = "quit";
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -ax "$fx"'';
      editor-open = "$$EDITOR $f";
      mkdir = ''
      ''${{
        printf "Directory Name: "
        read DIR
        mkdir $DIR
      }}
      '';
    };

    keybindings = {
      "." = "set hidden!";
      "<enter>" = "open";
      ee = "editor-open";
      go = "dragon-out";
      c = "mkdir";
    };
  };

  programs.zsh.shellAliases = {
    "lfcp" = ''cd "$(command lf -print-last-dir "$@")"'';
  };

  # Sourc - https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example
  xdg.configFile."lf/icons".source = ../dotfiles/.icons;

  home.packages = with pkgs; [
    xdragon
  ];
}

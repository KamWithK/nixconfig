{ pkgs, ... }:
{
  # Custom fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    # nerd-fonts
    font-awesome
    google-fonts
    ipafont
    noto-fonts
    noto-fonts-cjk-sans
  ];

  # Default fonts
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "Noto Sans JP"
      "Klee One Semibold"
    ];
    sansSerif = [
      "DejaVu Sans"
      "Noto Sans JP"
      "Klee One Semibold"
    ];
    serif = [
      "DejaVu Sans"
      "Noto Sans JP"
      "Klee One Semibold"
    ];
  };
}

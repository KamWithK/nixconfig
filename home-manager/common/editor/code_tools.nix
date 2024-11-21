{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.pandoc.enable = true;
  programs.lazygit.enable = true;

  home.packages = with pkgs.unstable; [
    cargo
    rustc
    go

    nodePackages.npm
    pnpm
    typescript
    web-ext

    # android-studio
  ];
}

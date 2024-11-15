{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.pandoc.enable = true;
  programs.lazygit.enable = true;

  home.packages =
    (with pkgs.nodePackages; [
      npm
      pnpm
      typescript
      web-ext
    ])
    ++ (with pkgs; [
      cargo
      rustc
      go

      # android-studio
    ]);
}

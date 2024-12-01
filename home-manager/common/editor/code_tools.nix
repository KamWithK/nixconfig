{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.pandoc.enable = true;
  programs.lazygit.enable = true;
}

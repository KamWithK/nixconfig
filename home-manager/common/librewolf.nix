{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    package = pkgs.unstable.librewolf;
    settings = {
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = true;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;
    };
  };
}

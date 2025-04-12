{ ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}

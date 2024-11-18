{ config, pkgs, ... }:
{
  age.secrets.hotspot.file = ../../secrets/hotspot.age;

  systemd = {
    services.create_secret_ap = {
      wantedBy = [ "multi-user.target" ];
      description = "Create AP Service";
      after = [ "network.target" ];
      restartTriggers = [ config.age.secrets.hotspot.path ];
      serviceConfig = {
        ExecStart = "${pkgs.linux-wifi-hotspot}/bin/create_ap --config ${config.age.secrets.hotspot.path}";
        KillSignal = "SIGINT";
        Restart = "on-failure";
      };
    };
  };

  environment.systemPackages = with pkgs; [ linux-wifi-hotspot ];
}

{ ... }:
{
  services.syncthing = {
    enable = true;

    user = "kamwithk";
    key = "/etc/syncthing/key.pem";
    cert = "/etc/syncthing/cert.pem";

    dataDir = "/home/kamwithk";
    configDir = "/home/kamwithk/.config/syncthing";
    openDefaultPorts = true;

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "Phone" = {
          id = "NUVCFFL-LWNKYUC-J2QALHA-YVRJ25V-BO2FV3I-4LR655O-POUC5Y6-BRI42QN";
        };
      };
      folders = {
        "Org" = {
          path = "/home/kamwithk/org";
          devices = [ "Phone" ];
        };
      };
    };
  };

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}

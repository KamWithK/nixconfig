let
  kamwithk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII97M4TNr8Lz3vTng4Sia5E6xmliMpMLyBDgtASeU/cX";
  gigatop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwlRAJ/vMRGmgKWIEY3u0SDjBCM2Tp5Is/MrPg2hhrL";
  everyone = [
    gigatop
    kamwithk
  ];
in
{
  "caddy.age".publicKeys = everyone;
  "hotspot.age".publicKeys = everyone;
  # "navidrome.age".publicKeys = everyone;
}

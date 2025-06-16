let
  kamwithk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ1S0hWUaZpbQjkO/Vnhh3OE6jaSYwnsvuYyP1yiMEH8";
  gigatop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILeKnpwb6dTEfhX0D1jQoweGI/QDLldPSTuw78SgxJNv";
  everyone = [
    gigatop
    kamwithk
  ];
in
{
  "caddy.age".publicKeys = everyone;
  "hotspot.age".publicKeys = everyone;
  "navidrome.age".publicKeys = everyone;
}

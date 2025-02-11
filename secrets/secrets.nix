let
  kamwithk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEstPeVQTZ1HfCTUCWrrrhQVibh5EKf50+08n4g1mi9";
  gigatop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkxTFszbsngfie2MQKpMRO96cYG95Wb0QGzk1RVYj5B";
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

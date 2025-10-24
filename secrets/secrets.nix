let
  kamwithk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp8sfRCk3ttMLkw0BS9njIxjRpFbnefsW3imV9Wn5YS";
  gigatop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA/K1Zj7iD7yi4mDa1adWeQSV8XOMNp2efsYUm2bVu65";
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

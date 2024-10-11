{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock-origin
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # privacy-badger
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      "ldpochfccmkkmhdbclfhpagapcfdljkj" # decentraleyes
      "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
      "nffaoalbilbmmfgbnbgppjihopabppdk" # videospeed
    ];
  };
}

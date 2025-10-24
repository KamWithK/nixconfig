{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Kamron Bhavnagri";
      email = "kamwithk@tuta.io";
    };
  };
  programs.gh.enable = true;
}

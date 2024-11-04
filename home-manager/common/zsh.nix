{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      unsetopt PROMPT_SP
      pokeget random --hide-name
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  home.packages = with pkgs; [ pokeget-rs ];
}

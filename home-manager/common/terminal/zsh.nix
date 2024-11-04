{ ... }:

{
  programs.zsh = {
    enable = false;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      unsetopt PROMPT_SP
      pokeget random --hide-name
    '';
  };
}

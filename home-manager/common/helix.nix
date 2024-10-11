{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        true-color = true;
        line-number = "relative";
        auto-save = true;
        color-modes = true;
        soft-wrap.enable = true;
      };
      keys.normal.esc = ["collapse_selection" "keep_primary_selection"];
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
    SUDO_EDITOR = "hx";
    SYSTEMD_EDITOR = "hx";
    VISUAL = "hx";
  };

  home.packages = with pkgs.nodePackages; [
    pnpm
    typescript
    typescript-language-server
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    bash-language-server
    pkgs.unstable.nodePackages.yaml-language-server
    svelte-language-server
    pkgs.nil
    web-ext
  ];
}

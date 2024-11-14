{ pkgs, ... }:

{
  home.packages =
    (with pkgs.nodePackages; [ prettier ])
    ++ (with pkgs.master; [ vtsls ])
    ++ (with pkgs; [
      marksman
      markdownlint-cli2
      nil
      dockerfile-language-server-nodejs
      bash-language-server
      rust-analyzer
      gotools
      gopls
      lua-language-server
      stylua
      vscode-langservers-extracted
      typescript-language-server
      tailwindcss-language-server
      svelte-language-server
      yaml-language-server
      libxml2
      ispell
      nixfmt-rfc-style
      shellcheck
      shfmt
    ]);
}

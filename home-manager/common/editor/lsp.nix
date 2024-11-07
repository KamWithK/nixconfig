{ pkgs, ... }:

{
  home.packages =
    (with pkgs.nodePackages; [
      typescript-language-server
      dockerfile-language-server-nodejs
      bash-language-server
      prettier
    ])
    ++ (with pkgs.unstable.nodePackages; [ yaml-language-server ])
    ++ (with pkgs.unstable; [
      svelte-language-server
      marksman
      markdownlint-cli2
    ])
    ++ (with pkgs; [
      nil
      rust-analyzer
      gotools
      gopls
      lua-language-server
      stylua
      vscode-langservers-extracted
      tailwindcss-language-server
      libxml2
      ispell
      nixfmt-rfc-style
      shellcheck
      shfmt
    ]);
}

{ pkgs, ... }:

{
  home.packages =
    (with pkgs.nodePackages; [
      typescript-language-server
      dockerfile-language-server-nodejs
      bash-language-server
    ])
    ++ (with pkgs.unstable.nodePackages; [ yaml-language-server ])
    ++ (with pkgs.unstable; [ svelte-language-server ])
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

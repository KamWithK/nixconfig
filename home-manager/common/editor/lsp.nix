{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bash-language-server
    yaml-language-server
    dockerfile-language-server
    vtsls
    typescript-language-server
    nodePackages.prettier
    svelte-language-server
    marksman
    markdownlint-cli2
    nil
    nixd
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
  ];
}

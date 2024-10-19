{ pkgs, ... }:

{
  home.packages =
    (with pkgs.nodePackages; [
      npm
      pnpm
      typescript
      typescript-language-server
      dockerfile-language-server-nodejs
      bash-language-server
      pkgs.unstable.nodePackages.yaml-language-server
      svelte-language-server
      web-ext
    ])
    ++ (with pkgs; [
      gh
      ripgrep
      fd
      nil
      gotools
      vscode-langservers-extracted
      libxml2
      ispell
      nixfmt-rfc-style
      shellcheck
      shfmt
      pandoc
    ]);
}

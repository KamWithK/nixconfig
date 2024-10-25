{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.lazygit.enable = true;

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
      cargo
      rustc
      rust-analyzer
      go
      gotools
      gopls
      vscode-langservers-extracted
      libxml2
      ispell
      nixfmt-rfc-style
      shellcheck
      shfmt
      pandoc
    ]);
}

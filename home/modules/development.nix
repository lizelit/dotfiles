{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup

    lean4

    nil nixd

    marksman

    (python3.withPackages (ps: with ps; [
      numpy
    ]))
    pyright black isort ruff

    lldb

    openjdk

    openssl pkg-config

    nodejs

    pnpm

    libiconv
    pkg-config
  ];


  programs.git = {
    enable = true;
    settings.user.name = "lizelit";
    settings.user.email = "lizelit.you@gmail.com";
  };
}

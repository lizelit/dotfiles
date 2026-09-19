{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup

    nil nixd

    marksman

    (python3.withPackages (ps: with ps; [
      numpy
    ]))
    pyright black isort ruff

    lldb

    openjdk

    openssl pkg-config libiconv

    nodejs

    pnpm

    libiconv
    pkg-config

    fourmolu

    firebase-tools

    ruby

    docker docker-compose

    pipx

    texliveFull texlab

    spotify-player spotifyd

    # concord-tui
  ];


  programs.git = {
    enable = true;
    settings.user.name = "lizelit";
    settings.user.email = "lizelit.you@gmail.com";
  };
}

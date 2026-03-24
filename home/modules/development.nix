{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup

    ghc stack haskell-language-server fourmolu

    lean4

    (python3.withPackages (ps: with ps; [
      numpy
    ]))
    pyright black isort ruff

    lldb

    openjdk

    openssl pkg-config

    nodejs

    pnpm
  ];

  programs.git = {
    enable = true;
    settings.user.name = "lizelit";
    settings.user.email = "lizelit.you@gmail.com";
  };
}

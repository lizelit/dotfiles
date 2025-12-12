{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustc cargo rust-analyzer rustfmt clippy

    ghc stack haskell-language-server fourmolu

    (python3.withPackages (ps: with ps; [
      numpy
    ]))
    pyright black isort ruff
    
    lldb
  ];

  programs.git = {
    enable = true;
    settings.user.name = "lizelit";
    settings.user.email = "lizelit.you@gmail.com";
  };
}

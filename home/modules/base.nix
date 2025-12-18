{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd tree skim bat delta eza fastfetch pay-respects
    bottom
    yazi lazygit zellij
    helix-gpt
    nix-search-cli
  ];
}

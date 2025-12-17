{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd tree fzf bat delta eza fastfetch pay-respects
    btop
    yazi lazygit zellij
    helix-gpt
  ];
}

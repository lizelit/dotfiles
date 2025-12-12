{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd tree fzf bat delta eza fastfetch
    btop
    yazi lazygit zellij
  ];
}

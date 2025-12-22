{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd skim bat delta eza fastfetch pay-respects
    bottom
    yazi lazygit zellij
    helix-gpt
    nix-search-cli
  ];

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep fd skim bat delta eza fastfetch
    bottom
    yazi lazygit zellij
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

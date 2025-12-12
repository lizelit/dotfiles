{ config, lib, pkgs, username, homeDirectory, ... }:

{
  home.username = lib.mkForce username;
  home.homeDirectory = lib.mkForce homeDirectory;
  home.stateVersion = "24.11";
  
  programs.home-manager.enable = true;

  imports = [
    ./modules/alacritty.nix
    ./modules/base.nix
    ./modules/btop.nix
    ./modules/development.nix
    ./modules/editors.nix
    ./modules/terminal.nix
    ./modules/utilities.nix
    ./modules/zellij.nix
  ];
}
